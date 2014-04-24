/* session.c -- user windowing interface to Info.
   $Id$

   Copyright 1993, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
   2004, 2007, 2008, 2009, 2011, 2012, 2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   Originally written by Brian Fox. */

#include "info.h"
#include "search.h"
#include "man.h"

#ifndef __MINGW32__
#include <sys/ioctl.h>
#endif
#ifdef __MINGW32__
# define read(f,b,s)	w32_read(f,b,s)
# define _read(f,b,s)	w32_read(f,b,s)
#endif

#if defined (HAVE_SYS_TIME_H)
#  include <sys/time.h>
#  define HAVE_STRUCT_TIMEVAL
#endif /* HAVE_SYS_TIME_H */

static void info_gc_file_buffers (void);

static void info_clear_pending_input (void);
static void info_set_pending_input (unsigned char key);
static void info_handle_pointer (char *label, WINDOW *window);
static void display_info_keyseq (int expecting_future_input);
char *node_printed_rep (NODE *node);

static REFERENCE *select_menu_digit (WINDOW *window, unsigned char key);

/* Warning! Any change to the order of the commands defined with
   DECLARE_INFO_COMMAND in this file results in an incompatible .info
   format, and key bindings will be incorrectly assigned until infokey
   is rerun. */

/* **************************************************************** */
/*                                                                  */
/*                   Running an Info Session                        */
/*                                                                  */
/* **************************************************************** */

/* The place that we are reading input from. */
static FILE *info_input_stream = NULL;

/* The last executed command. */
VFunction *info_last_executed_command = NULL;

/* Becomes non-zero when 'q' is typed to an Info window. */
int quit_info_immediately = 0;

/* Array of structures describing for each window which nodes have been
   visited in that window. */
INFO_WINDOW **info_windows = NULL;

/* Where to add the next window, if we need to add one. */
static size_t info_windows_index = 0;

/* Number of slots allocated to `info_windows'. */
static size_t info_windows_slots = 0;

/* Whether to use regexps or not for search.  */
static int use_regex = 1;

/* Minimal length of a search string */
int min_search_length = 1;

void remember_window_and_node (WINDOW *window, NODE *node);
void forget_window_and_nodes (WINDOW *window);
void display_startup_message_and_start (void);

/* Begin an info session finding the nodes specified by FILENAME and NODENAMES.
   For each loaded node, create a new window.  Always split the largest of the
   available windows. */
void
begin_multiple_window_info_session (char *filename, char **nodenames)
{
  register int i;
  WINDOW *window = NULL;

  for (i = 0; nodenames[i]; i++)
    {
      NODE *node;

      node = info_get_node (filename, nodenames[i], PARSE_NODE_DFLT);

      if (!node)
        break;

      /* If this is the first node, initialize the info session. */
      if (!window)
        {
          initialize_info_session (node, 1);
          window = active_window;
        }
      else
        {
          /* Find the largest window in WINDOWS, and make that be the active
             one.  Then split it and add our window and node to the list
             of remembered windows and nodes.  Then tile the windows. */
          WINDOW *win, *largest = NULL;
          int max_height = 0;

          for (win = windows; win; win = win->next)
            if (win->height > max_height)
              {
                max_height = win->height;
                largest = win;
              }

          if (!largest)
            {
              display_update_display (windows);
              info_error ("%s", msg_cant_find_window);
              info_session ();
              exit (EXIT_SUCCESS);
            }

          active_window = largest;
          window = window_make_window (node);
          if (window)
            {
              window_tile_windows (TILE_INTERNALS);
              remember_window_and_node (window, node);
            }
          else
            {
              display_update_display (windows);
              info_error ("%s", msg_win_too_small);
              info_session ();
              exit (EXIT_SUCCESS);
            }
        }
    }
  display_startup_message_and_start ();
}

/* Start an info session with INITIAL_NODE. */
void
begin_info_session (NODE *initial_node)
{
  initialize_info_session (initial_node, 1);
  display_startup_message_and_start ();
}

void
display_startup_message_and_start (void)
{
  char *format;

  format = replace_in_documentation
    (_("Welcome to Info version %s. Type \\[get-help-window] for help, \\[menu-item] for menu item."),
     0);

  window_message_in_echo_area (format, VERSION, NULL);
  info_session ();
}

/* Run an info session with an already initialized window and node. */
void
info_session (void)
{
  display_update_display (windows);
  info_last_executed_command = NULL;
  info_read_and_dispatch ();
  /* On program exit, leave the cursor at the bottom of the window, and
     restore the terminal I/O. */
  terminal_goto_xy (0, screenheight - 1);
  terminal_clear_to_eol ();
  fflush (stdout);
  terminal_unprep_terminal ();
  close_dribble_file ();
}

/* Here is a window-location dependent event loop.  Called from the
   functions info_session (), and from read_xxx_in_echo_area (). */
void
info_read_and_dispatch (void)
{
  unsigned char key;

  for (quit_info_immediately = 0; !quit_info_immediately; )
    {
      int lk = 0;

      /* If we haven't just gone up or down a line, there is no
         goal column for this window. */
      if ((info_last_executed_command != (VFunction *) info_next_line) &&
          (info_last_executed_command != (VFunction *) info_prev_line))
        active_window->goal_column = -1;

      if (echo_area_is_active)
        {
          lk = echo_area_last_command_was_kill;
          echo_area_prep_read ();
        }

      if (!info_any_buffered_input_p ())
        display_update_display (windows);

      display_cursor_at_point (active_window);
      info_initialize_numeric_arg ();

      initialize_keyseq ();
      key = info_get_input_char ();

      /* No errors yet.  We just read a character, that's all.  Only clear
         the echo_area if it is not currently active. */
      if (!echo_area_is_active)
        window_clear_echo_area ();

      info_error_was_printed = 0;

      /* Do the selected command. */
      info_dispatch_on_key (key, active_window->keymap);

      if (echo_area_is_active)
        {
          /* Echo area commands that do killing increment the value of
             ECHO_AREA_LAST_COMMAND_WAS_KILL.  Thus, if there is no
             change in the value of this variable, the last command
             executed was not a kill command. */
          if (lk == echo_area_last_command_was_kill)
            echo_area_last_command_was_kill = 0;

          if (ea_last_executed_command == (VFunction *) ea_newline ||
              info_aborted_echo_area)
            {
              ea_last_executed_command = NULL;
              break;
            }
        }
    }
}

/* Found in signals.c */
extern void initialize_info_signal_handler (void );

/* Initialize terminal, read configuration file and set key bindings. */
void
initialize_terminal_and_keymaps (char *init_file)
{
  char *term_name = getenv ("TERM");
  terminal_initialize_terminal (term_name);

  if (terminal_is_dumb_p)
    {
      if (!term_name)
        term_name = "dumb";

      info_error (msg_term_too_dumb, term_name);
      exit (EXIT_FAILURE);
    }

  read_init_file (init_file);
}

/* Initialize the first info session by starting the terminal, window,
   and display systems.  If CLEAR_SCREEN is 0, don't clear the screen.  */
void
initialize_info_session (NODE *node, int clear_screen)
{
  if (clear_screen)
    {
      terminal_prep_terminal ();
      terminal_clear_screen ();
    }

  window_initialize_windows (screenwidth, screenheight);
  initialize_info_signal_handler ();
  display_initialize_display (screenwidth, screenheight);
  info_set_node_of_window (0, active_window, node);

  /* Tell the window system how to notify us when a window needs to be
     asynchronously deleted (e.g., user resizes window very small). */
  window_deletion_notifier = (VFunction *) forget_window_and_nodes;

  /* If input has not been redirected yet, make it come from unbuffered
     standard input. */
  if (!info_input_stream)
    {
      setbuf (stdin, NULL);
      info_input_stream = stdin;
    }

  info_windows_initialized_p = 1;
}

/* Tell Info that input is coming from the file FILENAME. */
void
info_set_input_from_file (char *filename)
{
  FILE *stream;

  /* Input may include binary characters.  */
  stream = fopen (filename, FOPEN_RBIN);

  if (!stream)
    return;

  if ((info_input_stream != NULL) &&
      (info_input_stream != stdin))
    fclose (info_input_stream);

  info_input_stream = stream;

  if (stream != stdin)
    display_inhibited = 1;
}

/* Return the INFO_WINDOW containing WINDOW, or NULL if there isn't one. */
static INFO_WINDOW *
get_info_window_of_window (WINDOW *window)
{
  register int i;
  INFO_WINDOW *info_win = NULL;

  for (i = 0; info_windows && (info_win = info_windows[i]); i++)
    if (info_win->window == window)
      break;

  return info_win;
}

/* Reset the remembered pagetop and point of WINDOW to WINDOW's current
   values if the window and node are the same as the current one being
   displayed. */
void
set_remembered_pagetop_and_point (WINDOW *window)
{
  INFO_WINDOW *info_win;

  info_win = get_info_window_of_window (window);

  if (!info_win)
    return;

  if (info_win->nodes_index &&
      (info_win->nodes[info_win->current] == window->node))
    {
      info_win->pagetops[info_win->current] = window->pagetop;
      info_win->points[info_win->current] = window->point;
    }
}

void
remember_window_and_node (WINDOW *window, NODE *node)
{
  /* See if we already have this window in our list. */
  INFO_WINDOW *info_win = get_info_window_of_window (window);

  /* If the window wasn't already on our list, then make a new entry. */
  if (!info_win)
    {
      info_win = xmalloc (sizeof (INFO_WINDOW));
      info_win->window = window;
      info_win->nodes = NULL;
      info_win->pagetops = NULL;
      info_win->points = NULL;
      info_win->current = 0;
      info_win->nodes_index = 0;
      info_win->nodes_slots = 0;

      add_pointer_to_array (info_win, info_windows_index, info_windows,
                            info_windows_slots, 10);
    }

  /* If this node, the current pagetop, and the current point are the
     same as the current saved node and pagetop, don't really add this to
     the list of history nodes.  This may happen only at the very
     beginning of the program, I'm not sure.  --karl  */
  if (info_win->nodes
      && info_win->current >= 0
      && info_win->nodes[info_win->current]->contents == node->contents
      && info_win->pagetops[info_win->current] == window->pagetop
      && info_win->points[info_win->current] == window->point)
  return;

  /* Remember this node, the currently displayed pagetop, and the current
     location of point in this window.  Because we are updating pagetops
     and points as well as nodes, it is more efficient to avoid the
     add_pointer_to_array macro here. */
  if (info_win->nodes_index + 2 >= info_win->nodes_slots)
    {
      info_win->nodes_slots += 20;
      info_win->nodes = (NODE **) xrealloc (info_win->nodes,
                                      info_win->nodes_slots * sizeof (NODE *));
      info_win->pagetops = (int *) xrealloc (info_win->pagetops,
                                      info_win->nodes_slots * sizeof (int));
      info_win->points = (long *) xrealloc (info_win->points,
                                      info_win->nodes_slots * sizeof (long));
    }

  info_win->nodes[info_win->nodes_index] = node;
  info_win->pagetops[info_win->nodes_index] = window->pagetop;
  info_win->points[info_win->nodes_index] = window->point;
  info_win->current = info_win->nodes_index++;
  info_win->nodes[info_win->nodes_index] = NULL;
  info_win->pagetops[info_win->nodes_index] = 0;
  info_win->points[info_win->nodes_index] = 0;
}

#define DEBUG_FORGET_WINDOW_AND_NODES
#if defined (DEBUG_FORGET_WINDOW_AND_NODES)
static void
consistency_check_info_windows (void)
{
  size_t i;

  for (i = 0; i < info_windows_index; i++)
    {
      WINDOW *win;

      for (win = windows; win; win = win->next)
        if (win == info_windows[i]->window)
          break;

      if (!win)
        abort ();
    }
}
#endif /* DEBUG_FORGET_WINDOW_AND_NODES */

/* Remove WINDOW and its associated list of nodes from INFO_WINDOWS. */
void
forget_window_and_nodes (WINDOW *window)
{
  size_t i;
  INFO_WINDOW *info_win = NULL;

  for (i = 0; info_windows && (info_win = info_windows[i]); i++)
    if (info_win->window == window)
      break;

  /* If we found the window to forget, then do so. */
  if (info_win)
    {
      while (i < info_windows_index)
        {
          info_windows[i] = info_windows[i + 1];
          i++;
        }

      info_windows_index--;
      info_windows[info_windows_index] = NULL;

      if (info_win->nodes)
        {
          /* Free the node structures which held onto internal node contents
             here.  This doesn't free the contents; we have a garbage collector
             which does that. */
          for (i = 0; info_win->nodes[i]; i++)
            if (internal_info_node_p (info_win->nodes[i]))
              {
                info_free_references (info_win->nodes[i]->references);
                free (info_win->nodes[i]);
              }
          free (info_win->nodes);

          free (info_win->pagetops);
          free (info_win->points);
        }

      free (info_win);
    }
#if defined (DEBUG_FORGET_WINDOW_AND_NODES)
  consistency_check_info_windows ();
#endif /* DEBUG_FORGET_WINDOW_AND_NODES */
}

/* Set WINDOW to show NODE.  Remember the new window in our list of Info
   windows.  If we are doing automatic footnote display, also try to display
   the footnotes for this window.  If REMEMBER is nonzero, first call
   set_remembered_pagetop_and_point.  */
void
info_set_node_of_window (int remember, WINDOW *window, NODE *node)
{
  if (remember)
    set_remembered_pagetop_and_point (window);

  /* Put this node into the window. */
  window_set_node_of_window (window, node);

  /* Remember this node and window in our list of info windows. */
  remember_window_and_node (window, node);

  /* If doing auto-footnote display/undisplay, show the footnotes belonging
     to this window's node. */
  if (auto_footnotes_p)
    info_get_or_remove_footnotes (window);
}


/* **************************************************************** */
/*                                                                  */
/*                     Movement within a node                       */
/*                                                                  */
/* **************************************************************** */

/* Change the pagetop of WINDOW to DESIRED_TOP, perhaps scrolling the screen
   to do so. */
void
set_window_pagetop (WINDOW *window, int desired_top)
{
  int point_line, old_pagetop;

  if (desired_top < 0)
    desired_top = 0;
  else if (desired_top > window->line_count)
    desired_top = window->line_count - 1;

  if (window->pagetop == desired_top)
    return;

  old_pagetop = window->pagetop;
  window->pagetop = desired_top;

  /* Make sure that point appears in this window. */
  point_line = window_line_of_point (window);
  if ((point_line < window->pagetop) ||
      ((point_line - window->pagetop) > window->height - 1))
    window->point =
      window->line_starts[window->pagetop] - window->node->contents;

  window->flags |= W_UpdateWindow;

  /* Find out which direction to scroll, and scroll the window in that
     direction.  Do this only if there would be a savings in redisplay
     time.  This is true if the amount to scroll is less than the height
     of the window, and if the number of lines scrolled would be greater
     than 10 % of the window's height.

     To prevent status line blinking when keeping up or down key,
     scrolling is disabled if the amount to scroll is 1. */
  if (old_pagetop < desired_top)
    {
      int start, end, amount;

      amount = desired_top - old_pagetop;

      if (amount == 1 ||
	  (amount >= window->height) ||
          (((window->height - amount) * 10) < window->height))
        return;

      start = amount + window->first_row;
      end = window->height + window->first_row;

      display_scroll_display (start, end, -amount);
    }
  else
    {
      int start, end, amount;

      amount = old_pagetop - desired_top;

      if (amount == 1 ||
	  (amount >= window->height) ||
          (((window->height - amount) * 10) < window->height))
        return;

      start = window->first_row;
      end = (window->first_row + window->height) - amount;
      display_scroll_display (start, end, amount);
    }
}

/* Immediately make WINDOW->point visible on the screen, and move the
   terminal cursor there. */
static void
info_show_point (WINDOW *window)
{
  int old_pagetop;

  old_pagetop = window->pagetop;
  window_adjust_pagetop (window);
  if (old_pagetop != window->pagetop)
    {
      int new_pagetop;

      new_pagetop = window->pagetop;
      window->pagetop = old_pagetop;
      set_window_pagetop (window, new_pagetop);
    }

  if (window->flags & W_UpdateWindow)
    display_update_one_window (window);

  display_cursor_at_point (window);
}

/* Move WINDOW->point from OLD line index to NEW line index. */
static void
move_to_new_line (int old, int new, WINDOW *window)
{
  if (old == -1)
    {
      info_error ("%s", msg_cant_find_point);
    }
  else
    {
      int goal;

      if (new >= window->line_count || new < 0)
        return;
      
      goal = window_get_goal_column (window);
      window->goal_column = goal;

      window->point = window->line_starts[new] - window->node->contents;
      window->point += window_chars_to_goal (window, goal);
      info_show_point (window);
    }
}

static int forward_move_node_structure (WINDOW *window, int behaviour);
static int backward_move_node_structure (WINDOW *window, int behaviour);

/* Move WINDOW's point down to the next line if possible. */
DECLARE_INFO_COMMAND (info_next_line, _("Move down to the next line"))
{
  int old_line, new_line;

  if (count < 0)
    info_prev_line (window, -count, key);
  else
    while (count)
      {
        int diff;

        old_line = window_line_of_point (window);
        diff = window->line_count - old_line;
        if (diff > count)
          diff = count;

        count -= diff;
        new_line = old_line + diff;
        if (new_line >= window->line_count)
          {
            if (cursor_movement_scrolls_p)
              {
                if (forward_move_node_structure (window,
                                                 info_scroll_behaviour))
                  break;
                move_to_new_line (0, 0, window);
              }
            else
              break;
          }
        else
          move_to_new_line (old_line, new_line, window);
      }
}

/* "Safe" version of info_next_line, for use when moving to a
   reference within the window.  It assumes that point is 0 and
   is safe in the sense that it won't allow to change nodes if
   COUNT is greater than the number of lines in the current node.

   This is necessary to avoid incorrect placement on malformed
   info documents (such as gawk.info v. 3.1.5) when
   cursor_movement_scrolls_p is set to 1. */

static void
internal_next_line (WINDOW *window, int count, unsigned char key)
{
  if (count >= 0 && count < window->line_count)
    info_next_line (window, count, key);
}
  
/* Move WINDOW's point up to the previous line if possible. */
DECLARE_INFO_COMMAND (info_prev_line, _("Move up to the previous line"))
{
  int old_line, new_line;

  if (count < 0)
    info_next_line (window, -count, key);
  else
    while (count)
      {
        int diff;
        
        old_line = window_line_of_point (window);
        diff = old_line + 1;
        if (diff > count)
          diff = count;
        
        count -= diff;
        new_line = old_line - diff;
        
        if (new_line < 0
            && cursor_movement_scrolls_p)
          {
            if (backward_move_node_structure (window, info_scroll_behaviour))
              break;
            if (window->line_count > window->height)
              set_window_pagetop (window, window->line_count - window->height);
            move_to_new_line (window->line_count,
                              window->line_count - 1, window);
          }
        else
          move_to_new_line (old_line, new_line, window);
      }
}

/* Return true if POINT sits on a newline character. */
static int
_looking_at_newline (WINDOW *win, long point)
{
  mbi_iterator_t iter;

  mbi_init (iter, win->node->contents + point,
	    win->node->nodelen - point);
  mbi_avail (iter);
  return mbi_cur (iter).wc_valid && mbi_cur (iter).wc == '\n';
}

/* Advance point of WIN to the beginning of the next logical line.
   Return 1 if there is no next line. */
static int
point_next_line (WINDOW *win)
{
  int line = window_line_of_point (win);
  if (line + 1 >= win->line_count)
    return 1;
  win->point = win->line_starts[line + 1] - win->node->contents;
  window_compute_line_map (win);
  return 0;
}

/* Move point of WIN to the beginning of the previous logical
   line.
   Return 1 if there is no previous line. */
static int
point_prev_line (WINDOW *win)
{
  int line = window_line_of_point (win);
  if (line == 0)
    return 1;
  win->point = win->line_starts[line - 1] - win->node->contents;
  window_compute_line_map (win);
  return 0;
}

/* Advance point to the next multibyte character.  Return 1 if this would
   cause pointing past the end of node buffer. */
static int
point_forward_char (WINDOW *win)
{
  long point = win->point;
  int col;

  window_compute_line_map (win);
  col = window_point_to_column (win, point, &point) + 1;
  if (col >= win->line_map.used)
    {
      if (point_next_line (win))
	return 1;
      col = 0;
    }
  win->point = win->line_map.map[col];
  return 0;
}

/* Set point to the previous multibyte character.
   Return 1 if already on the beginning of node buffer. */
static int
point_backward_char (WINDOW *win)
{
  long point = win->point;
  int col;

  window_compute_line_map (win);
  col = window_point_to_column (win, point, &point);
  for (; col >= 0 && win->line_map.map[col] == point; col--)
    ;
  if (col < 0)
    {
      if (point_prev_line (win))
	return 1;
      col = win->line_map.used - 1;
    }
  win->point = win->line_map.map[col];
  return 0;
}

/* Skip forward any white space characters starting from column *PCOL in
   the current line, advancing line if necessary.  Return 1 if going past
   the end of node buffer. */
static int
point_skip_ws_forward (WINDOW *win, int *pcol)
{
  mbi_iterator_t iter;
  int col = *pcol;

  while (1)
    {
      char *buffer = win->node->contents;
      size_t buflen = win->node->nodelen;

      for (; col < win->line_map.used; col++)
	{
	  mbi_init (iter, buffer + win->line_map.map[col],
		    buflen - win->line_map.map[col]);
	  mbi_avail (iter);
	  if (!mbi_cur (iter).wc_valid || iswalnum (mbi_cur (iter).wc))
	    {
	      *pcol = col;
	      return 0;
	    }
	}
      if (point_next_line (win))
	return 1;
      col = 0;
    }
  return 1;
}

/* Skip backward any white space characters starting from column *PCOL in
   the current line, retracting line if necessary.  Return 1 if going
   before the beginning of node buffer. */
static int
point_skip_ws_backward (WINDOW *win, int *pcol)
{
  mbi_iterator_t iter;
  int col = *pcol;

  while (1)
    {
      char *buffer = win->node->contents;
      size_t buflen = win->node->nodelen;

      for (; col > 0; col--)
	{
	  mbi_init (iter, buffer + win->line_map.map[col],
		    buflen - win->line_map.map[col]);
	  mbi_avail (iter);
	  if (!mbi_cur (iter).wc_valid || iswalnum (mbi_cur (iter).wc))
	    {
	      *pcol = col;
	      return 0;
	    }
	}
      if (point_prev_line (win))
	return 1;
      col = win->line_map.used - 1;
    }
  return 1;
}

/* Advance window point to the beginning of the next word.  Return 1
   if there are no more words in the buffer. */
static int
point_forward_word (WINDOW *win)
{
  mbi_iterator_t iter;
  int col;

  window_compute_line_map (win);
  col = window_point_to_column (win, win->point, &win->point);

  if (point_skip_ws_forward (win, &col))
    return 1;

  while (1)
    {
      char *buffer = win->node->contents;
      size_t buflen = win->node->nodelen;
      
      for (; col < win->line_map.used; col++)
	{
	  mbi_init (iter, buffer + win->line_map.map[col],
		    buflen - win->line_map.map[col]);
	  mbi_avail (iter);
	  if (!(mbi_cur (iter).wc_valid && iswalnum (mbi_cur (iter).wc)))
	    {
	      if (point_skip_ws_forward (win, &col))
		return 1;
	      win->point = win->line_map.map[col];
	      return 0;
	    }
	}
      if (point_next_line (win))
	return 1;
      col = 0;
    }
  return 1;
}

/* Set window point to the beginning of the previous word.  Return 1
   if looking at the very first word in the buffer. */
static int
point_backward_word (WINDOW *win)
{
  mbi_iterator_t iter;
  int col;

  window_compute_line_map (win);
  col = window_point_to_column (win, win->point, &win->point);

  while (1)
    {
      long point;
      char *buffer;
      size_t buflen;

      if (col <= 0)
	{
	  if (point_prev_line (win))
	    return 1;
	  col = win->line_map.used;
	}
      col--;
      if (point_skip_ws_backward (win, &col))
	return 1;

      buffer = win->node->contents;
      buflen = win->node->nodelen;

      for (; col >= 0; col--)
	{
	  mbi_init (iter, buffer + win->line_map.map[col],
		    buflen - win->line_map.map[col]);
	  mbi_avail (iter);
	  if (!(mbi_cur (iter).wc_valid && iswalnum (mbi_cur (iter).wc)))
	    {
	      win->point = win->line_map.map[col+1];
	      return 0;
	    }
	}
      point = win->line_map.map[0] - 1;
      if (point > 0 && _looking_at_newline (win, point))
	{
	  win->point = win->line_map.map[0];
	  return 0;
	}
    }
  return 1;
}

/* Move WINDOW's point to the end of the true line. */
DECLARE_INFO_COMMAND (info_end_of_line, _("Move to the end of the line"))
{
  int point = window_end_of_line (window);
  if (point != window->point)
    {
      window->point = point;
      info_show_point (window);
    }
}

/* Move WINDOW's point to the beginning of the true line. */
DECLARE_INFO_COMMAND (info_beginning_of_line, _("Move to the start of the line"))
{
  int old_point = window->point;
  int point;
  
  while (1)
    {
      window_compute_line_map (window);
      point = window->line_map.map[0];
      if (point == 0 || _looking_at_newline (window, point-1))
	break;
      point_prev_line (window);
    }

  if (point != old_point)
    {
      window->point = point;
      info_show_point (window);
    }
  else
    window->point = old_point;
}

/* Move point forward in the node. */
DECLARE_INFO_COMMAND (info_forward_char, _("Move forward a character"))
{
  if (count < 0)
    info_backward_char (window, -count, key);
  else
    {
      while (count)
        {
          if (point_forward_char (window))
            {
              if (cursor_movement_scrolls_p
                  && forward_move_node_structure (window,
                                                  info_scroll_behaviour) == 0)
                window->point = 0;
              else
                {
                  window->point = window->node->nodelen - 1;
                  break;
                }
            }
	  count--;
        }
      info_show_point (window);
    }
}

/* Move point backward in the node. */
DECLARE_INFO_COMMAND (info_backward_char, _("Move backward a character"))
{
  if (count < 0)
    info_forward_char (window, -count, key);
  else
    {
      while (count)
        {
          if (point_backward_char (window))
            {
              if (cursor_movement_scrolls_p
                  && backward_move_node_structure (window,
                                                   info_scroll_behaviour) == 0)
                {
                  window->point = window->node->nodelen - 1;
                  if (window->line_count > window->height)
                    set_window_pagetop (window,
                                        window->line_count - window->height);
                }
              else
                {
                  window->point = 0;
                  break;
                }
            }
	  count--;
        }
      info_show_point (window);
    }
}

/* Move forward a word in this node. */
DECLARE_INFO_COMMAND (info_forward_word, _("Move forward a word"))
{
  if (count < 0)
    {
      info_backward_word (window, -count, key);
      return;
    }

  while (count)
    {
      if (point_forward_word (window))
        {
          if (cursor_movement_scrolls_p
              && forward_move_node_structure (window,
                                              info_scroll_behaviour) == 0)
	    window->point = 0;
          else
            return;
        }
      --count;
    }
  info_show_point (window);
}

DECLARE_INFO_COMMAND (info_backward_word, _("Move backward a word"))
{
  if (count < 0)
    {
      info_forward_word (window, -count, key);
      return;
    }

  while (count)
    {
      if (point_backward_word (window))
        {
          if (cursor_movement_scrolls_p
              && backward_move_node_structure (window,
                                               info_scroll_behaviour) == 0)
            {
              if (window->line_count > window->height)
                set_window_pagetop (window,
                                    window->line_count - window->height);
              window->point = window->node->nodelen;
            }
          else
            break;
        }
      --count;
    }
  info_show_point (window);
}

/* Move to the beginning of the node. */
DECLARE_INFO_COMMAND (info_beginning_of_node, _("Move to the start of this node"))
{
  window->pagetop = window->point = 0;
  window->flags |= W_UpdateWindow;
}

/* Move to the end of the node. */
DECLARE_INFO_COMMAND (info_end_of_node, _("Move to the end of this node"))
{
  window->point = window->node->nodelen - 1;
  info_show_point (window);
}


/* **************************************************************** */
/*                                                                  */
/*                     Scrolling window                             */
/*                                                                  */
/* **************************************************************** */

/* Variable controlling the behaviour of default scrolling when you are
   already at the bottom of a node.  Possible values are defined in session.h.
   The meanings are:

   IS_Continuous        Try to get first menu item, or failing that, the
                        "Next:" pointer, or failing that, the "Up:" and
                        "Next:" of the up.
   IS_NextOnly          Try to get "Next:" menu item.
   IS_PageOnly          Simply give up at the bottom of a node. */

int info_scroll_behaviour = IS_Continuous;

/* Choices used by the completer when reading a value for the user-visible
   variable "scroll-behaviour". */
char *info_scroll_choices[] = {
  "Continuous", "Next Only", "Page Only", NULL
};

/* Controls whether scroll-behavior affects line movement commands */
int cursor_movement_scrolls_p = 1;

int search_skip_screen_p = 0;

/* Choices for the scroll-last-node variable */
char *scroll_last_node_choices[] = {
  "Stop", "Scroll", "Top", NULL
};

/* Controls what to do when a scrolling command is issued at the end of the
   last node. */
int scroll_last_node = SLN_Stop;

static void _scroll_forward (WINDOW *window, int count,
    unsigned char key, int behaviour);
static void _scroll_backward (WINDOW *window, int count,
    unsigned char key, int behaviour);

static void
_scroll_forward (WINDOW *window, int count, unsigned char key, int behaviour)
{
  if (count < 0)
    _scroll_backward (window, -count, key, behaviour);
  else
    {
      /* If there are no more lines to scroll here, error, or get
         another node, depending on BEHAVIOUR. */
      if (window->pagetop >= window->line_count - window->height)
        {
          forward_move_node_structure (window, behaviour);
          return;
        }

      set_window_pagetop (window, window->pagetop + count);
    }
}

static void
_scroll_backward (WINDOW *window, int count, unsigned char key, int behaviour)
{
  if (count < 0)
    _scroll_backward (window, -count, key, behaviour);
  else
    {
      int desired_top;

      /* If there are no more lines to scroll here, error, or get
         another node, depending on BEHAVIOUR. */
      if (window->pagetop <= 0)
        {
          if (backward_move_node_structure (window, behaviour) == 0)
            info_end_of_node (window, 1, 0);
          return;
        }

      desired_top = window->pagetop - count;
      if (desired_top < 0)
        desired_top = 0;
      set_window_pagetop (window, desired_top);
    }
}

/* Lines to scroll by.  -1 means scroll by screen size. */
int default_window_size = -1;

/* Show the next screen of WINDOW's node. */
DECLARE_INFO_COMMAND (info_scroll_forward, _("Scroll forward in this window"))
{
  int lines;

  if (info_explicit_arg)
    lines = count;
  else if (default_window_size > 0)
    lines = default_window_size;
  else
    lines = window->height - 2;
  _scroll_forward (window, lines, key, info_scroll_behaviour);
}

/* Show the previous screen of WINDOW's node. */
DECLARE_INFO_COMMAND (info_scroll_backward, _("Scroll backward in this window"))
{
  int lines;

  if (info_explicit_arg)
    lines = count;
  else if (default_window_size > 0)
    lines = default_window_size;
  else
    lines = window->height - 2;
  _scroll_backward (window, lines, key, info_scroll_behaviour);
}

/* Like info_scroll_forward, but sets default_window_size as a side
   effect.  */
DECLARE_INFO_COMMAND (info_scroll_forward_set_window,
                      _("Scroll forward in this window and set default window size"))
{
  int lines;

  if (info_explicit_arg)
    default_window_size = count;

  info_scroll_forward (window, count, key);
}

/* Like info_scroll_backward, but sets default_window_size as a side
   effect.  */
DECLARE_INFO_COMMAND (info_scroll_backward_set_window,
                      _("Scroll backward in this window and set default window size"))
{
  int lines;

  if (info_explicit_arg)
    default_window_size = count;

  info_scroll_backward (window, count, key);
}

/* Show the next screen of WINDOW's node but never advance to next node. */
DECLARE_INFO_COMMAND (info_scroll_forward_page_only, _("Scroll forward in this window staying within node"))
{
  int lines;

  if (info_explicit_arg)
    lines = count;
  else if (default_window_size > 0)
    lines = default_window_size;
  else
    lines = window->height - 2;
  _scroll_forward (window, lines, key, IS_PageOnly);
}

/* Show the previous screen of WINDOW's node but never move to previous
   node. */
DECLARE_INFO_COMMAND (info_scroll_backward_page_only, _("Scroll backward in this window staying within node"))
{
  int lines;

  if (info_explicit_arg)
    lines = count;
  else if (default_window_size > 0)
    lines = default_window_size;
  else
    lines = window->height - 2;
  _scroll_backward (window, lines, key, IS_PageOnly);
}

/* Like info_scroll_forward_page_only, but sets default_window_size as a side
   effect.  */
DECLARE_INFO_COMMAND (info_scroll_forward_page_only_set_window,
                      _("Scroll forward in this window staying within node and set default window size"))
{
  int lines;

  if (info_explicit_arg)
    default_window_size = count;

  info_scroll_forward_page_only (window, count, key);
}

/* Like info_scroll_backward_page_only, but sets default_window_size as a side
   effect.  */
DECLARE_INFO_COMMAND (info_scroll_backward_page_only_set_window,
                      _("Scroll backward in this window staying within node and set default window size"))
{
  int lines;

  if (info_explicit_arg)
    default_window_size = count;

  info_scroll_backward_page_only (window, count, key);
}

/* Scroll the window forward by N lines.  */
DECLARE_INFO_COMMAND (info_down_line, _("Scroll down by lines"))
{
  if (count < 0)
    info_up_line (window, -count, key);
  else
    _scroll_forward (window, count, key, IS_PageOnly);
}

/* Scroll the window backward by N lines.  */
DECLARE_INFO_COMMAND (info_up_line, _("Scroll up by lines"))
{
  if (count < 0)
    info_down_line (window, -count, key);
  else
    _scroll_backward (window, count, key, IS_PageOnly);
}

/* Lines to scroll when using commands that scroll by half screen size
   by default.  -1 means scroll by half screen size. */
int default_scroll_size = -1;

/* Scroll the window forward by N lines and remember N as default for
   subsequent commands.  */
DECLARE_INFO_COMMAND (info_scroll_half_screen_down,
                      _("Scroll down by half screen size"))
{
  if (count < 0)
    info_scroll_half_screen_up (window, -count, key);
  else
    {
      int lines;

      if (info_explicit_arg)
        default_scroll_size = count;

      if (default_scroll_size > 0)
        lines = default_scroll_size;
      else
        lines = (the_screen->height + 1) / 2;

      _scroll_forward (window, lines, key, IS_PageOnly);
    }
}

/* Scroll the window backward by N lines and remember N as default for
   subsequent commands.  */
DECLARE_INFO_COMMAND (info_scroll_half_screen_up,
                      _("Scroll up by half screen size"))
{
  if (count < 0)
    info_scroll_half_screen_down (window, -count, key);
  else
    {
      int lines;

      if (info_explicit_arg)
        default_scroll_size = count;

      if (default_scroll_size > 0)
        lines = default_scroll_size;
      else
        lines = (the_screen->height + 1) / 2;

      _scroll_backward (window, lines, key, IS_PageOnly);
    }
}


/* **************************************************************** */
/*                                                                  */
/*                 Commands for Manipulating Windows                */
/*                                                                  */
/* **************************************************************** */

/* Make the next window in the chain be the active window. */
DECLARE_INFO_COMMAND (info_next_window, _("Select the next window"))
{
  if (count < 0)
    {
      info_prev_window (window, -count, key);
      return;
    }

  /* If no other window, error now. */
  if (!windows->next && !echo_area_is_active)
    {
      info_error ("%s", msg_one_window);
      return;
    }

  while (count--)
    {
      if (window->next)
        window = window->next;
      else
        {
          if (window == the_echo_area || !echo_area_is_active)
            window = windows;
          else
            window = the_echo_area;
        }
    }

  if (active_window != window)
    {
      if (auto_footnotes_p)
        info_get_or_remove_footnotes (window);

      window->flags |= W_UpdateWindow;
      active_window = window;
    }
}

/* Make the previous window in the chain be the active window. */
DECLARE_INFO_COMMAND (info_prev_window, _("Select the previous window"))
{
  if (count < 0)
    {
      info_next_window (window, -count, key);
      return;
    }

  /* Only one window? */

  if (!windows->next && !echo_area_is_active)
    {
      info_error ("%s", msg_one_window);
      return;
    }

  while (count--)
    {
      /* If we are in the echo area, or if the echo area isn't active and we
         are in the first window, find the last window in the chain. */
      if (window == the_echo_area ||
          (window == windows && !echo_area_is_active))
        {
          register WINDOW *win, *last = NULL;

          for (win = windows; win; win = win->next)
            last = win;

          window = last;
        }
      else
        {
          if (window == windows)
            window = the_echo_area;
          else
            window = window->prev;
        }
    }

  if (active_window != window)
    {
      if (auto_footnotes_p)
        info_get_or_remove_footnotes (window);

      window->flags |= W_UpdateWindow;
      active_window = window;
    }
}

/* Split WINDOW into two windows, both showing the same node.  If we
   are automatically tiling windows, re-tile after the split. */
DECLARE_INFO_COMMAND (info_split_window, _("Split the current window"))
{
  WINDOW *split, *old_active;
#if defined (SPLIT_BEFORE_ACTIVE)
  int pagetop;

  /* Remember the current pagetop of the window being split.  If it doesn't
     change, we can scroll its contents around after the split. */
  pagetop = window->pagetop;
#endif
  
  /* Make the new window. */
  old_active = active_window;
  active_window = window;
  split = window_make_window (window->node);
  active_window = old_active;

  if (!split)
    {
      info_error ("%s", msg_win_too_small);
    }
  else
    {
#if defined (SPLIT_BEFORE_ACTIVE)
      /* Try to scroll the old window into its new postion. */
      if (pagetop == window->pagetop)
        {
          int start, end, amount;

          start = split->first_row;
          end = start + window->height;
          amount = split->height + 1;
          display_scroll_display (start, end, amount);
        }
#else /* !SPLIT_BEFORE_ACTIVE */
      /* Make sure point still appears in the active window. */
      info_show_point (window);
#endif /* !SPLIT_BEFORE_ACTIVE */

      /* If the window just split was one internal to Info, try to display
         something else in it. */
      if (internal_info_node_p (split->node))
        {
          register int i, j;
          INFO_WINDOW *iw;
          NODE *node = NULL;
          char *filename;

          for (i = 0; (iw = info_windows[i]); i++)
            {
              for (j = 0; j < iw->nodes_index; j++)
                if (!internal_info_node_p (iw->nodes[j]))
                  {
                    if (iw->nodes[j]->parent)
                      filename = iw->nodes[j]->parent;
                    else
                      filename = iw->nodes[j]->filename;

                    node = info_get_node (filename, iw->nodes[j]->nodename,
                                          PARSE_NODE_DFLT);
                    if (node)
                      {
                        window_set_node_of_window (split, node);
                        i = info_windows_index - 1;
                        break;
                      }
                  }
            }
        }
      split->pagetop = window->pagetop;

      if (auto_tiling_p)
        window_tile_windows (DONT_TILE_INTERNALS);
      else
        window_adjust_pagetop (split);

      remember_window_and_node (split, split->node);
    }
}

/* Delete WINDOW, forgetting the list of last visited nodes.  If we are
   automatically displaying footnotes, show or remove the footnotes
   window.  If we are automatically tiling windows, re-tile after the
   deletion. */
DECLARE_INFO_COMMAND (info_delete_window, _("Delete the current window"))
{
  if (!windows->next)
    {
      info_error ("%s", msg_cant_kill_last);
    }
  else if (window->flags & W_WindowIsPerm)
    {
      info_error ("%s", _("Cannot delete a permanent window"));
    }
  else
    {
      info_delete_window_internal (window);

      if (auto_footnotes_p)
        info_get_or_remove_footnotes (active_window);

      if (auto_tiling_p)
        window_tile_windows (DONT_TILE_INTERNALS);

      info_gc_file_buffers ();
    }
}

/* Do the physical deletion of WINDOW, and forget this window and
   associated nodes. */
void
info_delete_window_internal (WINDOW *window)
{
  if (windows->next && ((window->flags & W_WindowIsPerm) == 0))
    {
      /* We not only delete the window from the display, we forget it from
         our list of remembered windows. */
      forget_window_and_nodes (window);
      window_delete_window (window);

      if (echo_area_is_active)
        echo_area_inform_of_deleted_window (window);
    }
}

/* Just keep WINDOW, deleting all others. */
DECLARE_INFO_COMMAND (info_keep_one_window, _("Delete all other windows"))
{
  int num_deleted;              /* The number of windows we deleted. */
  int pagetop, start, end;

  /* Remember a few things about this window.  We may be able to speed up
     redisplay later by scrolling its contents. */
  pagetop = window->pagetop;
  start = window->first_row;
  end = start + window->height;

  num_deleted = 0;

  while (1)
    {
      WINDOW *win;

      /* Find an eligible window and delete it.  If no eligible windows
         are found, we are done.  A window is eligible for deletion if
         is it not permanent, and it is not WINDOW. */
      for (win = windows; win; win = win->next)
        if (win != window && ((win->flags & W_WindowIsPerm) == 0))
          break;

      if (!win)
        break;

      info_delete_window_internal (win);
      num_deleted++;
    }

  /* Scroll the contents of this window into the right place so that the
     user doesn't have to wait any longer than necessary for redisplay. */
  if (num_deleted)
    {
      int amount;

      amount = (window->first_row - start);
      amount -= (window->pagetop - pagetop);
      display_scroll_display (start, end, amount);
    }

  window->flags |= W_UpdateWindow;
}

/* Scroll the "other" window of WINDOW. */
DECLARE_INFO_COMMAND (info_scroll_other_window, _("Scroll the other window"))
{
  WINDOW *other;

  /* If only one window, give up. */
  if (!windows->next)
    {
      info_error ("%s", msg_one_window);
      return;
    }

  other = window->next;

  if (!other)
    other = window->prev;

  info_scroll_forward (other, count, key);
}

/* Scroll the "other" window of WINDOW. */
DECLARE_INFO_COMMAND (info_scroll_other_window_backward,
                      _("Scroll the other window backward"))
{
  info_scroll_other_window (window, -count, key);
}

/* Change the size of WINDOW by AMOUNT. */
DECLARE_INFO_COMMAND (info_grow_window, _("Grow (or shrink) this window"))
{
  window_change_window_height (window, count);
}

/* When non-zero, tiling takes place automatically when info_split_window
   is called. */
int auto_tiling_p = 0;

/* Tile all of the visible windows. */
DECLARE_INFO_COMMAND (info_tile_windows,
    _("Divide the available screen space among the visible windows"))
{
  window_tile_windows (TILE_INTERNALS);
}

/* Toggle the state of this window's wrapping of lines. */
DECLARE_INFO_COMMAND (info_toggle_wrap,
              _("Toggle the state of line wrapping in the current window"))
{
  window_toggle_wrap (window);
}

/* Toggle the usage of regular expressions in searches. */
DECLARE_INFO_COMMAND (info_toggle_regexp,
              _("Toggle the usage of regular expressions in searches"))
{
  use_regex = !use_regex;
  window_message_in_echo_area (use_regex
                               ? _("Using regular expressions for searches.")
                               : _("Using literal strings for searches."));
}

/* **************************************************************** */
/*                                                                  */
/*                      Info Node Commands                          */
/*                                                                  */
/* **************************************************************** */

/* Return (FILENAME)NODENAME for NODE, or just NODENAME if NODE's
   filename is not set. */
char *
node_printed_rep (NODE *node)
{
  char *rep;

  if (node->filename)
    {
      char *filename
       = filename_non_directory (node->parent ? node->parent : node->filename);
      rep = xmalloc (1 + strlen (filename) + 1 + strlen (node->nodename) + 1);
      sprintf (rep, "(%s)%s", filename, node->nodename);
    }
  else
    rep = node->nodename;

  return rep;
}


/* Using WINDOW for various defaults, select the node referenced by ENTRY
   in it.  If the node is selected, the window and node are remembered. */
void
info_select_reference (WINDOW *window, REFERENCE *entry)
{
  NODE *node;
  char *file_system_error;

  file_system_error = NULL;

  node = info_get_node_with_defaults (entry->filename, entry->nodename,
             PARSE_NODE_VERBATIM, window);

  /* Try something a little weird.  If the node couldn't be found, and the
     reference was of the form "foo::", see if the entry->label can be found
     as a file, with a node of "Top". */
  if (!node)
    {
      if (info_recent_file_error)
        file_system_error = xstrdup (info_recent_file_error);

      if (entry->nodename && (strcmp (entry->nodename, entry->label) == 0))
        {
          node = info_get_node (entry->label, "Top", PARSE_NODE_DFLT);
          if (!node && info_recent_file_error)
            {
              free (file_system_error);
              file_system_error = xstrdup (info_recent_file_error);
            }
        }
    }

  if (!node)
    {
      if (file_system_error)
        info_error ("%s", file_system_error);
      else
        info_error (msg_cant_find_node, entry->nodename);
    }

  free (file_system_error);

  if (node)
    info_set_node_of_window (1, window, node);
}

/* Parse the node specification in LINE using WINDOW to default the filename.
   Select the parsed node in WINDOW and remember it, or error if the node
   couldn't be found. */
static void
info_parse_and_select (char *line, WINDOW *window)
{
  REFERENCE entry;

  /* info_parse_node will be called on 'line' in subsequent functions. */
  entry.nodename = line;
  entry.filename = 0;
  entry.label = "*info-parse-and-select*";

  info_select_reference (window, &entry);
}

static int
info_win_find_node (INFO_WINDOW *win, NODE *node)
{
  int i;

  for (i = win->nodes_index - 1; i >= 0; i--)
    {
      NODE *p = win->nodes[i];

      if (strcmp (p->filename, node->filename) == 0 &&
	  strcmp (p->nodename, node->nodename) == 0)
	break;
    }
  return i;
}	  


/* **************************************************************** */
/*                                                                  */
/*                 Navigation of document structure                 */
/*                                                                  */
/* **************************************************************** */

/* Get the node pointed to by the LABEL pointer of
   WINDOW->node into WINDOW. */
static void
info_handle_pointer (char *label, WINDOW *window)
{
  char *description;
  NODE *node;
  INFO_WINDOW *info_win;

  if (!strcmp (label, "Up"))
    description = window->node->up;
  else if (!strcmp (label, "Next"))
    description = window->node->next;
  else if (!strcmp (label, "Prev"))
    description = window->node->prev;

  if (!description)
    {
      info_error (msg_no_pointer, label);
      return;
    }

  node = info_get_node_with_defaults (0, description,
               PARSE_NODE_START, window);

  if (!node)
    {
      if (info_recent_file_error)
        info_error ("%s", info_recent_file_error);
      else
        info_error (msg_cant_find_node, description);
      return;
    }

  /* Set the cursor position to the last place it was in the
     node, if we are going up. */
  info_win = get_info_window_of_window (window);
  if (info_win)
    {
      if (strcmp (label, "Up") == 0)
        {
          int i = info_win_find_node (info_win, node);
          if (i >= 0)
            node->display_pos = info_win->points[i];
        }
      info_win->pagetops[info_win->current] = window->pagetop;
      info_win->points[info_win->current] = window->point;
    }
  info_set_node_of_window (1, window, node);
}

/* Make WINDOW display the "Next:" node of the node currently being
   displayed. */
DECLARE_INFO_COMMAND (info_next_node, _("Select the Next node"))
{
  info_handle_pointer ("Next", window);
}

/* Make WINDOW display the "Prev:" node of the node currently being
   displayed. */
DECLARE_INFO_COMMAND (info_prev_node, _("Select the Prev node"))
{
  info_handle_pointer ("Prev", window);
}

/* Make WINDOW display the "Up:" node of the node currently being
   displayed. */
DECLARE_INFO_COMMAND (info_up_node, _("Select the Up node"))
{
  info_handle_pointer ("Up", window);
}

/* Make WINDOW display the last node of this info file. */
DECLARE_INFO_COMMAND (info_last_node, _("Select the last node in this file"))
{
  register int i;
  FILE_BUFFER *fb = file_buffer_of_window (window);
  NODE *node = NULL;

  if (fb && fb->tags)
    {
      int last_node_tag_idx = -1;

      /* If no explicit argument, or argument of zero, default to the
         last node.  */
      if (count == 0 || (count == 1 && !info_explicit_arg))
        count = -1;
      for (i = 0; count && fb->tags[i]; i++)
        if (fb->tags[i]->nodelen != 0) /* don't count anchor tags */
          {
            count--;
            last_node_tag_idx = i;
          }
      if (count > 0)
        i = last_node_tag_idx + 1;
      if (i > 0)
        node = info_get_node (fb->filename, fb->tags[i - 1]->nodename,
                              PARSE_NODE_DFLT);
    }

  if (!node)
    info_error ("%s", _("This window has no additional nodes"));
  else
    info_set_node_of_window (1, window, node);
}

/* Make WINDOW display the first node of this info file. */
DECLARE_INFO_COMMAND (info_first_node, _("Select the first node in this file"))
{
  FILE_BUFFER *fb = file_buffer_of_window (window);
  NODE *node = NULL;

  /* If no explicit argument, or argument of zero, default to the
     first node.  */
  if (count == 0)
    count = 1;
  if (fb && fb->tags)
    {
      register int i;
      int last_node_tag_idx = -1;

      for (i = 0; count && fb->tags[i]; i++)
        if (fb->tags[i]->nodelen != 0) /* don't count anchor tags */
          {
            count--;
            last_node_tag_idx = i;
          }
      if (count > 0)
        i = last_node_tag_idx + 1;
      if (i > 0)
        node = info_get_node (fb->filename, fb->tags[i - 1]->nodename,
                              PARSE_NODE_DFLT);
    }

  if (!node)
    info_error ("%s", _("This window has no additional nodes"));
  else
    info_set_node_of_window (1, window, node);
}

/* Move to 1st menu item, Next, Up/Next, or error in this window. */
static int
forward_move_node_structure (WINDOW *window, int behaviour)
{
  switch (behaviour)
    {
    case IS_PageOnly:
      info_error ("%s", msg_at_node_bottom);
      return 1;

    case IS_NextOnly:
      if (!window->node->next)
        {
          info_error (msg_no_pointer, _("Next"));
          return 1;
        }
      else
        {
          info_handle_pointer ("Next", window);
        }
      break;

    case IS_Continuous:
      {
        /* If last node in file */
        if (!window->node->next &&
            !(window->node->up && strcmp ("Top", window->node->up)))
          {
            switch (scroll_last_node)
              {
              case SLN_Stop:
                info_error ("%s", _("No more nodes within this document."));
                return 1;
                
              case SLN_Scroll:
                break;
                
              case SLN_Top:
                info_top_node (window, 1, 0);
                return 0;
                
              default:
                abort ();
              }
          }
        
        /* If this node contains a menu, select its first entry. */
        {
          REFERENCE *entry;

          if (entry = select_menu_digit (window, '1'))
            {
              info_select_reference (window, entry);
              if (entry->line_number > 0)
                internal_next_line (window, entry->line_number - 1, '1');
              return 0;
            }
        }

        /* Okay, this node does not contain a menu.  If it contains a
           "Next:" pointer, use that. */
        if (window->node->next)
          {
            info_handle_pointer ("Next", window);
            return 0;
          }

        /* Okay, there wasn't a "Next:" for this node.  Move "Up:" until we
           can move "Next:".  If that isn't possible, complain that there
           are no more nodes. */
        {
          int up_counter, old_current;
          INFO_WINDOW *info_win;

          /* Remember the current node and location. */
          info_win = get_info_window_of_window (window);
          old_current = info_win->current;

          /* Back up through the "Up:" pointers until we have found a "Next:"
             that isn't the same as the first menu item found in that node. */
          up_counter = 0;
          while (!info_error_was_printed)
            {
              if (window->node->up)
                {
                  info_handle_pointer ("Up", window);
                  if (info_error_was_printed)
                    continue;

                  up_counter++;

                  /* If no "Next" pointer, keep backing up. */
                  if (!window->node->next)
                    continue;

                  /* If this node's first menu item is the same as this node's
                     Next pointer, keep backing up. */
                    {
                      REFERENCE **menu;

                      /* FIXME: this is wrong: what if there is a link
                         before the menu? */
                      menu = window->node->references;
                      if (menu &&
                          (strcmp
                           (menu[0]->nodename, window->node->next) == 0))
                        continue;
                    }

                  /* This node has a "Next" pointer, and it is not the
                     same as the first menu item found in this node. */
                  info_handle_pointer ("Next", window);
                  return 0;
                }
              else
                {
                  /* No more "Up" pointers.  Print an error, and call it
                     quits. */
                  register int i;

                  for (i = 0; i < up_counter; i++)
                    {
                      info_win->nodes_index--;
                      free (info_win->nodes[info_win->nodes_index]);
                      info_win->nodes[info_win->nodes_index] = NULL;
                    }
                  info_win->current = old_current;
                  window->node = info_win->nodes[old_current];
                  window->pagetop = info_win->pagetops[old_current];
                  window->point = info_win->points[old_current];
                  recalculate_line_starts (window);
                  window->flags |= W_UpdateWindow;
                  info_error ("%s", _("No more nodes within this document."));
                  return 1;
                }
            }
        }
        break;
      }
    }
  return info_error_was_printed; /*FIXME*/
}

/* Move Prev, Up or error in WINDOW depending on BEHAVIOUR. */
static int
backward_move_node_structure (WINDOW *window, int behaviour)
{
  switch (behaviour)
    {
    case IS_PageOnly:
      info_error ("%s", msg_at_node_top);
      return 1;

    case IS_NextOnly:
      if (!window->node->prev)
        {
          info_error ("%s", _("No `Prev' for this node."));
          return 1;
        }
      else
        {
          info_handle_pointer ("Prev", window);
        }
      break;

    case IS_Continuous:
      if (window->node->up)
        {
          int traverse_menus = 0;

          /* If up is the dir node, we are at the top node.
             Don't do anything. */
          if (   !strcmp ("(dir)", window->node->up)
              || !strcmp ("(DIR)", window->node->up))
            {
              info_error ("%s", 
                    _("No `Prev' or `Up' for this node within this document."));
              return 1;
            }
          /* If 'Prev' and 'Up' are the same, we are at the first node
             of the 'Up' node's menu. Go to up node. */
          else if (window->node->prev
              && !strcmp(window->node->prev, window->node->up))
            {
              info_handle_pointer ("Up", window);
            }
          /* Otherwise, go to 'Prev' node and go down the last entry
             in the menus as far as possible. */
          else if (window->node->prev)
            {
              traverse_menus = 1;
              info_handle_pointer ("Prev", window);
            }
          else /* 'Up' but no 'Prev' */
            {
              info_handle_pointer ("Up", window);
            }

          /* Repeatedly select last item of menus */
          if (traverse_menus)
            {
              REFERENCE *entry;
              while (!info_error_was_printed)
                {
                  if (entry = select_menu_digit (window, '0'))
                    {
                      info_select_reference (window, entry);
                      if (entry->line_number > 0)
                        internal_next_line (window, entry->line_number - 1, '0');
                    }
                  else
                    break;
                }
            }
        }
      else if (window->node->prev) /* 'Prev' but no 'Up' */
        {
          info_handle_pointer ("Prev", window);
        }
      else
        {
          info_error ("%s", 
                _("No `Prev' or `Up' for this node within this document."));
          return 1;
        }


      break;
    }
  return 0;
}

/* Move continuously forward through the node structure of this info file. */
DECLARE_INFO_COMMAND (info_global_next_node,
                      _("Move forwards or down through node structure"))
{
  if (count < 0)
    info_global_prev_node (window, -count, key);
  else
    {
      while (count && !info_error_was_printed)
        {
          forward_move_node_structure (window, IS_Continuous);
          count--;
        }
    }
}

/* Move continuously backward through the node structure of this info file. */
DECLARE_INFO_COMMAND (info_global_prev_node,
                      _("Move backwards or up through node structure"))
{
  if (count < 0)
    info_global_next_node (window, -count, key);
  else
    {
      while (count && !info_error_was_printed)
        {
          backward_move_node_structure (window, IS_Continuous);
          count--;
        }
    }
}


/* **************************************************************** */
/*                                                                  */
/*              Selection of cross-references and menus             */
/*                                                                  */
/* **************************************************************** */

/* Select the last menu item in WINDOW->node. */
DECLARE_INFO_COMMAND (info_last_menu_item,
   _("Select the last item in this node's menu"))
{
  info_menu_digit (window, 1, '0');
}

/* Return menu entry */
static REFERENCE *
select_menu_digit (WINDOW *window, unsigned char key)
{
  register int i, item;
  register REFERENCE **menu;

  menu = window->node->references;

  if (!menu)
    {
      info_error ("%s", msg_no_menu_node);
      return;
    }

  /* We have the menu.  See if there are this many items in it. */
  item = key - '0';

  /* Special case.  Item "0" is the last item in this menu. */
  if (item == 0)
    {
      int j;
      i = -1; /* Not found */
      for (j = 0; menu[j]; j++)
        if (menu[j]->type == REFERENCE_MENU_ITEM)
          i = j;
      if (i == -1) return 0;
    }
  else
    {
      int k = 0;
      for (i = 0; menu[i]; i++)
        {
          if (menu[i]->type == REFERENCE_MENU_ITEM)
            k++;
          if (k == item)
            break;
        }
    }

  return menu[i];
}

/* Use KEY (a digit) to select the Nth menu item in WINDOW->node. */
DECLARE_INFO_COMMAND (info_menu_digit, _("Select this menu item"))
{
  int item = key - '0';
  REFERENCE *entry;
  if (entry = select_menu_digit (window, key))
    {
      info_select_reference (window, entry);
      if (entry->line_number > 0)
        internal_next_line (window, entry->line_number - 1, key);
    }
  else if (key == '0')
    {
      /* Don't print "There aren't 0 items in this menu." */
      info_error ("%s", msg_no_menu_node);
    }
  else
    {
      info_error (ngettext ("There isn't %d item in this menu.",
                            "There aren't %d items in this menu.",
                            item),
                  item);
    }
  return;
}

static int exclude_cross_references (REFERENCE *r)
{
  return r->type == REFERENCE_XREF;
}

static int exclude_menu_items (REFERENCE *r)
{
  return r->type == REFERENCE_MENU_ITEM;
}

static int exclude_nothing (REFERENCE *r)
{
  return 1;
}

/* Read a menu or followed reference from the user defaulting to the
   reference found on the current line, and select that node.  The
   reading is done with completion. ASK_P is non-zero if the user should
   be prompted, or zero to select the item on the current line.  MENU_ITEM
   and XREF control whether menu items and cross-references are eligible
   for selection. */
static void
info_menu_or_ref_item (WINDOW *window, unsigned char key,
                       int menu_item, int xref, int ask_p)
{
  REFERENCE *defentry = NULL; /* Default link */
  REFERENCE **refs = window->node->references;
  REFERENCE *entry;

  /* Name of destination */
  char *line;

  int line_no;
  int this_line, next_line;

  int which, closest = -1;

  reference_bool_fn exclude; 
  if (menu_item && !xref)
    {
      exclude = &exclude_cross_references;
    }
  else if (!menu_item && xref)
    {
      exclude = &exclude_menu_items;
    }
  else if (menu_item && xref)
    {
      exclude = &exclude_nothing;
    }
  else /* !menu_item && !xref */
    return;

  /* Default the selected reference to the one which is on the line that
     point is in. */

  line_no = window_line_of_point (window);
  this_line = window->line_starts[line_no] - window->node->contents;
  if (window->line_starts[line_no + 1])
    next_line = window->line_starts[line_no + 1] - window->node->contents;
  else
    next_line = window->node->nodelen;

  for (which = 0; refs[which]; which++)
    {
      /* Check the type of reference is one we are looking for. */
      if (!(  (menu_item && refs[which]->type == REFERENCE_MENU_ITEM)
           || (xref      && refs[which]->type == REFERENCE_XREF)))
        continue;

      /* If reference starts in current line, it is eligible */
      if (   refs[which]->start >= this_line
          && refs[which]->start <  next_line)
        closest = which;

      /* If point is inside a reference, choose that one. */
      if (   window->point >= refs[which]->start
          && window->point <= refs[which]->end)
        {
          closest = which;
          break;
        }

      /* If we got to the next line without finding an eligible reference. */
      if (refs[which]->start >= next_line)
        break;
    }
  if (closest != -1)
    defentry = refs[closest];

  /* If we are going to ask the user a question, do it now. */
  if (ask_p)
    {
      char *prompt;

      /* Build the prompt string. */
      if (menu_item && !xref)
        {
          if (defentry)
            {
              prompt = xmalloc (strlen (defentry->label)
                                + strlen (_("Menu item (%s): ")));
              sprintf (prompt, _("Menu item (%s): "), defentry->label);
            }
          else
            prompt = xstrdup (_("Menu item: "));
        }
      else
        {
          if (defentry)
            {
              prompt = xmalloc (strlen (defentry->label)
                                + strlen (_("Follow xref (%s): ")));
              sprintf (prompt, _("Follow xref (%s): "), defentry->label);
            }
          else
            prompt = xstrdup (_("Follow xref: "));
        }

      line = info_read_completing_in_echo_area_with_exclusions
               (window, prompt, refs, exclude);
      free (prompt);

      window = active_window;

      /* User aborts, just quit. */
      if (!line)
        {
          info_abort_key (window, 0, 0);
          return;
        }

      /* If we had a default and the user accepted it, use that. */
      if (!*line)
        {
          free (line);
          if (defentry)
            line = xstrdup (defentry->label);
          else
            line = NULL;
        }
    }
  else
    {
      /* Not going to ask any questions.  If we have a default entry, use
         that, otherwise return. */
      if (!defentry)
        return;
      else
        line = xstrdup (defentry->label);
    }

  if (line)
    {
      /* It is possible that the references have more than a single
         entry with the same label, and also LINE is down-cased, which
         complicates matters even more.  Try to be as accurate as we
         can: if they've chosen the default, use defentry directly. */
      if (defentry && strcmp (line, defentry->label) == 0)
        entry = defentry;
      else
        /* Find the selected label in the references.  If there are
           more than one label which matches, find the one that's
           closest to point.  */
        {
          register int i;
          int best = -1, min_dist = window->node->nodelen;
          REFERENCE *ref;

          for (i = 0; refs && (ref = refs[i]); i++)
            {
              /* Need to use mbscasecmp because LINE is downcased
                 inside info_read_completing_in_echo_area.  */
              if (mbscasecmp (line, ref->label) == 0)
                {
                  /* ref->end is more accurate estimate of position
                     for menus than ref->start.  Go figure.  */
                  int dist = abs (window->point - ref->end);

                  if (dist < min_dist)
                    {
                      min_dist = dist;
                      best = i;
                    }
                }
            }
          if (best != -1)
            entry = refs[best];
          else
            entry = NULL;
        }

      if (!entry && defentry)
        info_error (_("The reference disappeared! (%s)."), line);
      else
        {
          NODE *orig = window->node;
          info_select_reference (window, entry);

          if (entry->line_number > 0)
            /* next_line starts at line 1?  Anyway, the -1 makes it
               move to the right line.  */
            internal_next_line (window, entry->line_number - 1, key);

        }

      free (line);
    }

  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* Read a line (with completion) which is the name of a menu item,
   and select that item. */
DECLARE_INFO_COMMAND (info_menu_item, _("Read a menu item and select its node"))
{
  info_menu_or_ref_item (window, key, 1, 0, 1);
}

/* Read a line (with completion) which is the name of a reference to
   follow, and select the node. */
DECLARE_INFO_COMMAND
  (info_xref_item, _("Read a footnote or cross reference and select its node"))
{
  info_menu_or_ref_item (window, key, 0, 1, 1);
}

/* Position the cursor at the start of this node's menu. */
DECLARE_INFO_COMMAND (info_find_menu, _("Move to the start of this node's menu"))
{
  SEARCH_BINDING binding;
  long position;

  binding.buffer = window->node->contents;
  binding.start  = 0;
  binding.end = window->node->nodelen;
  binding.flags = S_FoldCase | S_SkipDest;

  if (search (INFO_MENU_LABEL, &binding, &position) == search_success)
    {
      window->point = position;
      window_adjust_pagetop (window);
      window->flags |= W_UpdateWindow;
    }
  else
    info_error ("%s", msg_no_menu_node);
}

/* Visit as many menu items as is possible, each in a separate window. */
DECLARE_INFO_COMMAND (info_visit_menu,
  _("Visit as many menu items at once as possible"))
{
  register int i;
  REFERENCE *entry, **menu;

  menu = window->node->references;

  if (!menu)
    info_error ("%s", msg_no_menu_node);

  for (i = 0; (!info_error_was_printed) && (entry = menu[i]); i++)
    {
      WINDOW *new;

      if (entry->type != REFERENCE_MENU_ITEM) continue;

      new = window_make_window (window->node);
      window_tile_windows (TILE_INTERNALS);

      if (!new)
        info_error ("%s", msg_win_too_small);
      else
        {
          active_window = new;
          info_select_reference (new, entry);
        }
    }
}

/* Move to the next or previous cross reference in this node. */
static int
info_move_to_xref (WINDOW *window, int count, unsigned char key, int dir)
{
  long firstmenu, firstxref;
  long nextmenu, nextxref;
  long placement = -1;
  long start = 0;
  NODE *node = window->node;
  REFERENCE **ref;
  int nextref;

  /* Fail if there are no references in node */
  if (!node->references)
    {
      if (!cursor_movement_scrolls_p)
              info_error ("%s", msg_no_xref_node);
      return cursor_movement_scrolls_p;
    }

  if (dir == 1) /* Search forwards */
    for (ref = node->references; *ref != 0; ref++)
      {
        if ((*ref)->start > window->point)
          {
            placement = (*ref)->start;
            break;
          }
      }
  else /* Search backwards */
    for (ref = node->references; *ref != 0; ref++)
      {
        if ((*ref)->start >= window->point) break;
        placement = (*ref)->start;
      }

  /* If there was neither a menu or xref entry appearing in this node after
     point, choose the first menu or xref entry appearing in this node. */
  if (placement == -1)
    {
      if (cursor_movement_scrolls_p)
        return 1;
      else
        placement = node->references[0]->start;
    }

  window->point = placement;
  window_adjust_pagetop (window);
  window->flags |= W_UpdateWindow;
  return 0;
}

DECLARE_INFO_COMMAND (info_move_to_prev_xref,
                      _("Move to the previous cross reference"))
{
  if (count < 0)
    info_move_to_prev_xref (window, -count, key);
  else
    {
      while (info_move_to_xref (window, count, key, -1))
        {
          info_error_was_printed = 0;
          if (backward_move_node_structure (window, info_scroll_behaviour))
            break;
          move_to_new_line (window->line_count, window->line_count - 1,
                            window);
        }
    }
}

DECLARE_INFO_COMMAND (info_move_to_next_xref,
                      _("Move to the next cross reference"))
{
  if (count < 0)
    info_move_to_next_xref (window, -count, key);
  else
    {
      /* Note: This can cause some blinking when the next cross reference is
         located several nodes further. This effect can be easily suppressed
         by setting display_inhibited to 1, however this will also make
         error messages to be dumped on stderr, instead on the echo area. */ 
      while (info_move_to_xref (window, count, key, 1))
        {
          info_error_was_printed = 0;
          if (forward_move_node_structure (window, info_scroll_behaviour))
            break;
          move_to_new_line (0, 0, window);
        }
    }
}

/* Select the menu item or reference that appears on this line. */
DECLARE_INFO_COMMAND (info_select_reference_this_line,
                      _("Select reference or menu item appearing on this line"))
{
  REFERENCE **ref = window->node->references;

  if (!ref || !*ref) return; /* No references in node */

  info_menu_or_ref_item (window, key, 1, 1, 0);
}


/* Read a line of input which is a node name, and go to that node. */
DECLARE_INFO_COMMAND (info_goto_node, _("Read a node name and select it"))
{
  char *line;

#define GOTO_COMPLETES
#if defined (GOTO_COMPLETES)
  /* Build a completion list of all of the known nodes. */
  {
    register int fbi, i;
    FILE_BUFFER *current;
    REFERENCE **items = NULL;
    size_t items_index = 0;
    size_t items_slots = 0;

    current = file_buffer_of_window (window);

    for (fbi = 0; info_loaded_files && info_loaded_files[fbi]; fbi++)
      {
        FILE_BUFFER *fb;
        REFERENCE *entry;
        int this_is_the_current_fb;

        fb = info_loaded_files[fbi];
        this_is_the_current_fb = (current == fb);

        entry = xmalloc (sizeof (REFERENCE));
        entry->filename = entry->nodename = NULL;
        entry->label = xmalloc (4 + strlen (fb->filename));
        sprintf (entry->label, "(%s)*", fb->filename);

        add_pointer_to_array (entry, items_index, items, items_slots, 10);

        if (fb->tags)
          {
            for (i = 0; fb->tags[i]; i++)
              {
                entry = xmalloc (sizeof (REFERENCE));
                entry->filename = entry->nodename = NULL;
                if (this_is_the_current_fb)
                  entry->label = xstrdup (fb->tags[i]->nodename);
                else
                  {
                    entry->label = xmalloc
                      (4 + strlen (fb->filename) +
                       strlen (fb->tags[i]->nodename));
                    sprintf (entry->label, "(%s)%s",
                             fb->filename, fb->tags[i]->nodename);
                  }

                add_pointer_to_array (entry, items_index, items, 
                                      items_slots, 100);
              }
          }
      }
    line = info_read_maybe_completing (window, _("Goto node: "),
        items);
    info_free_references (items);
  }
#else /* !GOTO_COMPLETES */
  line = info_read_in_echo_area (window, _("Goto node: "));
#endif /* !GOTO_COMPLETES */

  /* If the user aborted, quit now. */
  if (!line)
    {
      info_abort_key (window, 0, 0);
      return;
    }

  canonicalize_whitespace (line);

  if (*line)
    info_parse_and_select (line, window);

  free (line);
  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* Follow the menu list in MENUS (list of strings terminated by a NULL
   entry) from INITIAL_NODE.  If can't continue at any point (no menu or
   no menu entry for the next item), return the node so far -- that
   might be INITIAL_NODE itself.  If error, *ERRSTR and *ERRARG[12] will
   be set to the error message and argument for message, otherwise they
   will be NULL.  */

NODE *
info_follow_menus (NODE *initial_node, char **menus, NODE **err_node,
		   int strict)
{
  NODE *node = NULL;

  if (err_node)
    *err_node = NULL;
  for (; *menus; menus++)
    {
      static char *first_arg = NULL;
      REFERENCE **menu;
      REFERENCE *entry;
      char *arg = *menus; /* Remember the name of the menu entry we want. */

      debug (3, ("looking for %s in %s:%s", arg, initial_node->filename,
		 initial_node->nodename));
      /* A leading space is certainly NOT part of a node name.  Most
         probably, they typed a space after the separating comma.  The
         strings in menus[] have their whitespace canonicalized, so
         there's at most one space to ignore.  */
      if (*arg == ' ')
        arg++;
      if (!first_arg)
        first_arg = arg;

      menu = initial_node->references;

      /* If no menu item in this node, stop here, but let the user
         continue to use Info.  Perhaps they wanted this node and didn't
         realize it. */
      if (!menu)
        {
	  debug (3, ("no menu found"));
          if (arg == first_arg && !strict)
            {
              node = get_manpage_node (first_arg);
              if (node)
		{
		  debug (3, ("falling back to manpage node"));
		  goto maybe_got_node;
		}
            }
	  if (err_node)
	    *err_node = format_message_node (_("No menu in node `%s'."),
					     node_printed_rep (initial_node));
          return strict ? NULL : initial_node;
        }

      /* Find the specified menu item. */
      entry = info_get_menu_entry_by_label (arg, menu);

      /* If the item wasn't found, search the list sloppily.  Perhaps this
         user typed "buffer" when they really meant "Buffers". */
      if (!entry)
        {
          int i;
          int best_guess = -1;

	  debug (3, ("no entry found: guessing"));
          for (i = 0; (entry = menu[i]); i++)
            {
              if (mbscasecmp (entry->label, arg) == 0)
                break;
              else if (!strict && (best_guess == -1)
                    && (mbsncasecmp (entry->label, arg, strlen (arg)) == 0))
                  best_guess = i;
            }

          if (!entry && best_guess != -1)
            entry = menu[best_guess];
        }

      /* If we still failed to find the reference, start Info with the current
         node anyway.  It is probably a misspelling. */
      if (!entry)
        {
          if (arg == first_arg)
            {
              /* Maybe they typed "info foo" instead of "info -f foo".  */
              node = info_get_node (first_arg, NULL, PARSE_NODE_DFLT);
              if (node)
                add_file_directory_to_path (first_arg);
	      else if (strict)
		return NULL;
              else
                node = get_manpage_node (first_arg);
              if (node)
                goto maybe_got_node;
            }

	  if (err_node)
	    *err_node = format_message_node (_("No menu item `%s' in node `%s'."),
					     arg,
					     node_printed_rep (initial_node));
          return strict ? NULL : initial_node;
        }

      /* We have found the reference that the user specified.  If no
         filename in this reference, define it. */
      if (!entry->filename)
        entry->filename = xstrdup (initial_node->parent ? initial_node->parent
                                                     : initial_node->filename);

      debug (3, ("entry: %s, %s", entry->filename, entry->nodename));
      
      /* Try to find this node.  */
      node = info_get_node (entry->filename, entry->nodename, 
                            PARSE_NODE_VERBATIM);
      if (!strict && !node && arg == first_arg)
        {
          node = get_manpage_node (first_arg);
          if (node)
            goto maybe_got_node;
        }

      /* Since we cannot find it, try using the label of the entry as a
         file, i.e., "(LABEL)Top".  */
      if (!node && entry->nodename
          && strcmp (entry->label, entry->nodename) == 0)
        node = info_get_node (entry->label, "Top", PARSE_NODE_DFLT);

    maybe_got_node:
      if (!node)
        {
	  debug (3, ("no matching node found"));
	  if (err_node)
	    *err_node = format_message_node (
		     _("Unable to find node referenced by `%s' in `%s'."),
		     entry->label,
		     node_printed_rep (initial_node));
          return strict ? NULL : initial_node;
        }

      debug (3, ("node: %s, %s", node->filename, node->nodename));
      
      /* Success.  Go round the loop again.  */
      free (initial_node);
      initial_node = node;
    }

  return initial_node;
}

/* Split STR into individual node names by writing null bytes in wherever
   there are commas and constructing a list of the resulting pointers.
   (We can do this since STR has had canonicalize_whitespace called on it.)
   Return array terminated with NULL.  */

static char **
split_list_of_nodenames (char *str)
{
  unsigned len = 2;
  char **nodes = xmalloc (len * sizeof (char *));

  nodes[len - 2] = str;

  while (*str++)
    {
      if (*str == ',')
        {
          *str++ = 0;           /* get past the null byte */
          len++;
          nodes = xrealloc (nodes, len * sizeof (char *));
          nodes[len - 2] = str;
        }
    }

  nodes[len - 1] = NULL;

  return nodes;
}


/* Read a line of input which is a sequence of menus (starting from
   dir), and follow them.  */
DECLARE_INFO_COMMAND (info_menu_sequence,
   _("Read a list of menus starting from dir and follow them"))
{
  char *line = info_read_in_echo_area (window, _("Follow menus: "));

  /* If the user aborted, quit now. */
  if (!line)
    {
      info_abort_key (window, 0, 0);
      return;
    }

  canonicalize_whitespace (line);

  if (*line)
    {
      NODE *err_node;
      NODE *dir_node = info_get_node (NULL, NULL, PARSE_NODE_DFLT);
      char **nodes = split_list_of_nodenames (line);
      NODE *node = NULL;

      /* If DIR_NODE is NULL, they might be reading a file directly,
         like in "info -d . -f ./foo".  Try using "Top" instead.  */
      if (!dir_node)
        {
          char *file_name = window->node->parent;

          if (!file_name)
            file_name = window->node->filename;
          dir_node = info_get_node (file_name, NULL, PARSE_NODE_DFLT);
        }

      /* If we still cannot find the starting point, give up.
         We cannot allow a NULL pointer inside info_follow_menus.  */
      if (!dir_node)
        info_error (msg_cant_find_node, "Top");
      else
        node = info_follow_menus (dir_node, nodes, &err_node, 0);

      free (nodes);
      if (err_node)
	show_error_node (err_node);
      else
        info_set_node_of_window (1, window, node);
    }

  free (line);
  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* Search the menu MENU for a (possibly mis-spelled) entry ARG.
   Return the menu entry, or the best guess for what they meant by ARG,
   or NULL if there's nothing in this menu seems to fit the bill.
   If EXACT is non-zero, allow only exact matches.  */
static REFERENCE *
entry_in_menu (char *arg, REFERENCE **menu, int exact)
{
  REFERENCE *entry;

  /* First, try to find the specified menu item verbatim.  */
  entry = info_get_menu_entry_by_label (arg, menu);

  /* If the item wasn't found, search the list sloppily.  Perhaps we
     have "Option Summary", but ARG is "option".  */
  if (!entry && !exact)
    {
      int i;
      int best_guess = -1;

      for (i = 0; (entry = menu[i]); i++)
        {
          if (REFERENCE_MENU_ITEM != entry->type) continue;

          if (mbscasecmp (entry->label, arg) == 0)
            break;
          else
            if (mbsncasecmp (entry->label, arg, strlen (arg)) == 0)
              best_guess = i;
        }

      if (!entry && best_guess != -1)
        entry = menu[best_guess];
    }

  return entry;
}

/* Find the node that is the best candidate to list the PROGRAM's
   invocation info and its command-line options, by looking for menu
   items and chains of menu items with characteristic names.  */
void
info_intuit_options_node (WINDOW *window, NODE *initial_node, char *program)
{
  /* The list of node names typical for GNU manuals where the program
     usage and specifically the command-line arguments are described.
     This is pure heuristics.  I gathered these node names by looking
     at all the Info files I could put my hands on.  If you are
     looking for evidence to complain to the GNU project about
     non-uniform style of documentation, here you have your case!  */
  static const char *invocation_nodes[] = {
    "%s invocation",
    "Invoking %s",
    "Preliminaries",    /* m4 has Invoking under Preliminaries! */
    "Invocation",
    "Command Arguments",/* Emacs */
    "Invoking `%s'",
    "%s options",
    "Options",
    "Option ",          /* e.g. "Option Summary" */
    "Invoking",
    "All options",      /* tar, paxutils */
    "Arguments",
    "%s cmdline",       /* ar */
    "%s",               /* last resort */
    (const char *)0
  };
  NODE *node = NULL;
  REFERENCE **menu;
  const char **try_node;

  /* We keep looking deeper and deeper in the menu structure until
     there are no more menus or no menu items from the above list.
     Some manuals have the invocation node sitting 3 or 4 levels deep
     in the menu hierarchy...  */
  for (node = initial_node; node; initial_node = node)
    {
      REFERENCE *entry = NULL;

      menu = initial_node->references;

      /* If no menu item in this node, stop here.  Perhaps this node
         is the one they need.  */
      if (!menu)
        break;

      /* Look for node names typical for usage nodes in this menu.  */
      for (try_node = invocation_nodes; *try_node; try_node++)
        {
          char *nodename;

          nodename = xmalloc (strlen (program) + strlen (*try_node));
          sprintf (nodename, *try_node, program);
          /* The last resort "%s" is dangerous, so we restrict it
             to exact matches here.  */
          entry = entry_in_menu (nodename, menu,
                                 strcmp (*try_node, "%s") == 0);
          free (nodename);
          if (entry)
            break;
        }

      if (!entry)
        break;

      if (!entry->filename)
        entry->filename = xstrdup (initial_node->parent ? initial_node->parent
                                   : initial_node->filename);
      /* Try to find this node.  */
      node = info_get_node (entry->filename, entry->nodename, 
                            PARSE_NODE_VERBATIM);
      if (!node)
        break;
    }

  /* We've got our best shot at the invocation node.  Now select it.  */
  if (initial_node)
    info_set_node_of_window (1, window, initial_node);
  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* Given a name of an Info file, find the name of the package it
   describes by removing the leading directories and extensions.  */
char *
program_name_from_file_name (char *file_name)
{
  int i;
  char *program_name = xstrdup (filename_non_directory (file_name));

  for (i = strlen (program_name) - 1; i > 0; i--)
    if (program_name[i] == '.'
        && (FILENAME_CMPN (program_name + i, ".info", 5) == 0
            || FILENAME_CMPN (program_name + i, ".inf", 4) == 0
#ifdef __MSDOS__
            || FILENAME_CMPN (program_name + i, ".i", 2) == 0
#endif
            || isdigit (program_name[i + 1]))) /* a man page foo.1 */
      {
        program_name[i] = 0;
        break;
      }
  return program_name;
}

DECLARE_INFO_COMMAND (info_goto_invocation_node,
                      _("Find the node describing program invocation"))
{
  const char *invocation_prompt = _("Find Invocation node of [%s]: ");
  char *program_name, *line;
  char *default_program_name, *prompt, *file_name;
  NODE *top_node;

  /* Intuit the name of the program they are likely to want.
     We use the file name of the current Info file as a hint.  */
  file_name = window->node->parent ? window->node->parent
                                   : window->node->filename;
  default_program_name = program_name_from_file_name (file_name);

  prompt = xmalloc (strlen (default_program_name) +
		    strlen (invocation_prompt));
  sprintf (prompt, invocation_prompt, default_program_name);
  line = info_read_in_echo_area (window, prompt);
  free (prompt);
  if (!line)
    {
      info_abort_key (window, 0, 0);
      return;
    }
  if (*line)
    program_name = line;
  else
    program_name = default_program_name;

  /* In interactive usage they'd probably expect us to begin looking
     from the Top node.  */
  top_node = info_get_node (file_name, NULL, PARSE_NODE_DFLT);
  if (!top_node)
    info_error (msg_cant_find_node, "Top");

  info_intuit_options_node (window, top_node, program_name);
  free (line);
  free (default_program_name);
}

DECLARE_INFO_COMMAND (info_man, _("Read a manpage reference and select it"))
{
  char *line;

  line = info_read_in_echo_area (window, _("Get Manpage: "));

  if (!line)
    {
      info_abort_key (window, 0, 0);
      return;
    }

  canonicalize_whitespace (line);

  if (*line)
    {
      NODE *manpage = info_get_node (MANPAGE_FILE_BUFFER_NAME, line, 0);
      if (manpage)
        info_set_node_of_window (1, window, manpage);
    }

  free (line);
  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* Move to the "Top" node in this file. */
DECLARE_INFO_COMMAND (info_top_node, _("Select the node `Top' in this file"))
{
  info_parse_and_select ("Top", window);
}

/* Move to the node "(dir)Top". */
DECLARE_INFO_COMMAND (info_dir_node, _("Select the node `(dir)'"))
{
  info_parse_and_select ("(dir)Top", window);
}


/* Read the name of a node to kill.  The list of available nodes comes
   from the nodes appearing in the current window configuration. */
static char *
read_nodename_to_kill (WINDOW *window)
{
  int iw;
  char *nodename;
  INFO_WINDOW *info_win;
  REFERENCE **menu = NULL;
  size_t menu_index = 0, menu_slots = 0;
  char *default_nodename = xstrdup (active_window->node->nodename);
  char *prompt = xmalloc (strlen (_("Kill node (%s): ")) + strlen (default_nodename));

  sprintf (prompt, _("Kill node (%s): "), default_nodename);

  for (iw = 0; (info_win = info_windows[iw]); iw++)
    {
      REFERENCE *entry = xmalloc (sizeof (REFERENCE));
      entry->label = xstrdup (info_win->window->node->nodename);
      entry->filename = entry->nodename = NULL;

      add_pointer_to_array (entry, menu_index, menu, menu_slots, 10);
    }

  nodename = info_read_completing_in_echo_area (window, prompt, menu);
  free (prompt);
  info_free_references (menu);
  if (nodename && !*nodename)
    {
      free (nodename);
      nodename = default_nodename;
    }
  else
    free (default_nodename);

  return nodename;
}


/* Delete NODENAME from this window, showing the most
   recently selected node in this window. */
static void
kill_node (WINDOW *window, char *nodename)
{
  int iw, i;
  INFO_WINDOW *info_win;
  NODE *temp;

  /* If there is no nodename to kill, quit now. */
  if (!nodename)
    {
      info_abort_key (window, 0, 0);
      return;
    }

  /* If there is a nodename, find it in our window list. */
  for (iw = 0; (info_win = info_windows[iw]); iw++)
    if (strcmp (nodename, info_win->nodes[info_win->current]->nodename) == 0
        && info_win->window == window)
      break;

  if (!info_win)
    {
      if (*nodename)
        info_error (_("Cannot kill node `%s'"), nodename);
      else
        window_clear_echo_area ();

      return;
    }

  /* If there are no more nodes left anywhere to view, complain and exit. */
  if (info_windows_index == 1 && info_windows[0]->nodes_index == 1)
    {
      info_error ("%s", _("Cannot kill the last node"));
      return;
    }

  /* INFO_WIN contains the node that the user wants to stop viewing.  Delete
     this node from the list of nodes previously shown in this window. */
  for (i = info_win->current; i < info_win->nodes_index; i++)
    info_win->nodes[i] = info_win->nodes[i + 1];

  /* There is one less node in this window's history list. */
  info_win->nodes_index--;

  /* Make this window show the most recent history node. */
  info_win->current = info_win->nodes_index - 1;

  /* If there aren't any nodes left in this window, steal one from the
     next window. */
  if (info_win->current < 0)
    {
      INFO_WINDOW *stealer;
      int which, pagetop;
      long point;

      if (info_windows[iw + 1])
        stealer = info_windows[iw + 1];
      else
        stealer = info_windows[0];

      /* If the node being displayed in the next window is not the most
         recently loaded one, get the most recently loaded one. */
      if ((stealer->nodes_index - 1) != stealer->current)
        which = stealer->nodes_index - 1;

      /* Else, if there is another node behind the stealers current node,
         use that one. */
      else if (stealer->current > 0)
        which = stealer->current - 1;

      /* Else, just use the node appearing in STEALER's window. */
      else
        which = stealer->current;

      /* Copy this node. */
      {
        temp = xmalloc (sizeof (NODE));
        *temp = *stealer->nodes[which];
        point = stealer->points[which];
        pagetop = stealer->pagetops[which];
      }

      window_set_node_of_window (info_win->window, temp);
      window->point = point;
      window->pagetop = pagetop;
      remember_window_and_node (info_win->window, temp);
    }
  else
    {
      temp = info_win->nodes[info_win->current];
      temp->display_pos = info_win->points[info_win->current];
      window_set_node_of_window (info_win->window, temp);
    }

  if (!info_error_was_printed)
    window_clear_echo_area ();

  if (auto_footnotes_p)
    info_get_or_remove_footnotes (window);
}

/* Kill current node, thus going back one in the node history.  I (karl)
   do not think this is completely correct yet, because of the
   window-changing stuff in kill_node, but it's a lot better than the
   previous implementation, which did not account for nodes being
   visited twice at all.  */
DECLARE_INFO_COMMAND (info_history_node,
                      _("Select the most recently selected node"))
{
  kill_node (window, active_window->node->nodename);
}

/* Kill named node.  */
DECLARE_INFO_COMMAND (info_kill_node, _("Kill this node"))
{
  char *nodename = read_nodename_to_kill (window);
  kill_node (window, nodename);
}


/* Read the name of a file and select the entire file. */
DECLARE_INFO_COMMAND (info_view_file, _("Read the name of a file and select it"))
{
  char *line;

  line = info_read_in_echo_area (window, _("Find file: "));
  if (!line)
    {
      info_abort_key (active_window, 1, 0);
      return;
    }

  if (*line)
    {
      NODE *node;

      node = info_get_node (line, "*", PARSE_NODE_DFLT);
      if (!node)
        {
          if (info_recent_file_error)
            info_error ("%s", info_recent_file_error);
          else
            info_error (_("Cannot find `%s'."), line);
        }
      else
        info_set_node_of_window (1, window, node);

      free (line);
    }

  if (!info_error_was_printed)
    window_clear_echo_area ();
}

/* **************************************************************** */
/*                                                                  */
/*                 Dumping and Printing Nodes                       */
/*                                                                  */
/* **************************************************************** */

enum
  {
    DUMP_SUCCESS,
    DUMP_INFO_ERROR,
    DUMP_SYS_ERROR
  };

static int write_node_to_stream (NODE *node, FILE *stream);
static int dump_node_to_stream (char *filename, char *nodename,
				FILE *stream, int dump_subnodes);
static void initialize_dumping (void);

/* Dump the nodes specified by FILENAME and NODENAMES to the file named
   in OUTPUT_FILENAME.  If DUMP_SUBNODES is set, recursively dump
   the nodes which appear in the menu of each node dumped. */
void
dump_nodes_to_file (char *filename, char **nodenames,
		    char *output_filename, int flags)
{
  int i;
  FILE *output_stream;
  
  debug (1, (_("writing file %s"), filename));

  /* Get the stream to print the nodes to.  Special case of an output
     filename of "-" means to dump the nodes to stdout. */
  if (strcmp (output_filename, "-") == 0)
    output_stream = stdout;
  else
    output_stream = fopen (output_filename, flags & DUMP_APPEND ? "a" : "w");

  if (!output_stream)
    {
      info_error (_("Could not create output file `%s'."), output_filename);
      return;
    }

  initialize_dumping ();

  /* Print each node to stream. */
  if (flags & DUMP_APPEND)
    fputc ('\f', output_stream);
  for (i = 0; nodenames[i]; i++)
    {
      if (dump_node_to_stream (filename, nodenames[i], output_stream,
			       flags & DUMP_SUBNODES) == DUMP_SYS_ERROR)
	{
	  info_error (_("error writing to %s: %s"), filename, strerror (errno));
	  exit (EXIT_FAILURE);
	}
    }
  
  if (output_stream != stdout)
    fclose (output_stream);

  debug (1, (_("closing %s"), filename));
}

/* A place to remember already dumped nodes. */
static struct info_namelist_entry *dumped_already;

static void
initialize_dumping (void)
{
  info_namelist_free (dumped_already);
  dumped_already = NULL;
}

/* Get and print the node specified by FILENAME and NODENAME to STREAM.
   If DUMP_SUBNODES is non-zero, recursively dump the nodes which appear
   in the menu of each node dumped. */
static int
dump_node_to_stream (char *filename, char *nodename,
		     FILE *stream, int dump_subnodes)
{
  register int i;
  NODE *node;

  node = info_get_node (filename, nodename, PARSE_NODE_DFLT);

  if (!node)
    {
      if (info_recent_file_error)
        info_error ("%s", info_recent_file_error);
      else
        {
          if (filename && *nodename != '(')
            info_error (msg_cant_file_node,
                        filename_non_directory (filename),
                        nodename);
          else
            info_error (msg_cant_find_node, nodename);
        }
      return DUMP_INFO_ERROR;
    }

  /* If we have already dumped this node, don't dump it again. */
  if (info_namelist_add (&dumped_already, node->nodename))
    {
      free (node);
      return DUMP_SUCCESS;
    }

  /* Maybe we should print some information about the node being output. */
  debug (1, (_("writing node %s..."), node_printed_rep (node)));

  if (write_node_to_stream (node, stream))
    return DUMP_SYS_ERROR;

  /* If we are dumping subnodes, get the list of menu items in this node,
     and dump each one recursively. */
  if (dump_subnodes)
    {
      REFERENCE **menu = NULL;

      /* If this node is an Index, do not dump the menu references. */
      if (string_in_line ("Index", node->nodename) == -1)
        menu = node->references;

      if (menu)
        {
          for (i = 0; menu[i]; i++)
            {
              if (REFERENCE_MENU_ITEM != menu[i]->type) continue;

              /* We don't dump Info files which are different than the
                 current one. */
              if (!menu[i]->filename)
                if (dump_node_to_stream (filename, menu[i]->nodename,
					 stream, dump_subnodes) == DUMP_SYS_ERROR)
		  return DUMP_SYS_ERROR;
            }
        }
    }

  free (node);

  return DUMP_SUCCESS;
}

/* Dump NODE to FILENAME.  If DUMP_SUBNODES is set, recursively dump
   the nodes which appear in the menu of each node dumped. */
void
dump_node_to_file (NODE *node, char *filename, int flags)
{
  FILE *output_stream;
  char *nodes_filename;

  debug (1, (_("writing file %s"), filename));
  
  /* Get the stream to print this node to.  Special case of an output
     filename of "-" means to dump the nodes to stdout. */
  if (strcmp (filename, "-") == 0)
    output_stream = stdout;
  else
    output_stream = fopen (filename, flags & DUMP_APPEND ? "a" : "w");

  if (!output_stream)
    {
      info_error (_("Could not create output file `%s'."), filename);
      return;
    }

  if (node->parent)
    nodes_filename = node->parent;
  else
    nodes_filename = node->filename;

  initialize_dumping ();
  
  if (flags & DUMP_APPEND)
    fputc ('\f', output_stream);
  fprintf (output_stream, "%s\n", info_find_fullpath (node->filename));

  if (dump_node_to_stream (nodes_filename, node->nodename,
			   output_stream, flags & DUMP_SUBNODES)
      == DUMP_SYS_ERROR)
    {
      info_error (_("error writing to %s: %s"), filename, strerror (errno));
      exit (EXIT_FAILURE);
    }

  if (output_stream != stdout)
    fclose (output_stream);

  debug (1, (_("closing file %s"), filename));
}

#if !defined (DEFAULT_INFO_PRINT_COMMAND)
#  define DEFAULT_INFO_PRINT_COMMAND "lpr"
#endif /* !DEFAULT_INFO_PRINT_COMMAND */

DECLARE_INFO_COMMAND (info_print_node,
 _("Pipe the contents of this node through INFO_PRINT_COMMAND"))
{
  print_node (window->node);
}

/* Print NODE on a printer piping it into INFO_PRINT_COMMAND. */
void
print_node (NODE *node)
{
  FILE *printer_pipe;
  char *print_command = getenv ("INFO_PRINT_COMMAND");
  int piping = 0;

  if (!print_command || !*print_command)
    print_command = DEFAULT_INFO_PRINT_COMMAND;

  /* Note that on MS-DOS/MS-Windows, this MUST open the pipe in the
     (default) text mode, since the printer drivers there need to see
     DOS-style CRLF pairs at the end of each line.

     FIXME: if we are to support Mac-style text files, we might need
     to convert the text here.  */

  /* INFO_PRINT_COMMAND which says ">file" means write to that file.
     Presumably, the name of the file is the local printer device.  */
  if (*print_command == '>')
    printer_pipe = fopen (++print_command, "w");
  else
    {
      printer_pipe = popen (print_command, "w");
      piping = 1;
    }

  if (!printer_pipe)
    {
      info_error (_("Cannot open pipe to `%s'."), print_command);
      return;
    }

  /* Maybe we should print some information about the node being output. */
  debug (1, (_("printing node %s..."), node_printed_rep (node)));

  write_node_to_stream (node, printer_pipe);
  if (piping)
    pclose (printer_pipe);
  else
    fclose (printer_pipe);

  debug (1, (_("finished printing node %s"), node_printed_rep (node)));
}

static int
write_node_to_stream (NODE *node, FILE *stream)
{
  return fwrite (node->contents, node->nodelen, 1, stream) != 1;
}

/* **************************************************************** */
/*                                                                  */
/*                    Info Searching Commands                       */
/*                                                                  */
/* **************************************************************** */

/* Variable controlling the garbage collection of files briefly visited
   during searches.  Such files are normally gc'ed, unless they were
   compressed to begin with.  If this variable is non-zero, it says
   to gc even those file buffer contents which had to be uncompressed. */
int gc_compressed_files = 0;

static void info_gc_file_buffers (void);
static void info_search_1 (WINDOW *window, int count,
			   unsigned char key, int case_sensitive,
			   int ask_for_string, long start);
#define DFL_START (-1) /* a special value for the START argument of
			  info_search_1, meaning to use the default
			  starting position */

static char *search_string = NULL;
static int search_string_size = 0;
static int isearch_is_active = 0;

static int last_search_direction = 0;
static int last_search_case_sensitive = 0;

/* Return the file buffer which belongs to WINDOW's node. */
FILE_BUFFER *
file_buffer_of_window (WINDOW *window)
{
  /* If this window has no node, then it has no file buffer. */
  if (!window->node)
    return NULL;

  if (window->node->parent)
    return info_find_file (window->node->parent);

  if (window->node->filename)
    return info_find_file (window->node->filename);

  return NULL;
}

/* Search for STRING in NODE starting at START.  If the string was found,
   return its location in POFF.  If WINDOW is passed as non-null, set the
   window's node to be NODE, its point to be the found string, and readjust
   the window's pagetop.  The DIR argument says which direction to search
   in.  If it is positive, search forward, else backwards.

   The last argument, RESBND, makes sense only when USE_REGEX is set.
   If the regexp search succeeds, RESBND is filled with the final state
   of the search binding.  In particular, its START and END fields contain
   bounds of the found string instance.
*/
static enum search_result
info_search_in_node_internal (char *string, NODE *node, long int start,
			      WINDOW *window, int dir, int case_sensitive,
			      int match_nodename, int match_regexp,
			      long *poff, SEARCH_BINDING *resbnd)
{
  SEARCH_BINDING binding;
  enum search_result result = search_not_found;
    
  binding.flags = 0;
  if (!case_sensitive)
    binding.flags |= S_FoldCase;
  /* For incremental searches, we always wish to skip past the string. */
  if (isearch_is_active)
    binding.flags |= S_SkipDest;
  
  if (match_nodename)
    {
      /* Match_nodename is set when we have changed the node and are
	 about to start searching in the just loaded one.  First of all
	 we need to see if the node name matches the search string.  It
	 cannot be matched otherwise, because normally, the entire node
	 header line is excluded from searches.

	 If this initial match fails, we continue as usual. */

      int start_off = string_in_line (INFO_NODE_LABEL, node->contents);
      if (start_off != -1)
	{
	  start_off += skip_whitespace (node->contents + start_off);
	  binding.buffer = node->nodename;
	  binding.start = 0;
	  binding.end = strlen (node->nodename);
	  
	  result = (match_regexp ? 
		    regexp_search (string, &binding, poff, resbnd):
		    search (string, &binding, poff));
	  if (result == search_success)
	    *poff += start_off;
	}
    }

  if (result != search_success)
    {
      binding.buffer = node->contents;
      binding.start = start;
      binding.end = node->nodelen;
      
      if (dir < 0)
	{
	  binding.end = node->body_start;
	  binding.flags |= S_SkipDest;
	}
      
      if (binding.start < 0)
	return -1;
      else if (binding.start < node->body_start)
	binding.start = node->body_start;
      
      result = (match_regexp ? 
		regexp_search (string, &binding, poff, resbnd):
		search (string, &binding, poff));
    }
  
  if (result == search_success && window)
    {
      set_remembered_pagetop_and_point (window);
      if (window->node != node)
        window_set_node_of_window (window, node);
      window->point = *poff;
      window_adjust_pagetop (window);
    }
  return result;
}

long
info_search_in_node (char *string, NODE *node, long int start,
		     WINDOW *window, int dir, int case_sensitive,
		     int match_regexp)
{
  long offset;
  if (info_search_in_node_internal (string, node, start,
				    window, dir, case_sensitive, 0,
				    match_regexp,
				    &offset, NULL) == search_success)
    return offset;
  return -1;
}

/* Search NODE, looking for the largest possible match of STRING.  Start the
   search at START.  Return the absolute position of the match, or -1, if
   no part of the string could be found. */
long
info_target_search_node (NODE *node, char *string, long int start,
			 int use_regex_mask)
{
  register int i;
  long offset = 0;
  char *target;

  target = xstrdup (string);
  i = strlen (target);

  /* Try repeatedly searching for this string while removing words from
     the end of it. */
  while (i)
    {
      target[i] = '\0';
      offset = info_search_in_node (target, node, start, NULL, 1, 0,
				    use_regex & use_regex_mask);

      if (offset != -1)
        break;

      /* Delete the last word from TARGET. */
      for (; i && (!whitespace (target[i]) && (target[i] != ',')); i--);
    }
  free (target);
  return offset;
}

/* Search for STRING starting in WINDOW.  The starting position is determined
   by DIR and RESBND argument.  If the latter is given, and its START field
   is not -1, it gives starting position.  Otherwise, the search begins at
   window point + DIR.

   If the string is found in this node, set point to that position.
   Otherwise, get the file buffer associated with WINDOW's node, and search
   through each node in that file.

   If the search succeeds and RESBND is given, its START and END fields
   contain bounds of the found string instance (only for regexp searches).
   
   If the search fails, return non-zero, else zero.  Side-effect window
   leaving the node and point where the string was found current. */
static int
info_search_internal (char *string, WINDOW *window,
		      int dir, int case_sensitive,
		      SEARCH_BINDING *resbnd)
{
  register int i;
  FILE_BUFFER *file_buffer;
  char *initial_nodename;
  long ret, start;
  enum search_result result;
  
  file_buffer = file_buffer_of_window (window);
  initial_nodename = window->node->nodename;

  if (resbnd && resbnd->start != -1)
    start = resbnd->start;
  else
    /* This used to begin from window->point, unless this was a repeated
       search command.  But invoking search with an argument loses with
       that logic, since info_last_executed_command is then set to
       info_add_digit_to_numeric_arg.  I think there's no sense in
       ``finding'' a string that is already under the cursor, anyway.  */
    start = window->point + dir;
  
  result = info_search_in_node_internal
             (string, window->node, start, window, dir,
	      case_sensitive, 0, use_regex, &ret, resbnd);

  switch (result)
    {
    case search_success:
      /* We won! */
      if (!echo_area_is_active && !isearch_is_active)
        window_clear_echo_area ();
      return 0;

    case search_not_found:
      break;
      
    case search_failure:
      return -1;
    }
  
  start = 0;
  
  /* The string wasn't found in the current node.  Search through the
     window's file buffer, iff the current node is not "*". */
  if (!file_buffer || (strcmp (initial_nodename, "*") == 0))
    return -1;

  /* If this file has tags, search through every subfile, starting at
     this node's subfile and node.  Otherwise, search through the
     file's node list. */
  if (file_buffer->tags)
    {
      register int current_tag = 0, number_of_tags;
      char *last_subfile;
      NODE *tag;
      char *msg = NULL;

      /* Find number of tags and current tag. */
      last_subfile = NULL;
      for (i = 0; file_buffer->tags[i]; i++)
        if (strcmp (initial_nodename, file_buffer->tags[i]->nodename) == 0)
          {
            current_tag = i;
            last_subfile = file_buffer->tags[i]->filename;
          }

      number_of_tags = i;

      /* If there is no last_subfile, our tag wasn't found. */
      if (!last_subfile)
        return -1;

      /* Search through subsequent nodes, wrapping around to the top
         of the info file until we find the string or return to this
         window's node and point. */
      while (1)
        {
          NODE *node;
	  
          /* Allow C-g to quit the search, failing it if pressed. */
          return_if_control_g (-1);

          /* Find the next tag that isn't an anchor.  */
          for (i = current_tag + dir; i != current_tag; i += dir)
            {
              if (i < 0)
		{
		  msg = N_("Search continued from the end of the document.");
		  i = number_of_tags - 1;
		}
              else if (i == number_of_tags)
		{
		  msg = N_("Search continued from the beginning of the document.");
		  i = 0;
		}
	      
              tag = file_buffer->tags[i];
              if (tag->nodelen != 0)
                break;
            }

          /* If we got past out starting point, bail out.  */
          if (i == current_tag)
            return -1;
          current_tag = i;

          if (!echo_area_is_active && (last_subfile != tag->filename))
            {
              window_message_in_echo_area
                (_("Searching subfile %s ..."),
                 filename_non_directory (tag->filename));

              last_subfile = tag->filename;
            }

          node = info_get_node (file_buffer->filename, tag->nodename,
                                PARSE_NODE_VERBATIM);

          if (!node)
            {
              /* If not doing i-search... */
              if (!echo_area_is_active)
                {
                  if (info_recent_file_error)
                    info_error ("%s", info_recent_file_error);
                  else
                    info_error (msg_cant_file_node,
                                filename_non_directory (file_buffer->filename),
                                tag->nodename);
                }
              return -1;
            }

          if (dir < 0)
            start = tag->nodelen;

          result =
            info_search_in_node_internal (string, node, start, window, dir,
					  case_sensitive, 1, use_regex,
					  &ret, resbnd);

          /* Did we find the string in this node? */
          if (result == search_success)
            {
              /* Yes!  We win. */
              remember_window_and_node (window, node);
              if (!echo_area_is_active)
		{
		  if (msg)
		    window_message_in_echo_area ("%s", _(msg));
		  else
		    window_clear_echo_area ();
		}
              return 0;
            }

          /* No.  Free this node, and make sure that we haven't passed
             our starting point. */
          free (node);

          if (result == search_failure
	      || strcmp (initial_nodename, tag->nodename) == 0)
            return -1;
        }
    }
  return -1;
}

DECLARE_INFO_COMMAND (info_search_case_sensitively,
                      _("Read a string and search for it case-sensitively"))
{
  last_search_direction = count > 0 ? 1 : -1;
  last_search_case_sensitive = 1;
  info_search_1 (window, count, key, 1, 1, DFL_START);
}

DECLARE_INFO_COMMAND (info_search, _("Read a string and search for it"))
{
  last_search_direction = count > 0 ? 1 : -1;
  last_search_case_sensitive = 0;
  info_search_1 (window, count, key, 0, 1, DFL_START);
}

DECLARE_INFO_COMMAND (info_search_backward,
                      _("Read a string and search backward for it"))
{
  last_search_direction = count > 0 ? -1 : 1;
  last_search_case_sensitive = 0;
  info_search_1 (window, -count, key, 0, 1, DFL_START);
}

/* Common entry point for the search functions.  Arguments:
   WINDOW           The window to search in
   COUNT            The sign of this argument defines the search
                    direction (negative for searching backwards);
		    its absolute value gives number of repetitions.
   CASE_SENSITIVE   Whether the search is case-sensitive or not.
   ASK_FOR_STRING   When true, ask for the search string.  Otherwise
                    use the previously supplied one (repeated search).
   START            Start position for the search.  If DFL_START, use
                    the default start position (see info_search_internal
		    for details.
*/
static void
info_search_1 (WINDOW *window, int count, unsigned char key,
	       int case_sensitive, int ask_for_string, long start)
{
  char *line, *prompt;
  int result, old_pagetop;
  int direction;
  SEARCH_BINDING bind, *bindp;

  if (start == DFL_START)
    bindp = NULL;
  else
    {
      bind.start = start;
      bindp = &bind;
    }
  
  if (count < 0)
    {
      direction = -1;
      count = -count;
    }
  else
    {
      direction = 1;
      if (count == 0)
        count = 1;      /* for backward compatibility */
    }

  /* Read a string from the user, defaulting the search to SEARCH_STRING. */
  if (!search_string)
    {
      search_string = xmalloc (search_string_size = 100);
      search_string[0] = '\0';
    }

  if (ask_for_string)
    {
      prompt = xmalloc (strlen (_("%s%s%s [%s]: "))
			+ strlen (_("Regexp search"))
			+ strlen (_(" case-sensitively"))
			+ strlen (_(" backward"))
			+ strlen (search_string));

      sprintf (prompt, _("%s%s%s [%s]: "),
               use_regex ? _("Regexp search") : _("Search"),
               case_sensitive ? _(" case-sensitively") : "",
               direction < 0 ? _(" backward") : "",
               search_string);

      line = info_read_in_echo_area (window, prompt);
      free (prompt);

      if (!line)
        {
          info_abort_key (window, 0, 0);
          return;
        }

      if (*line)
        {
          if (strlen (line) + 1 > (unsigned int) search_string_size)
            search_string =
	      xrealloc (search_string,
			(search_string_size += 50 + strlen (line)));

          strcpy (search_string, line);
          free (line);
        }
    }

  if (mbslen (search_string) < min_search_length)
    {
      info_error ("%s", _("Search string too short"));
      return;
    }

  /* If the search string includes upper-case letters, make the search
     case-sensitive.  */
  if (case_sensitive == 0)
    for (line = search_string; *line; line++)
      if (isupper (*line))
        {
          case_sensitive = 1;
          break;
        }

  old_pagetop = active_window->pagetop;
  for (result = 0; result == 0 && count--; )
    result = info_search_internal (search_string,
                                   active_window, direction, case_sensitive,
				   bindp);

  if (result != 0 && !info_error_was_printed)
    info_error ("%s", _("Search failed."));
  else if (old_pagetop != active_window->pagetop)
    {
      int new_pagetop;

      new_pagetop = active_window->pagetop;
      active_window->pagetop = old_pagetop;
      set_window_pagetop (active_window, new_pagetop);
      if (auto_footnotes_p)
        info_get_or_remove_footnotes (active_window);
    }

  /* Perhaps free the unreferenced file buffers that were searched, but
     not retained. */
  info_gc_file_buffers ();
}

DECLARE_INFO_COMMAND (info_search_next,
                      _("Repeat last search in the same direction"))
{
  if (!last_search_direction)
    info_error ("%s", _("No previous search string"));
  else if (search_skip_screen_p)
    {
      /* Find window bottom */
      long n = window->height + window->pagetop;
      if (n < window->line_count)
	n = window->line_starts[n] - window->node->contents;
      else
	n = window->node->nodelen;
      info_search_1 (window, last_search_direction * count,
		     key, last_search_case_sensitive, 0, n);
    }
  else
    info_search_1 (window, last_search_direction * count,
                   key, last_search_case_sensitive, 0, DFL_START);
}

DECLARE_INFO_COMMAND (info_search_previous,
                      _("Repeat last search in the reverse direction"))
{
  if (!last_search_direction)
    info_error ("%s", _("No previous search string"));
  else if (search_skip_screen_p)
    {
      /* Find window bottom */
      long n;

      n = window->line_starts[window->pagetop] - window->node->contents - 1;
      if (n < 0)
	n = 0;
      info_search_1 (window, -last_search_direction * count,
		     key, last_search_case_sensitive, 0, n);
    }
  else
    info_search_1 (window, -last_search_direction * count,
                   key, last_search_case_sensitive, 0, DFL_START);
}

/* **************************************************************** */
/*                                                                  */
/*                      Incremental Searching                       */
/*                                                                  */
/* **************************************************************** */

static void incremental_search (WINDOW *window, int count,
    unsigned char ignore);

DECLARE_INFO_COMMAND (isearch_forward,
                      _("Search interactively for a string as you type it"))
{
  incremental_search (window, count, key);
}

DECLARE_INFO_COMMAND (isearch_backward,
                      _("Search interactively for a string as you type it"))
{
  incremental_search (window, -count, key);
}

/* Incrementally search for a string as it is typed. */
/* The last accepted incremental search string. */
static char *last_isearch_accepted = NULL;

/* The current incremental search string. */
static char *isearch_string = NULL;
static int isearch_string_index = 0;
static int isearch_string_size = 0;
static unsigned char isearch_terminate_search_key = ESC;

/* Array of search states. */
static SEARCH_STATE **isearch_states = NULL;
static size_t isearch_states_index = 0;
static size_t isearch_states_slots = 0;

/* Push the state of this search. */
static void
push_isearch (WINDOW *window, int search_index, int direction, int failing)
{
  SEARCH_STATE *state;

  state = xmalloc (sizeof (SEARCH_STATE));
  window_get_state (window, state);
  state->search_index = search_index;
  state->direction = direction;
  state->failing = failing;

  add_pointer_to_array (state, isearch_states_index, isearch_states,
                        isearch_states_slots, 20);
}

/* Pop the state of this search to WINDOW, SEARCH_INDEX, and DIRECTION. */
static void
pop_isearch (WINDOW *window, int *search_index, int *direction, int *failing)
{
  SEARCH_STATE *state;

  if (isearch_states_index)
    {
      isearch_states_index--;
      state = isearch_states[isearch_states_index];
      window_set_state (window, state);
      *search_index = state->search_index;
      *direction = state->direction;
      *failing = state->failing;

      free (state);
      isearch_states[isearch_states_index] = NULL;
    }
}

/* Free the memory used by isearch_states. */
static void
free_isearch_states (void)
{
  register int i;

  for (i = 0; i < isearch_states_index; i++)
    {
      free (isearch_states[i]);
      isearch_states[i] = NULL;
    }
  isearch_states_index = 0;
}

/* Display the current search in the echo area. */
static void
show_isearch_prompt (int dir, unsigned char *string, int failing_p)
{
  register int i;
  const char *prefix;
  char *prompt, *p_rep;
  unsigned int prompt_len, p_rep_index, p_rep_size;

  if (dir < 0)
    prefix = use_regex ? _("Regexp I-search backward: ")
                       : _("I-search backward: ");
  else
    prefix = use_regex ? _("Regexp I-search: ")
                       : _("I-search: ");

  p_rep_index = p_rep_size = 0;
  p_rep = NULL;
  for (i = 0; string[i]; i++)
    {
      char *rep;

      switch (string[i])
        {
        case ' ': rep = " "; break;
        case LFD: rep = "\\n"; break;
        case TAB: rep = "\\t"; break;
        default:
          rep = pretty_keyname (string[i]);
        }
      if ((p_rep_index + strlen (rep) + 1) >= p_rep_size)
        p_rep = xrealloc (p_rep, p_rep_size += 100);

      strcpy (p_rep + p_rep_index, rep);
      p_rep_index += strlen (rep);
    }

  prompt_len = strlen (prefix) + p_rep_index + 1;
  if (failing_p)
    prompt_len += strlen (_("Failing "));
  prompt = xmalloc (prompt_len);
  sprintf (prompt, "%s%s%s", failing_p ? _("Failing ") : "", prefix,
           p_rep ? p_rep : "");

  window_message_in_echo_area ("%s", prompt);
  free (p_rep);
  free (prompt);
  display_cursor_at_point (active_window);
}

static void
incremental_search (WINDOW *window, int count, unsigned char ignore)
{
  unsigned char key;
  int last_search_result, search_result, dir;
  SEARCH_STATE mystate, orig_state;
  char *p;
  int case_sensitive = 0;
  SEARCH_BINDING bnd;

  bnd.start = -1;

  if (count < 0)
    dir = -1;
  else
    dir = 1;

  last_search_result = search_result = 0;

  window_get_state (window, &orig_state);

  isearch_string_index = 0;
  if (!isearch_string_size)
    isearch_string = xmalloc (isearch_string_size = 50);

  /* Show the search string in the echo area. */
  isearch_string[isearch_string_index] = '\0';
  show_isearch_prompt (dir, (unsigned char *) isearch_string, search_result);

  isearch_is_active = 1;

  while (isearch_is_active)
    {
      VFunction *func = NULL;
      int quoted = 0;

      /* If a recent display was interrupted, then do the redisplay now if
         it is convenient. */
      if (!info_any_buffered_input_p () && display_was_interrupted_p)
        {
          display_update_one_window (window);
          display_cursor_at_point (active_window);
        }

      /* Read a character and dispatch on it. */
      key = info_get_input_char ();
      window_get_state (window, &mystate);

      if (key == DEL || key == Control ('h'))
        {
          /* User wants to delete one level of search? */
          if (!isearch_states_index)
            {
              terminal_ring_bell ();
              continue;
            }
          else
            {
              pop_isearch
                (window, &isearch_string_index, &dir, &search_result);
              isearch_string[isearch_string_index] = '\0';
              show_isearch_prompt (dir, (unsigned char *) isearch_string,
                  search_result);
              goto after_search;
            }
        }
      else if (key == Control ('q'))
        {
          key = info_get_input_char ();
          quoted = 1;
        }

      /* We are about to search again, or quit.  Save the current search. */
      push_isearch (window, isearch_string_index, dir, search_result);

      if (quoted)
        goto insert_and_search;

      if (!Meta_p (key) || key > 32)
        {
          /* If this key is not a keymap, get its associated function,
             if any.  If it is a keymap, then it's probably ESC from an
             arrow key, and we handle that case below.  */
          char type = window->keymap[key].type;
          func = type == ISFUNC
                 ? InfoFunction(window->keymap[key].function)
                 : NULL;  /* function member is a Keymap if ISKMAP */

          if (isprint (key) || (type == ISFUNC && func == NULL))
            {
            insert_and_search:

              if (isearch_string_index + 2 >= isearch_string_size)
                isearch_string = xrealloc
                  (isearch_string, isearch_string_size += 100);

              isearch_string[isearch_string_index++] = key;
              isearch_string[isearch_string_index] = '\0';
              goto search_now;
            }
          else if (func == (VFunction *) isearch_forward
              || func == (VFunction *) isearch_backward)
            {
              /* If this key invokes an incremental search, then this
                 means that we will either search again in the same
                 direction, search again in the reverse direction, or
                 insert the last search string that was accepted through
                 incremental searching. */
              if ((func == (VFunction *) isearch_forward && dir > 0) ||
                  (func == (VFunction *) isearch_backward && dir < 0))
                {
                  /* If the user has typed no characters, then insert the
                     last successful search into the current search string. */
                  if (isearch_string_index == 0)
                    {
                      /* Of course, there must be something to insert. */
                      if (last_isearch_accepted)
                        {
                          if (strlen ((char *) last_isearch_accepted) + 1
                              >= (unsigned int) isearch_string_size)
                            isearch_string = (char *)
                              xrealloc (isearch_string,
                                        isearch_string_size += 10 +
                                        strlen (last_isearch_accepted));
                          strcpy (isearch_string, last_isearch_accepted);
                          isearch_string_index = strlen (isearch_string);
                          goto search_now;
                        }
                      else
                        continue;
                    }
                  else
                    {
                      /* Search again in the same direction.  This means start
                         from a new place if the last search was successful. */
                      if (search_result == 0)
			{
			  window->point += dir;
			  bnd.start = -1;
			}
                    }
                }
              else
                {
                  /* Reverse the direction of the search. */
                  dir = -dir;
                }
            }
          else if (func == (VFunction *) info_abort_key)
            {
              /* If C-g pressed, and the search is failing, pop the search
                 stack back to the last unfailed search. */
              if (isearch_states_index && (search_result != 0))
                {
                  terminal_ring_bell ();
                  while (isearch_states_index && (search_result != 0))
                    pop_isearch
                      (window, &isearch_string_index, &dir, &search_result);
                  isearch_string[isearch_string_index] = '\0';
                  show_isearch_prompt (dir, (unsigned char *) isearch_string,
                      search_result);
                  continue;
                }
              else
                goto exit_search;
            }
          else
            goto exit_search;
        }
      else
        {
        exit_search:
          /* The character is not printable, or it has a function which is
             non-null.  Exit the search, remembering the search string.  If
             the key is not the same as the isearch_terminate_search_key,
             then push it into pending input. */
          if (isearch_string_index && func != (VFunction *) info_abort_key)
            {
              free (last_isearch_accepted);
              last_isearch_accepted = xstrdup (isearch_string);
            }

          /* If the key is the isearch_terminate_search_key, but some buffered
             input is pending, it is almost invariably because the ESC key is
             actually the beginning of an escape sequence, like in case they
             pressed an arrow key.  So don't gobble the ESC key, push it back
             into pending input.  */
          /* FIXME: this seems like a kludge!  We need a more reliable
             mechanism to know when ESC is a separate key and when it is
             part of an escape sequence.  */
          if (key != RET  /* Emacs addicts want RET to get lost */
              && (key != isearch_terminate_search_key
                  || info_any_buffered_input_p ()))
            info_set_pending_input (key);

          if (func == (VFunction *) info_abort_key)
            {
              if (isearch_states_index)
                window_set_state (window, &orig_state);
            }

          if (!echo_area_is_active)
            window_clear_echo_area ();

          if (auto_footnotes_p)
            info_get_or_remove_footnotes (active_window);

          isearch_is_active = 0;
          continue;
        }

      /* Search for the contents of isearch_string. */
    search_now:
      show_isearch_prompt (dir, (unsigned char *) isearch_string, search_result);

      /* If the search string includes upper-case letters, make the
         search case-sensitive.  */
      for (p = isearch_string; *p; p++)
        if (isupper (*p))
          {
            case_sensitive = 1;
            break;
          }
      
      /* Regex isearch means we better search again every time.  We
         might have had a failed search for "\", for example, but now we
         have "\.".  */
      if (use_regex)
        {
          search_result = info_search_internal (isearch_string,
                                                window, dir, case_sensitive,
						&bnd);
        }
      else if (search_result == 0)
        { /* We test for search_result being zero because a non-zero
	     value means the string was not found in entire document. */
          /* Check to see if the current search string is right here.  If
             we are looking at it, then don't bother calling the search
             function. */
          if (((dir < 0) &&
               ((case_sensitive ? strncmp : mbsncasecmp)
                            (window->node->contents + window->point,
                             isearch_string, isearch_string_index) == 0)) ||
              ((dir > 0) &&
               ((window->point - isearch_string_index) >= 0) &&
               ((case_sensitive ? strncmp : mbsncasecmp)
                            (window->node->contents +
                             (window->point - (isearch_string_index - 1)),
                             isearch_string, isearch_string_index) == 0)))
            {
              if (dir > 0)
                window->point++;
            }
          else
            search_result = info_search_internal (isearch_string,
                                                  window, dir, case_sensitive,
						  NULL);
        }

      /* If this search failed, and we didn't already have a failed search,
         then ring the terminal bell. */
      if (search_result != 0 && last_search_result == 0)
        terminal_ring_bell ();

    after_search:
      show_isearch_prompt (dir, (unsigned char *) isearch_string, search_result);

      if (search_result == 0)
        {
          if ((mystate.node == window->node) &&
              (mystate.pagetop != window->pagetop))
            {
              int newtop = window->pagetop;
              window->pagetop = mystate.pagetop;
              set_window_pagetop (window, newtop);
            }
          display_update_one_window (window);
          display_cursor_at_point (window);
        }

      last_search_result = search_result;
    }

  /* Free the memory used to remember each search state. */
  free_isearch_states ();

  /* Perhaps GC some file buffers. */
  info_gc_file_buffers ();

  /* After searching, leave the window in the correct state. */
  if (!echo_area_is_active)
    window_clear_echo_area ();
}

/* Find tag table entries for nodes which have been rewritten, and free
   their contents. */
static void
free_node_contents (FILE_BUFFER *fb)
{
  NODE **entry;

  if (!fb->tags)
    return;

  for (entry = fb->tags; *entry; entry++)
    if ((*entry)->flags & N_WasRewritten)
      {
        free ((*entry)->contents);
        (*entry)->contents = 0;
        (*entry)->flags &= ~N_WasRewritten;
      }
}


/* GC some file buffers.  A file buffer can be gc-ed if there we have
   no nodes in INFO_WINDOWS that reference this file buffer's contents.
   Garbage collecting a file buffer means to free the file buffers
   contents. */
static void
info_gc_file_buffers (void)
{
  register int fb_index, iw_index, i;
  register FILE_BUFFER *fb;
  register INFO_WINDOW *iw;

  if (!info_loaded_files)
    return;

  for (fb_index = 0; (fb = info_loaded_files[fb_index]); fb_index++)
    {
      int fb_referenced_p = 0, parent_referenced_p = 0;

      /* If already gc-ed, do nothing. */
      if (!fb->contents)
        continue;

      /* If this file had to be uncompressed, check to see if we should
         gc it.  This means that the user-variable "gc-compressed-files"
         is non-zero. */
      if ((fb->flags & N_IsCompressed) && !gc_compressed_files)
        continue;

      /* If this file's contents are not gc-able, move on. */
      if (fb->flags & N_CannotGC)
        continue;

      /* Check each INFO_WINDOW to see if it has any nodes which reference
         this file. */
      for (iw_index = 0; (iw = info_windows[iw_index]); iw_index++)
        {
          for (i = 0; iw->nodes && iw->nodes[i]; i++)
            {
              if (iw->nodes[i]->filename &&
		  ((FILENAME_CMP (fb->fullpath, iw->nodes[i]->filename) == 0) ||
		   (FILENAME_CMP (fb->filename, iw->nodes[i]->filename) == 0)))
                {
                  fb_referenced_p = 1;
                  break;
                }

              /* If any subfile of a split file is referenced, none of
                 the rewritten nodes in the split file is freed. */
              if (iw->nodes[i]->parent &&
		  ((FILENAME_CMP (fb->fullpath, iw->nodes[i]->parent) == 0) ||
		   (FILENAME_CMP (fb->filename, iw->nodes[i]->parent) == 0)))
                {
                  parent_referenced_p = 1;
                  break;
                }
            }
        }

      /* If this file buffer wasn't referenced, free its contents. */
      if (!fb_referenced_p)
        {
          if (!parent_referenced_p)
            free_node_contents (fb);
          free (fb->contents);
          fb->contents = NULL;
        }
    }
}

/* **************************************************************** */
/*                                                                  */
/*                  Miscellaneous Info Commands                     */
/*                                                                  */
/* **************************************************************** */

/* What to do when C-g is pressed in a window. */
DECLARE_INFO_COMMAND (info_abort_key, _("Cancel current operation"))
{
  /* If error printing doesn't oridinarily ring the bell, do it now,
     since C-g always rings the bell.  Otherwise, let the error printer
     do it. */
  if (!info_error_rings_bell_p)
    terminal_ring_bell ();
  info_error ("%s", _("Quit"));

  info_initialize_numeric_arg ();
  info_clear_pending_input ();
  info_last_executed_command = NULL;
}

/* Move the cursor to the desired line of the window. */
DECLARE_INFO_COMMAND (info_move_to_window_line,
   _("Move the cursor to a specific line of the window"))
{
  int line;

  /* With no numeric argument of any kind, default to the center line. */
  if (!info_explicit_arg && count == 1)
    line = (window->height / 2) + window->pagetop;
  else
    {
      if (count < 0)
        line = (window->height + count) + window->pagetop;
      else
        line = window->pagetop + count;
    }

  /* If the line doesn't appear in this window, make it do so. */
  if ((line - window->pagetop) >= window->height)
    line = window->pagetop + (window->height - 1);

  /* If the line is too small, make it fit. */
  if (line < window->pagetop)
    line = window->pagetop;

  /* If the selected line is past the bottom of the node, force it back. */
  if (line >= window->line_count)
    line = window->line_count - 1;

  window->point = (window->line_starts[line] - window->node->contents);
}

/* Clear the screen and redraw its contents.  Given a numeric argument,
   move the line the cursor is on to the COUNT'th line of the window. */
DECLARE_INFO_COMMAND (info_redraw_display, _("Redraw the display"))
{
  if ((!info_explicit_arg && count == 1) || echo_area_is_active)
    {
      terminal_clear_screen ();
      display_clear_display (the_display);
      window_mark_chain (windows, W_UpdateWindow);
      display_update_display (windows);
    }
  else
    {
      int desired_line, point_line;
      int new_pagetop;

      point_line = window_line_of_point (window) - window->pagetop;

      if (count < 0)
        desired_line = window->height + count;
      else
        desired_line = count;

      if (desired_line < 0)
        desired_line = 0;

      if (desired_line >= window->height)
        desired_line = window->height - 1;

      if (desired_line == point_line)
        return;

      new_pagetop = window->pagetop + (point_line - desired_line);

      set_window_pagetop (window, new_pagetop);
    }
}

/* Exit from info */
DECLARE_INFO_COMMAND (info_quit, _("Quit using Info"))
{
  quit_info_immediately = 1;
}


/* **************************************************************** */
/*                                                                  */
/*               Reading Keys and Dispatching on Them               */
/*                                                                  */
/* **************************************************************** */

/* Declaration only.  Special cased in info_dispatch_on_key ().
   Doc string is to avoid ugly results with describe_key etc.  */
DECLARE_INFO_COMMAND (info_do_lowercase_version,
                      _("Run command bound to this key's lowercase variant"))
{}

static void
dispatch_error (char *keyseq)
{
  char *rep;

  rep = pretty_keyseq (keyseq);

  if (!echo_area_is_active)
    info_error (_("Unknown command (%s)."), rep);
  else
    {
      char *temp = xmalloc (1 + strlen (rep) + strlen (_("\"%s\" is invalid")));
      sprintf (temp, _("`%s' is invalid"), rep);
      terminal_ring_bell ();
      inform_in_echo_area (temp);
      free (temp);
    }
}

/* Keeping track of key sequences. */
static char *info_keyseq = NULL;
static int info_keyseq_index = 0;
static int info_keyseq_size = 0;
static int info_keyseq_displayed_p = 0;

/* Initialize the length of the current key sequence. */
void
initialize_keyseq (void)
{
  info_keyseq_index = 0;
  info_keyseq_displayed_p = 0;
}

/* Add CHARACTER to the current key sequence. */
void
add_char_to_keyseq (char character)
{
  if (info_keyseq_index + 2 >= info_keyseq_size)
    info_keyseq = (char *)xrealloc (info_keyseq, info_keyseq_size += 10);

  info_keyseq[info_keyseq_index++] = character;
  info_keyseq[info_keyseq_index] = '\0';
}

/* Display the current value of info_keyseq.  If argument EXPECTING is
   non-zero, input is expected to be read after the key sequence is
   displayed, so add an additional prompting character to the sequence. */
static void
display_info_keyseq (int expecting_future_input)
{
  char *rep;

  rep = pretty_keyseq (info_keyseq);
  if (expecting_future_input)
    strcat (rep, "-");

  if (echo_area_is_active)
    inform_in_echo_area (rep);
  else
    {
      window_message_in_echo_area (rep, NULL, NULL);
      display_cursor_at_point (active_window);
    }
  info_keyseq_displayed_p = 1;
}

/* Called by interactive commands to read a keystroke. */
unsigned char
info_get_another_input_char (void)
{
  int ready = !info_keyseq_displayed_p; /* ready if new and pending key */

  /* If there isn't any input currently available, then wait a
     moment looking for input.  If we don't get it fast enough,
     prompt a little bit with the current key sequence. */
  if (!info_keyseq_displayed_p)
    {
      ready = 1;
      if (!info_any_buffered_input_p () &&
          !info_input_pending_p ())
        {
#if defined (FD_SET)
          struct timeval timer;
          fd_set readfds;

          FD_ZERO (&readfds);
          FD_SET (fileno (info_input_stream), &readfds);
          timer.tv_sec = 1;
          timer.tv_usec = 750;
          ready = select (fileno(info_input_stream)+1, &readfds,
			  NULL, NULL, &timer);
#else
          ready = 0;
#endif /* FD_SET */
      }
    }

  if (!ready)
    display_info_keyseq (1);

  return info_get_input_char ();
}

/* Do the command associated with KEY in MAP.  If the associated command is
   really a keymap, then read another key, and dispatch into that map. */
void
info_dispatch_on_key (unsigned char key, Keymap map)
{
#if !defined(INFOKEY)
  if (Meta_p (key) && (!ISO_Latin_p || map[key].function != ea_insert))
    {
      if (map[ESC].type == ISKMAP)
        {
          map = (Keymap)map[ESC].function;
          add_char_to_keyseq (ESC);
          key = UnMeta (key);
          info_dispatch_on_key (key, map);
        }
      else
        {
          dispatch_error (info_keyseq);
        }
      return;
    }
#endif /* INFOKEY */

  switch (map[key].type)
    {
    case ISFUNC:
      {
        VFunction *func;

        func = InfoFunction(map[key].function);
        if (func != NULL)
          {
            /* Special case info_do_lowercase_version (). */
            if (func == (VFunction *) info_do_lowercase_version)
              {
#if defined(INFOKEY)
                unsigned char lowerkey;

                lowerkey = Meta_p(key) ? Meta (tolower (UnMeta (key))) : tolower (key);
                if (lowerkey == key)
                  {
                    add_char_to_keyseq (key);
                    dispatch_error (info_keyseq);
                    return;
                  }
                info_dispatch_on_key (lowerkey, map);
#else /* !INFOKEY */
                info_dispatch_on_key (tolower (key), map);
#endif /* INFOKEY */
                return;
              }

            add_char_to_keyseq (key);

            if (info_keyseq_displayed_p)
              display_info_keyseq (0);

            {
              WINDOW *where;

              where = active_window;

              if (!echo_area_is_active)
                (*InfoFunction(map[key].function))
                  (active_window, info_numeric_arg * info_numeric_arg_sign,
                  key);
              else
                (*InfoFunction(map[key].function))
                  (active_window, ea_numeric_arg * ea_numeric_arg_sign,
                  key);

              /* If we have input pending, then the last command was a prefix
                 command.  Don't change the value of the last function vars.
                 Otherwise, remember the last command executed in the var
                 appropriate to the window in which it was executed. */
              if (!info_input_pending_p ())
                {
                  if (where == the_echo_area)
                    ea_last_executed_command = InfoFunction(map[key].function);
                  else
                    info_last_executed_command = InfoFunction(map[key].function);
                }
            }
          }
        else
          {
            add_char_to_keyseq (key);
            dispatch_error (info_keyseq);
            return;
          }
      }
      break;

    case ISKMAP:
      add_char_to_keyseq (key);
      if (map[key].function != NULL)
        {
          unsigned char newkey;

          newkey = info_get_another_input_char ();
          info_dispatch_on_key (newkey, (Keymap)map[key].function);
        }
      else
        {
          dispatch_error (info_keyseq);
          return;
        }
      break;
    }
}

/* **************************************************************** */
/*                                                                  */
/*                      Numeric Arguments                           */
/*                                                                  */
/* **************************************************************** */

/* Handle C-u style numeric args, as well as M--, and M-digits. */

/* Non-zero means that an explicit argument has been passed to this
   command, as in C-u C-v. */
int info_explicit_arg = 0;

/* The sign of the numeric argument. */
int info_numeric_arg_sign = 1;

/* The value of the argument itself. */
int info_numeric_arg = 1;

/* As above, but used when C-u is typed in the echo area to avoid
   overwriting this information when "C-u ARG M-x" is typed. */
int ea_explicit_arg = 0;
int ea_numeric_arg_sign = 1;
int ea_numeric_arg = 1;

/* Add the current digit to the argument in progress. */
DECLARE_INFO_COMMAND (info_add_digit_to_numeric_arg,
                      _("Add this digit to the current numeric argument"))
{
  info_numeric_arg_digit_loop (window, 0, key);
}

/* C-u, universal argument.  Multiply the current argument by 4.
   Read a key.  If the key has nothing to do with arguments, then
   dispatch on it.  If the key is the abort character then abort. */
DECLARE_INFO_COMMAND (info_universal_argument,
                      _("Start (or multiply by 4) the current numeric argument"))
{
  if (!echo_area_is_active)
    info_numeric_arg *= 4;
  else
    ea_numeric_arg *= 4;

  info_numeric_arg_digit_loop (window, 0, 0);
}

/* Create a default argument. */
void
info_initialize_numeric_arg (void)
{
  if (!echo_area_is_active)
    {
      info_numeric_arg = info_numeric_arg_sign = 1;
      info_explicit_arg = 0;
    }
  else
    {
      ea_numeric_arg = ea_numeric_arg_sign = 1;
      ea_explicit_arg = 0;
    }
}

DECLARE_INFO_COMMAND (info_numeric_arg_digit_loop,
                      _("Internally used by \\[universal-argument]"))
{
  unsigned char pure_key;
  Keymap keymap = window->keymap;

  int *which_numeric_arg, *which_numeric_arg_sign, *which_explicit_arg;

  /* Process the right numeric argument.  FIXME: Not necessarily the
     nicest way of doing it. */
  if (!echo_area_is_active)
    {
      which_explicit_arg =     &info_explicit_arg;
      which_numeric_arg_sign = &info_numeric_arg_sign;
      which_numeric_arg =      &info_numeric_arg;
    }
  else
    {
      which_explicit_arg =     &ea_explicit_arg;
      which_numeric_arg_sign = &ea_numeric_arg_sign;
      which_numeric_arg =      &ea_numeric_arg;
    }

  while (1)
    {
      if (key)
        pure_key = key;
      else
        {
          if (display_was_interrupted_p && !info_any_buffered_input_p ())
            display_update_display (windows);

          if (active_window != the_echo_area)
            display_cursor_at_point (active_window);

          pure_key = key = info_get_another_input_char ();

#if !defined(INFOKEY)
          if (Meta_p (key))
            add_char_to_keyseq (ESC);

          add_char_to_keyseq (UnMeta (key));
#else /* defined(INFOKEY) */
          add_char_to_keyseq (key);
#endif /* defined(INFOKEY) */
        }

#if !defined(INFOKEY)
      if (Meta_p (key))
        key = UnMeta (key);
#endif /* !defined(INFOKEY) */

      if (keymap[key].type == ISFUNC
          && InfoFunction(keymap[key].function)
              == (VFunction *) info_universal_argument)
        {
          *which_numeric_arg *= 4;
          key = 0;
          continue;
        }

#if defined(INFOKEY)
      if (Meta_p (key))
        key = UnMeta (key);
#endif /* !defined(INFOKEY) */


      if (isdigit (key))
        {
          if (*which_explicit_arg)
            *which_numeric_arg = (*which_numeric_arg * 10) + (key - '0');
          else
            *which_numeric_arg = (key - '0');
          *which_explicit_arg = 1;
        }
      else
        {
          if (key == '-' && !*which_explicit_arg)
            {
              *which_numeric_arg_sign = -1;
              *which_numeric_arg = 1;
            }
          else
            {
              info_keyseq_index--;
              info_dispatch_on_key (pure_key, keymap);
              return;
            }
        }
      key = 0;
    }
}

DECLARE_INFO_COMMAND (info_display_file_info,
		      _("Show full file name of node being displayed"))
{
  const char *fname = info_find_fullpath (window->node->filename);
  if (fname)
    {
      int line = window_line_of_point (window);
      window_message_in_echo_area ("File name: %s, line %d of %lu (%d%%)",
				   fname, line,
				   (unsigned long) window->line_count,
				   line * 100 / window->line_count);
    }
  else
    window_message_in_echo_area ("Internal node");
}

/* **************************************************************** */
/*                                                                  */
/*                      Input Character Buffering                   */
/*                                                                  */
/* **************************************************************** */

/* Character waiting to be read next. */
static int pending_input_character = 0;

/* How to make there be no pending input. */
static void
info_clear_pending_input (void)
{
  pending_input_character = 0;
}

/* How to set the pending input character. */
static void
info_set_pending_input (unsigned char key)
{
  pending_input_character = key;
}

/* How to see if there is any pending input. */
unsigned char
info_input_pending_p (void)
{
  return pending_input_character;
}

/* Largest number of characters that we can read in advance. */
#define MAX_INFO_INPUT_BUFFERING 512

static int pop_index = 0, push_index = 0;
static unsigned char info_input_buffer[MAX_INFO_INPUT_BUFFERING];

/* Add KEY to the buffer of characters to be read. */
static void
info_push_typeahead (unsigned char key)
{
  /* Flush all pending input in the case of C-g pressed. */
  if (key == Control ('g'))
    {
      push_index = pop_index;
      info_set_pending_input (Control ('g'));
    }
  else
    {
      info_input_buffer[push_index++] = key;
      if ((unsigned int) push_index >= sizeof (info_input_buffer))
        push_index = 0;
    }
}

/* Return the amount of space available in INFO_INPUT_BUFFER for new chars. */
static int
info_input_buffer_space_available (void)
{
  if (pop_index > push_index)
    return pop_index - push_index;
  else
    return sizeof (info_input_buffer) - (push_index - pop_index);
}

/* Get a key from the buffer of characters to be read.
   Return the key in KEY.
   Result is non-zero if there was a key, or 0 if there wasn't. */
static int
info_get_key_from_typeahead (unsigned char *key)
{
  if (push_index == pop_index)
    return 0;

  *key = info_input_buffer[pop_index++];

  if ((unsigned int) pop_index >= sizeof (info_input_buffer))
    pop_index = 0;

  return 1;
}

int
info_any_buffered_input_p (void)
{
  info_gather_typeahead ();
  return push_index != pop_index;
}

/* If characters are available to be read, then read them and stuff them into
   info_input_buffer.  Otherwise, do nothing. */
void
info_gather_typeahead (void)
{
  register int i = 0;
  int tty, space_avail;
  long chars_avail;
  unsigned char input[MAX_INFO_INPUT_BUFFERING];

  tty = fileno (info_input_stream);
  chars_avail = 0;

  space_avail = info_input_buffer_space_available ();

  /* If we can just find out how many characters there are to read, do so. */
#if defined (FIONREAD)
  {
    ioctl (tty, FIONREAD, &chars_avail);

    if (chars_avail > space_avail)
      chars_avail = space_avail;

    if (chars_avail)
      chars_avail = read (tty, &input[0], chars_avail);
  }
#else /* !FIONREAD */
#  if defined (O_NDELAY) && defined (F_GETFL) && defined (F_SETFL)
  {
    int flags;

    flags = fcntl (tty, F_GETFL, 0);

    fcntl (tty, F_SETFL, (flags | O_NDELAY));
      chars_avail = read (tty, &input[0], space_avail);
    fcntl (tty, F_SETFL, flags);

    if (chars_avail == -1)
      chars_avail = 0;
  }
#  else  /* !O_NDELAY */
#   ifdef __DJGPP__
  {
    extern long pc_term_chars_avail (void);

    if (isatty (tty))
      chars_avail = pc_term_chars_avail ();
    else
      {
        /* We could be more accurate by calling ltell, but we have no idea
           whether tty is buffered by stdio functions, and if so, how many
           characters are already waiting in the buffer.  So we punt.  */
        struct stat st;

        if (fstat (tty, &st) < 0)
          chars_avail = 1;
        else
          chars_avail = st.st_size;
      }
    if (chars_avail > space_avail)
      chars_avail = space_avail;
    if (chars_avail)
      chars_avail = read (tty, &input[0], chars_avail);
  }
#   else
#    ifdef __MINGW32__
  {
    extern long w32_chars_avail (int);

    chars_avail = w32_chars_avail (tty);

    if (chars_avail > space_avail)
      chars_avail = space_avail;
    if (chars_avail)
      chars_avail = read (tty, &input[0], chars_avail);
  }
#    endif  /* _WIN32 */
#   endif/* __DJGPP__ */
#  endif /* O_NDELAY */
#endif /* !FIONREAD */

  while (i < chars_avail)
    {
      info_push_typeahead (input[i]);
      i++;
    }
}

/* How to read a single character. */
unsigned char
info_get_input_char (void)
{
  unsigned char keystroke;

  info_gather_typeahead ();

  if (pending_input_character)
    {
      keystroke = pending_input_character;
      pending_input_character = 0;
    }
  else if (info_get_key_from_typeahead (&keystroke) == 0)
    {
      int rawkey;
      unsigned char c;
      int tty = fileno (info_input_stream);

      /* Using stream I/O causes FIONREAD etc to fail to work
         so unless someone can find a portable way of finding
         out how many characters are currently buffered, we
         should stay with away from stream I/O.
         --Egil Kvaleberg <egilk@sn.no>, January 1997.  */
#ifdef EINTR
      /* Keep reading if we got EINTR, so that we don't just exit.
         --Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>,
         22 Dec 1997.  */
      {
        int n;
        do
          n = read (tty, &c, 1);
        while (n == -1 && errno == EINTR);
        rawkey = n == 1 ? c : EOF;
      }
#else
      rawkey = (read (tty, &c, 1) == 1) ? c : EOF;
#endif

      keystroke = rawkey;

      if (rawkey == EOF)
        {
          if (info_input_stream != stdin)
            {
              fclose (info_input_stream);
              info_input_stream = stdin;
              tty = fileno (info_input_stream);
              display_inhibited = 0;
              display_update_display (windows);
              display_cursor_at_point (active_window);
              rawkey = (read (tty, &c, 1) == 1) ? c : EOF;
              keystroke = rawkey;
            }

          if (rawkey == EOF)
            {
              terminal_unprep_terminal ();
              close_dribble_file ();
              exit (EXIT_SUCCESS);
            }
        }
    }

  if (info_dribble_file)
    dribble (keystroke);

  return keystroke;
}

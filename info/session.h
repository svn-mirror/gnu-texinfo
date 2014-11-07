/* session.h -- Functions found in session.c.
   $Id$

   Copyright 1993, 1998, 1999, 2001, 2002, 2004, 2007, 2011, 2013, 2014
   Free Software Foundation, Inc.

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

#ifndef SESSION_H
#define SESSION_H

#include "info.h"
#include "window.h"
#include "dribble.h"

/* Variable controlling the garbage collection of files briefly visited
   during searches.  Such files are normally gc'ed, unless they were
   compressed to begin with.  If this variable is non-zero, it says
   to gc even those file buffer contents which had to be uncompressed. */
extern int gc_compressed_files;

/* When non-zero, tiling takes place automatically when info_split_window
   is called. */
extern int auto_tiling_p;

/* Variable controlling the behaviour of default scrolling when you are
   already at the bottom of a node. */
extern int info_scroll_behaviour;

/* Values for info_scroll_behaviour. */
#define IS_Continuous 0 /* Try to get first menu item, or failing that, the
                           "Next:" pointer, or failing that, the "Up:" and
                           "Next:" of the up. */
#define IS_NextOnly   1 /* Try to get "Next:" menu item. */
#define IS_PageOnly   2 /* Simply give up at the bottom of a node. */

extern int cursor_movement_scrolls_p;

/* Values for scroll_last_node */
#define SLN_Stop   0 /* Stop at the last node */
#define SLN_Top    1 /* Go to the top node */

/* Controls what to do when a scrolling command is issued at the end of the
   last node. */
extern int scroll_last_node;

int get_input_key (void);
int get_another_input_key (void);

VFunction *read_key_sequence (Keymap map, int menu, int mouse,
                              int insert, int *count);
extern unsigned char info_input_pending_p (void);
extern void info_set_node_of_window (WINDOW *window, NODE *node);
extern void initialize_keyseq (void);
extern void add_char_to_keyseq (int character);
extern FILE_BUFFER *file_buffer_of_window (WINDOW *window);
extern int info_select_reference (WINDOW *window, REFERENCE *entry);
extern int info_any_buffered_input_p (void);

#define DUMP_SUBNODES 0x02

extern void dump_nodes_to_file (REFERENCE **references,
				char *output_filename, int flags);

extern char *program_name_from_file_name (char *file_name);

/* Do the physical deletion of WINDOW, and forget this window and
   associated nodes. */
extern void info_delete_window_internal (WINDOW *window);

extern void forget_window_and_nodes (WINDOW *window);
extern void forget_node (WINDOW *win);

/* Tell Info that input is coming from the file FILENAME. */
extern void info_set_input_from_file (char *filename);

/* Error and debugging messages */
extern unsigned debug_level;

#define debug(n,c)							\
  do									\
    {									\
      if (debug_level >= (n))						\
        info_debug c;							\
    }									\
  while (0)

extern void info_debug (const char *format, ...) TEXINFO_PRINTFLIKE(1,2);
  
/* Print args as per FORMAT.  If the window system was initialized,
   then the message is printed in the echo area.  Otherwise, a message is
   output to stderr. */
extern void info_error (const char *format, ...) TEXINFO_PRINTFLIKE(1,2);

void initialize_info_session (void);
void info_read_and_dispatch (void);
void close_info_session (void);
void info_session (REFERENCE **ref_list, char *user_filename, char *error);
extern void initialize_terminal_and_keymaps (char *init_file);
extern REFERENCE *info_intuit_options_node (NODE *initial_node, char *program);

void info_scroll_forward (WINDOW *window, int count);
void info_abort_key (WINDOW *window, int count);

NODE *info_follow_menus (NODE *initial_node, char **menus,
                         char **error_msg, int strict);

/* Adding numeric arguments. */
extern int info_explicit_arg;
extern int ea_explicit_arg;
extern void info_initialize_numeric_arg (void);

/* Found in m-x.c.  */
extern char *read_function_name (char *prompt, WINDOW *window);

extern void show_error_node (char *error_msg);

#endif /* not SESSION_H */

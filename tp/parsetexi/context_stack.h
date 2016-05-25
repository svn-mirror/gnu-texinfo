/* Copyright 2010, 2011, 2012, 2013, 2014, 2015
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>. */

enum context {
    ct_NONE,
    ct_line,
    ct_def,
    ct_preformatted,
    ct_rawpreformatted,
    ct_menu,
    ct_math,
    ct_footnote,
    ct_caption,
    ct_shortcaption,
    ct_inlineraw
};

/* Contexts where an empty line doesn't start a new paragraph. */
/* line 492 */
#define in_paragraph_context(c) \
  !((c) == ct_math \
   || (c) == ct_menu \
   || (c) == ct_def \
   || (c) == ct_preformatted \
   || (c) == ct_rawpreformatted \
   || (c) == ct_inlineraw)

void push_context (enum context c);
enum context pop_context ();
enum context current_context (void);
void reset_context_stack (void);


void push_region (enum command_id r);
enum command_id pop_region ();
enum command_id current_region (void);

void reset_region_stack (void);

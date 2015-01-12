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

#include <stdlib.h>
#include <stdio.h>

#include "parser.h"
#include "input.h"

static ELEMENT *root;

/* Set ROOT to root of tree obtained by parsing FILENAME. */
void
parse_file (char *filename)
{
  debug_output = 0;
  init_index_commands ();
  root = parse_texi_file (filename);
}

ELEMENT *
get_root (void)
{
  return root;
}

char *
element_type_name (ELEMENT *e)
{
  return element_type_names[(e)->type];
}

int
num_contents_children (ELEMENT *e)
{
  return e->contents.number;
}

int
num_args_children (ELEMENT *e)
{
  return e->args.number;
}


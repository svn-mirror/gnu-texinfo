/* xml.c -- xml output.
   $Id: xml.c,v 1.31 2003-11-17 10:10:00 dirt Exp $

   Copyright (C) 2001, 2002, 2003 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

   Originally written by Philippe Martin <feloy@free.fr>.  */

#include "system.h"
#include "makeinfo.h"
#include "insertion.h"
#include "macro.h"
#include "cmds.h"
#include "lang.h"

#include "xml.h"

/* Options */
int xml_index_divisions = 1;


void xml_close_sections (/* int level */);

typedef struct _element
{
  char name[32];
  int contains_para;
  int contained_in_para;
  int keep_space;
} element;

element texinfoml_element_list [] = {
  { "texinfo",             1, 0, 0 },
  { "setfilename",         0, 0, 0 },
  { "titlefont",           0, 0, 0 },
  { "settitle",            0, 0, 0 },

  { "node",                1, 0, 0 },
  { "nodenext",            0, 0, 0 },
  { "nodeprev",            0, 0, 0 },
  { "nodeup",              0, 0, 0 },

  { "chapter",             1, 0, 0 },
  { "section",             1, 0, 0 },
  { "subsection",          1, 0, 0 },
  { "subsubsection",       1, 0, 0 },

  { "top",                 1, 0, 0 },
  { "unnumbered",          1, 0, 0 },
  { "unnumberedsec",       1, 0, 0 },
  { "unnumberedsubsec",    1, 0, 0 },
  { "unnumberedsubsubsec", 1, 0, 0 },

  { "appendix",            1, 0, 0 },
  { "appendixsec",         1, 0, 0 },
  { "appendixsubsec",      1, 0, 0 },
  { "appendixsubsubsec",   1, 0, 0 },

  { "majorheading",        0, 0, 0 },
  { "chapheading",         0, 0, 0 },
  { "heading",             0, 0, 0 },
  { "subheading",          0, 0, 0 },
  { "subsubheading",       0, 0, 0 },

  { "titlepage",           1, 0, 0 },
  { "author",              0, 0, 0 },
  { "booktitle",           0, 0, 0 },
  { "booksubtitle",        0, 0, 0 },

  { "menu",                1, 0, 0 },
  { "menuentry",           1, 0, 0 },
  { "menutitle",           0, 0, 0 },
  { "menucomment",         1, 0, 0 },
  { "menunode",            0, 0, 0 },
  { "nodename",            0, 0, 0 },

  { "acronym",             0, 1, 0 },
  { "tt",                  0, 1, 0 },
  { "code",                0, 1, 0 },
  { "command",             0, 1, 0 },
  { "env",                 0, 1, 0 },
  { "file",                0, 1, 0 },
  { "option",              0, 1, 0 },
  { "samp",                0, 1, 0 },
  { "kbd",                 0, 1, 0 },
  { "url",                 0, 1, 0 },
  { "key",                 0, 1, 0 },
  { "var",                 0, 1, 0 },
  { "sc",                  0, 1, 0 },
  { "dfn",                 0, 1, 0 },
  { "emph",                0, 1, 0 },
  { "strong",              0, 1, 0 },
  { "cite",                0, 1, 0 },
  { "notfixedwidth",       0, 1, 0 },
  { "i",                   0, 1, 0 },
  { "b",                   0, 1, 0 },
  { "r",                   0, 1, 0 },

  { "title",               0, 0, 0 },
  { "ifinfo",              1, 0, 0 },
  { "sp",                  0, 0, 0 },
  { "center",              1, 0, 0 },
  { "dircategory",         0, 0, 0 },
  { "quotation",           1, 0, 0 },
  { "example",             0, 0, 1 },
  { "smallexample",        0, 0, 1 },
  { "lisp",                0, 0, 1 },
  { "smalllisp",           0, 0, 1 },
  { "cartouche",           1, 0, 0 },
  { "copying",             1, 0, 0 },
  { "format",              0, 0, 1 },
  { "smallformat",         0, 0, 1 },
  { "display",             0, 0, 1 },
  { "smalldisplay",        0, 0, 1 },
  { "verbatim",            0, 0, 1 },
  { "footnote",            0, 1, 0 },
  { "",                    0, 1, 0 }, /* LINEANNOTATION (docbook) */

  { "",                    1, 0, 0 }, /* TIP (docbook)       */
  { "",                    1, 0, 0 }, /* NOTE (docbook)      */
  { "",                    1, 0, 0 }, /* IMPORTANT (docbook) */
  { "",                    1, 0, 0 }, /* WARNING (docbook)   */
  { "",                    1, 0, 0 }, /* CAUTION (docbook)   */

  { "itemize",             0, 0, 0 },
  { "itemfunction",        0, 0, 0 },
  { "item",                1, 0, 0 },
  { "enumerate",           0, 0, 0 },
  { "table",               0, 0, 0 },
  { "tableitem",           0, 0, 0 }, /* not used */ /* TABLEITEM */
  { "tableterm",           0, 0, 0 }, /* not used */ /* TABLETERM */

  { "indexterm",           0, 1, 0 },

  { "xref",                0, 1, 0 },
  { "xrefnodename",        0, 1, 0 },
  { "xrefinfoname",        0, 1, 0 },
  { "xrefprinteddesc",     0, 1, 0 },
  { "xrefinfofile",        0, 1, 0 },
  { "xrefprintedname",     0, 1, 0 },

  { "inforef",             0, 1, 0 },
  { "inforefnodename",     0, 1, 0 },
  { "inforefrefname",      0, 1, 0 },
  { "inforefinfoname",     0, 1, 0 },

  { "uref",                0, 1, 0 },
  { "urefurl",             0, 1, 0 },
  { "urefdesc",            0, 1, 0 },
  { "urefreplacement",     0, 1, 0 },

  { "email",               0, 1, 0 },
  { "emailaddress",        0, 1, 0 },
  { "emailname",           0, 1, 0 },

  { "group",               0, 0, 0 },

  { "printindex",          0, 0, 0 },
  { "anchor",              0, 1, 0 },
  { "image",               0, 1, 0 },
  { "",                    0, 1, 0 }, /* PRIMARY (docbook) */
  { "",                    0, 1, 0 }, /* SECONDARY (docbook) */
  { "",                    0, 0, 0 }, /* INFORMALFIGURE (docbook) */
  { "",                    0, 0, 0 }, /* MEDIAOBJECT (docbook) */
  { "",                    0, 0, 0 }, /* IMAGEOBJECT (docbook) */
  { "",                    0, 0, 0 }, /* IMAGEDATA (docbook) */
  { "",                    0, 0, 0 }, /* TEXTOBJECT (docbook) */
  { "",                    0, 0, 0 }, /* INDEXENTRY (docbook) */
  { "",                    0, 0, 0 }, /* PRIMARYIE (docbook) */
  { "",                    0, 0, 0 }, /* SECONDARYIE (docbook) */
  { "",                    0, 0, 0 }, /* INDEXDIV (docbook) */
  { "multitable",          0, 0, 0 },
  { "",                    0, 0, 0 }, /* TGROUP (docbook) */
  { "columnfraction",      0, 0, 0 },
  { "thead",               0, 0, 0 },
  { "tbody",               0, 0, 0 },
  { "entry",               0, 0, 0 },
  { "row",                 0, 0, 0 },
  { "",                    0, 0, 0 }, /* BOOKINFO (docbook) */
  { "",                    0, 0, 0 }, /* ABSTRACT (docbook) */
  { "",                    0, 0, 0 }, /* REPLACEABLE (docbook) */
  { "",                    0, 0, 0 }, /* ENVAR (docbook) */
  { "",                    0, 0, 0 }, /* COMMENT (docbook) */
  { "",                    0, 0, 0 }, /* FUNCTION (docbook) */
  { "",                    0, 0, 0 }, /* LEGALNOTICE (docbook) */

  { "contents",            0, 0, 0 },
  { "shortcontents",       0, 0, 0 },
  { "documentlanguage",    0, 1, 0 },

  { "setvalue",            0, 0, 0 },
  { "clearvalue",          0, 0, 0 },

  { "definition",          0, 0, 0 },
  { "definitionterm",      0, 0, 0 },
  { "definitionitem",      1, 0, 0 },
  { "defcategory",         0, 0, 0 },
  { "deffunction",         0, 0, 0 },
  { "defvariable",         0, 0, 0 },
  { "defparam",            0, 0, 0 },
  { "defdelimiter",        0, 0, 0 },
  { "deftype",             0, 0, 0 },
  { "defparamtype",        0, 0, 0 },
  { "defdatatype",         0, 0, 0 },
  { "defclass",            0, 0, 0 },
  { "defclassvar",         0, 0, 0 },
  { "defoperation",        0, 0, 0 },

  { "para",                0, 0, 0 } /* Must be last */
  /* name / contains para / contained in para / preserve space */
};

element docbook_element_list [] = {
  { "book",                0, 0, 0 }, /* TEXINFO */
  { "",                    0, 0, 0 }, /* SETFILENAME */
  { "",                    0, 0, 0 }, /* TITLEINFO */
  { "title",               0, 0, 0 }, /* SETTITLE */

  { "",                    1, 0, 0 }, /* NODE */
  { "",                    0, 0, 0 }, /* NODENEXT */
  { "",                    0, 0, 0 }, /* NODEPREV */
  { "",                    0, 0, 0 }, /* NODEUP */

  { "chapter",             1, 0, 0 },
  { "sect1",               1, 0, 0 }, /* SECTION */
  { "sect2",               1, 0, 0 }, /* SUBSECTION */
  { "sect3",               1, 0, 0 }, /* SUBSUBSECTION */

  { "chapter",             1, 0, 0 }, /* TOP */
  { "chapter",             1, 0, 0 }, /* UNNUMBERED */
  { "sect1",               1, 0, 0 }, /* UNNUMBEREDSEC */
  { "sect2",               1, 0, 0 }, /* UNNUMBEREDSUBSEC */
  { "sect3",               1, 0, 0 }, /* UNNUMBEREDSUBSUBSEC */

  { "appendix",            1, 0, 0 },
  { "sect1",               1, 0, 0 }, /* APPENDIXSEC */
  { "sect2",               1, 0, 0 }, /* APPENDIXSUBSEC */
  { "sect3",               1, 0, 0 }, /* APPENDIXSUBSUBSEC */

  { "chapter",             1, 0, 0 }, /* MAJORHEADING */
  { "chapter",             1, 0, 0 }, /* CHAPHEADING */
  { "sect1",               1, 0, 0 }, /* HEADING */
  { "sect2",               1, 0, 0 }, /* SUBHEADING */
  { "simplesect",          1, 0, 0 }, /* SUBSUBHEADING */

  { "",                    0, 0, 0 }, /* TITLEPAGE */
  { "",                    0, 0, 0 }, /* AUTHOR */
  { "",                    0, 0, 0 }, /* BOOKTITLE */
  { "",                    0, 0, 0 }, /* BOOKSUBTITLE */

  { "",                    1, 0, 0 }, /* MENU */
  { "",                    1, 0, 0 }, /* MENUENTRY */
  { "",                    0, 0, 0 }, /* MENUTITLE */
  { "",                    1, 0, 0 }, /* MENUCOMMENT */
  { "",                    0, 0, 0 }, /* MENUNODE */
  { "anchor",              0, 0, 0 }, /* NODENAME */

  { "acronym",             0, 1, 0 },
  { "literal",             0, 1, 0 }, /* TT */
  { "literal",             0, 1, 0 }, /* CODE */
  { "command",             0, 1, 0 }, /* COMMAND */
  { "envar",               0, 1, 0 }, /* ENV */
  { "filename",            0, 1, 0 }, /* FILE */
  { "option",              0, 1, 0 }, /* OPTION */
  { "literal",             0, 1, 0 }, /* SAMP */
  { "userinput",           0, 1, 0 }, /* KBD */
  { "wordasword",          0, 1, 0 }, /* URL */
  { "keycap",              0, 1, 0 }, /* KEY */
  { "replaceable",         0, 1, 0 }, /* VAR */
  { "",                    0, 1, 0 }, /* SC */
  { "firstterm",           0, 1, 0 }, /* DFN */
  { "emphasis",            0, 1, 0 }, /* EMPH */
  { "emphasis",            0, 1, 0 }, /* STRONG */
  { "citetitle",           0, 1, 0 }, /* CITE */
  { "",                    0, 1, 0 }, /* NOTFIXEDWIDTH */
  { "wordasword",          0, 1, 0 }, /* I */
  { "emphasis",            0, 1, 0 }, /* B */
  { "",                    0, 1, 0 }, /* R */

  { "title",               0, 0, 0 },
  { "",                    1, 0, 0 }, /* IFINFO */
  { "",                    0, 0, 0 }, /* SP */
  { "",                    1, 0, 0 }, /* CENTER */
  { "",                    0, 0, 0 }, /* DIRCATEGORY */
  { "blockquote",          1, 0, 0 }, /* QUOTATION */
  { "screen",              0, 1, 0 },
  { "screen",              0, 1, 0 }, /* SMALLEXAMPLE */
  { "screen",              0, 1, 0 }, /* LISP */
  { "screen",              0, 1, 0 }, /* SMALLLISP */
  { "",                    1, 0, 0 }, /* CARTOUCHE */
  { "",                    1, 0, 0 }, /* COPYING */
  { "screen",              0, 1, 0 }, /* FORMAT */
  { "screen",              0, 1, 0 }, /* SMALLFORMAT */
  { "screen",              0, 1, 0 }, /* DISPLAY */
  { "screen",              0, 1, 0 }, /* SMALLDISPLAY */
  { "screen",              0, 0, 0 }, /* VERBATIM */
  { "footnote",            0, 1, 0 },
  { "lineannotation",      0, 1, 0 },

  { "tip",                 1, 0, 0 },
  { "note",                1, 0, 0 },
  { "important",           1, 0, 0 },
  { "warning",             1, 0, 0 },
  { "caution",             1, 0, 0 },

  { "itemizedlist",        0, 0, 0 }, /* ITEMIZE */
  { "",                    0, 0, 0 }, /* ITEMFUNCTION */
  { "listitem",            1, 0, 0 }, /* ITEM */
  { "orderedlist",         0, 0, 0 }, /* ENUMERATE */
  { "variablelist",        0, 0, 0 }, /* TABLE */
  { "varlistentry",        0, 0, 0 }, /* TABLEITEM */
  { "term",                0, 0, 0 }, /* TABLETERM */

  { "indexterm",           0, 1, 0 }, /* INDEXTERM */

  { "xref",                0, 1, 0 }, /* XREF */
  { "link",                0, 1, 0 }, /* XREFNODENAME */
  { "",                    0, 1, 0 }, /* XREFINFONAME */
  { "",                    0, 1, 0 }, /* XREFPRINTEDDESC */
  { "",                    0, 1, 0 }, /* XREFINFOFILE */
  { "",                    0, 1, 0 }, /* XREFPRINTEDNAME */

  { "",                    0, 1, 0 }, /* INFOREF */
  { "",                    0, 1, 0 }, /* INFOREFNODENAME */
  { "",                    0, 1, 0 }, /* INFOREFREFNAME */
  { "",                    0, 1, 0 }, /* INFOREFINFONAME */

  { "ulink",               0, 1, 0 }, /* UREF */
  { "",                    0, 1, 0 }, /* UREFURL */
  { "",                    0, 1, 0 }, /* UREFDESC */
  { "",                    0, 1, 0 }, /* UREFREPLACEMENT */

  { "ulink",               0, 1, 0 }, /* EMAIL */
  { "",                    0, 1, 0 }, /* EMAILADDRESS */
  { "",                    0, 1, 0 }, /* EMAILNAME */

  { "",                    0, 0, 0 }, /* GROUP */

  { "index",               0, 1, 0 }, /* PRINTINDEX */
  { "",                    0, 1, 0 }, /* ANCHOR */
  { "",                    0, 1, 0 }, /* IMAGE */
  { "primary",             0, 1, 0 }, /* PRIMARY */
  { "secondary",           0, 1, 0 },
  { "informalfigure",      0, 0, 0 },
  { "mediaobject",         0, 0, 0 },
  { "imageobject",         0, 0, 0 },
  { "imagedata",           0, 0, 0 },
  { "textobject",          0, 0, 0 },
  { "indexentry",          0, 0, 0 },
  { "primaryie",           0, 0, 0 },
  { "secondaryie",         0, 0, 0 },
  { "indexdiv",            0, 0, 0 },
  { "informaltable",       0, 0, 0 },
  { "tgroup",              0, 0, 0 },
  { "colspec",             0, 0, 0 },
  { "thead",               0, 0, 0 },
  { "tbody",               0, 0, 0 },
  { "entry",               0, 0, 0 },
  { "row",                 0, 0, 0 },
  { "bookinfo",            0, 0, 0 },
  { "abstract",            1, 0, 0 },
  { "replaceable",         0, 0, 0 },
  { "envar",               0, 1, 0 },
  { "comment",             0, 0, 0 },
  { "function",            0, 1, 0 },
  { "legalnotice",         1, 0, 0 },

  { "",                    0, 0, 0 }, /* CONTENTS (xml) */
  { "",                    0, 0, 0 }, /* SHORTCONTENTS (xml) */
  { "",                    0, 0, 0 }, /* DOCUMENT LANGUAGE (xml) */

  { "",                    0, 0, 0 }, /* SETVALUE (xml) */
  { "",                    0, 0, 0 }, /* CLEARVALUE (xml) */

  { "",                    0, 0, 0 }, /* DEFINITION (xml) */
  { "",                    0, 0, 0 }, /* DEFINITIONTERM (xml) */
  { "",                    0, 0, 0 }, /* DEFINITIONITEM (xml) */
  { "",                    0, 0, 0 }, /* DEFCATEGORY (xml) */
  { "",                    0, 0, 0 }, /* DEFFUNCTION (xml) */
  { "",                    0, 0, 0 }, /* DEFVARIABLE (xml) */
  { "",                    0, 0, 0 }, /* DEFPARAM (xml) */
  { "",                    0, 0, 0 }, /* DEFDELIMITER (xml) */
  { "",                    0, 0, 0 }, /* DEFTYPE (xml) */
  { "",                    0, 0, 0 }, /* DEFPARAMTYPE (xml) */
  { "",                    0, 0, 0 }, /* DEFDATATYPE (xml) */
  { "",                    0, 0, 0 }, /* DEFCLASS (xml) */
  { "",                    0, 0, 0 }, /* DEFCLASSVAR (xml) */
  { "",                    0, 0, 0 }, /* DEFOPERATION (xml) */

  { "para",                0, 0, 0 } /* Must be last */
  /* name / contains para / contained in para / preserve space */
};

element *xml_element_list = NULL;


typedef struct _replace_element
{
  int element_to_replace;
  int element_containing;
  int element_replacing;
} replace_element;

/* Elements to replace - Docbook only
   -------------------
   if `element_to_replace' have to be inserted
   as a child of `element_containing,'
   use `element_replacing' instead.

   A value of `-1' for element_replacing means `do not use any element.'
*/

replace_element replace_elements [] = {
  { I, TABLETERM, EMPH },
  { B, TABLETERM, EMPH },
  { TT, CODE, -1 },
  { EXAMPLE, DISPLAY, -1 },
  { CODE, DFN, -1 },
  { CODE, VAR, -1 },
  { EMPH, CODE, REPLACEABLE },
  { VAR, VAR, -1},
  { VAR, B, EMPH},
  { B, CODE, ENVAR},
  { CODE, I, EMPH},
  { FORMAT, BOOKINFO, ABSTRACT },
  { QUOTATION, ABSTRACT, -1},
  { LINEANNOTATION, LINEANNOTATION, -1 },
  /* Add your elements to replace here */
  {-1, 0, 0}
};

int xml_in_menu_entry = 0;
int xml_in_menu_entry_comment = 0;
int xml_node_open = 0;
int xml_node_level = -1;
int xml_in_para = 0;
int xml_just_after_element = 0;
int xml_keep_space = 0;

int xml_no_indent = 0;

int xml_no_para = 0;
char *xml_node_id = NULL;
int xml_sort_index = 0;

int xml_in_xref_token = 0;
int xml_in_bookinfo = 0;
int xml_in_book_title = 0;
int xml_in_abstract = 0;
int xml_in_copying = 0;

/* We need to keep footnote state, because elements inside footnote may try
   to close the previous parent para.  */
static int xml_in_footnote = 0;

static int xml_after_table_term = 0;
static int book_started = 0;
static int first_section_opened = 0;

static int xml_in_item[256];
static int xml_table_level = 0;

static int xml_in_def_item[256];
static int xml_definition_level = 0;
int xml_after_def_term = 0;

static int in_table_title = 0;

static int in_indexentry = 0;
static int in_secondary = 0;
static int in_indexterm = 0;

static int xml_current_element ();

void
#if defined (VA_FPRINTF) && __STDC__
xml_insert_element_with_attribute (int elt, int arg, char *format, ...);
#else
xml_insert_element_with_attribute ();
#endif

char *
xml_id (id)
    char *id;
{
  char *tem = xmalloc (strlen (id) + 1);
  char *p = tem;
  strcpy (tem, id);
  while (*p)
    { /* Check if a character is allowed in ID attributes.  This list differs
         slightly from XML specs that it doesn't contain underscores.
         See http://xml.coverpages.org/sgmlsyn/sgmlsyn.htm, ``9.3 Name''  */
      if (!strchr ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-.", *p))
        *p = '-';
      p++;
    }
  p = tem;
  /* First character can only be a letter.  */
  if (!strchr ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", *p))
    *p = 'i';
  return tem;
}

int
xml_element (name)
    char *name;
{
  int i;
  for (i=0; i<=PARA; i++)
    {
      if (strcasecmp (name, texinfoml_element_list[i].name) == 0)
        return i;
    }
  printf ("Error xml_element\n");
  return -1;
}

void
xml_begin_document (output_filename)
    char *output_filename;
{
  if (book_started)
    return;

  book_started = 1;
  if (docbook)
    {
      insert_string ("<!DOCTYPE Book PUBLIC \"-//OASIS//DTD DocBook V3.1//EN\">");
      xml_element_list = docbook_element_list;
    }
  else
    {
      insert_string ("<?xml version=\"1.0\"?><!DOCTYPE texinfo SYSTEM \"texinfo.dtd\">");
      xml_element_list = texinfoml_element_list;
    }
  if (language_code != last_language_code)
    {
      if (docbook)
        xml_insert_element_with_attribute (TEXINFO, START, "lang=\"%s\"", language_table[language_code].abbrev);
      else
	xml_insert_element_with_attribute (TEXINFO, START, "xml:lang=\"%s\"", language_table[language_code].abbrev);
    }
  if (!docbook)
    {
      xml_insert_element (SETFILENAME, START);
      insert_string (output_filename);
      xml_insert_element (SETFILENAME, END);
    }
}

/*  */
static int element_stack[256];
static int element_stack_index = 0;

static void
xml_push_current_element (elt)
    int elt;
{
  element_stack[element_stack_index++] = elt;
  if (element_stack_index > 200)
    printf ("*** stack overflow (%d - %s) ***\n",
            element_stack_index,
            xml_element_list[elt].name);
}

void
xml_pop_current_element ()
{
  element_stack_index--;
  if (element_stack_index < 0)
    printf ("*** stack underflow (%d - %d) ***\n",
            element_stack_index,
            xml_current_element());
}

static int
xml_current_element ()
{
  return element_stack[element_stack_index-1];
}

int
xml_current_stack_index ()
{
  return element_stack_index;
}

void
xml_end_current_element ()
{
  xml_insert_element (xml_current_element (), END);
}

static void
xml_indent ()
{
  int i;
  insert ('\n');
  for (i = 0; i < element_stack_index; i++)
    insert (' ');
}

static void
xml_indent_end_para ()
{
  int i;
  for (i = 0; i < element_stack_index; i++)
    insert (' ');
}

void
xml_start_para ()
{
  if (xml_in_para || xml_in_footnote)
    return;
  if (docbook)
    xml_indent ();
  insert_string ("<para");
  if (xml_no_indent)
    insert_string (" role=\"continues\"");
  insert_string (">");
  xml_no_indent = 0;
  xml_in_para = 1;
}

void
xml_end_para ()
{
  if (!xml_in_para || xml_in_footnote)
    return;
  if (docbook)
    xml_indent_end_para ();
  insert_string ("</para>");
  xml_in_para = 0;
}

void
xml_end_document ()
{
  if (xml_node_open)
    {
      if (xml_node_level != -1)
        {
          xml_close_sections (xml_node_level);
          xml_node_level = -1;
        }
      xml_insert_element (NODE, END);
    }
  else
    xml_close_sections (xml_node_level);

  xml_insert_element (TEXINFO, END);
  insert_string ("\n");
  insert_string ("<!-- Keep this comment at the end of the file\n\
Local variables:\n\
mode: sgml\n\
sgml-indent-step:1\n\
sgml-indent-data:nil\n\
End:\n\
-->\n");
  if (element_stack_index != 0)
    error ("Element stack index : %d\n", element_stack_index);
}

/* MUST be 0 or 1, not true or false values */
static int start_element_inserted = 1;

/* NOTE: We use `elt' rather than `element' in the argument list of
   the next function, since otherwise the Solaris SUNWspro compiler
   barfs because `element' is a typedef declared near the beginning of
   this file.  */
void
#if defined (VA_FPRINTF) && __STDC__
xml_insert_element_with_attribute (int elt, int arg, char *format, ...)
#else
xml_insert_element_with_attribute (elt, arg, format, va_alist)
     int elt;
     int arg;
     char *format;
     va_dcl
#endif
{
  /* Look at the replace_elements table to see if we have to change the element */
  if (xml_sort_index)
      return;
  if (docbook)
    {
      replace_element *element_list = replace_elements;
      while (element_list->element_to_replace >= 0)
        {
          if ( ( (arg == START) &&
                 (element_list->element_containing == xml_current_element ()) &&
                 (element_list->element_to_replace == elt) ) ||
               ( (arg == END) &&
                 (element_list->element_containing == element_stack[element_stack_index-1-start_element_inserted]) &&
                 (element_list->element_to_replace == elt) ) )
            {
              elt = element_list->element_replacing;
              break;
            }
          element_list ++;
        }

      /* Forget the element */
      if (elt < 0)
        {
          if (arg == START)
            start_element_inserted = 0;
          else
            /* Replace the default value, for the next time */
            start_element_inserted = 1;
          return;
        }
    }

  if (!book_started)
    return;

  if (xml_after_table_term && elt != TABLETERM)
    {
      xml_after_table_term = 0;
      xml_insert_element (ITEM, START);
    }

  if (xml_after_def_term && elt != DEFINITIONTERM && arg == START)
    {
      xml_after_def_term = 0;
      xml_insert_element (DEFINITIONITEM, START);
      xml_in_def_item[xml_definition_level] = 1;
    }

  if (docbook && !only_macro_expansion && (in_menu || in_detailmenu))
    return;

  if (!xml_element_list[elt].name || !strlen (xml_element_list[elt].name))
    {
      /*printf ("Warning: Inserting empty element %d\n", elt);*/
      return;
    }

  if (arg == START && !xml_in_para && !xml_no_para
      && xml_element_list[elt].contained_in_para
      && xml_element_list[xml_current_element()].contains_para)
    xml_start_para ();


  if (arg == START && xml_in_para && !xml_element_list[elt].contained_in_para)
    xml_end_para ();

  if (arg == END && xml_in_para && !xml_element_list[elt].contained_in_para)
    xml_end_para ();

  if (arg == START && docbook && !xml_in_para && !xml_element_list[elt].contained_in_para)
    xml_indent ();

  if (docbook && xml_table_level && !xml_in_item[xml_table_level] && !in_table_title
      && arg == START && elt != TABLEITEM && elt != TABLETERM
      && !in_indexterm && xml_current_element() == TABLE)
    {
      in_table_title = 1;
      xml_insert_element (TITLE, START);
    }


  if (arg == START)
    xml_push_current_element (elt);
  else
    xml_pop_current_element ();

  insert ('<');
  if (arg == END)
    insert ('/');
  insert_string (xml_element_list[elt].name);

  /*  printf ("%s ", xml_element_list[elt].name);*/

  if (format)
    {
      char temp_string[2000]; /* xx no fixed limits */
#ifdef VA_SPRINTF
      va_list ap;
#endif

      VA_START (ap, format);
#ifdef VA_SPRINTF
      VA_SPRINTF (temp_string, format, ap);
#else
      sprintf (temp_string, format, a1, a2, a3, a4, a5, a6, a7, a8);
#endif
      insert (' ');
      insert_string (temp_string);
      va_end (ap);
    }

  if (arg == START && xml_node_id && elt != NODENAME)
    {
      insert_string (" id=\"");
      insert_string (xml_node_id);
      insert_string ("\"");
      free (xml_node_id);
      xml_node_id = NULL;
    }

  if (xml_element_list[elt].keep_space)
    {
      if (arg == START)
	{
	  insert_string (" xml:space=\"preserve\"");
	  xml_keep_space++;
	}
      else
	xml_keep_space--;
    }

  insert ('>');

  xml_just_after_element = 1;
}

/* See the NOTE before xml_insert_element_with_attribute, for why we
   use `elt' rather than `element' here.  */
void
xml_insert_element (int elt, int arg)
{
  xml_insert_element_with_attribute (elt, arg, NULL);
}

void
xml_insert_entity (char *entity_name)
{
  int saved_escape_html = escape_html;

  if (!book_started)
    return;
  if (docbook && !only_macro_expansion && (in_menu || in_detailmenu))
    return;

  if (!xml_in_para && !xml_no_para && !only_macro_expansion
      && xml_element_list[xml_current_element ()].contains_para
      && !in_fixed_width_font)
    xml_start_para ();

  escape_html = 0;
  add_char ('&');
  escape_html = saved_escape_html;
  insert_string (entity_name);
  add_char (';');
}

typedef struct _xml_section xml_section;
struct _xml_section {
  int level;
  char *name;
  xml_section *prev;
};

xml_section *last_section = NULL;

void
xml_begin_node ()
{
  first_section_opened = 1;
  if (xml_in_abstract)
    {
      xml_insert_element (ABSTRACT, END);
      xml_in_abstract = 0;
    }
  if (xml_in_bookinfo)
    {
      xml_insert_element (BOOKINFO, END);
      xml_in_bookinfo = 0;
    }
  if (xml_node_open && ! docbook)
    {
      if (xml_node_level != -1)
        {
          xml_close_sections (xml_node_level);
          xml_node_level = -1;
        }
      xml_insert_element (NODE, END);
    }
  xml_insert_element (NODE, START);
  xml_node_open = 1;
}

void
xml_close_sections (level)
    int level;
{
  if (!first_section_opened)
    {
      if (xml_in_abstract)
	{
	  xml_insert_element (ABSTRACT, END);
	  xml_in_abstract = 0;
	}
      if (xml_in_bookinfo)
	{
	  xml_insert_element (BOOKINFO, END);
	  xml_in_bookinfo = 0;
	}
      first_section_opened = 1;
    }

  while (last_section && last_section->level >= level)
    {
      xml_section *temp = last_section;
      xml_insert_element (xml_element(last_section->name), END);
      temp = last_section;
      last_section = last_section->prev;
      free (temp->name);
      free (temp);
    }
}

void
xml_open_section (level, name)
    int level;
    char *name;
{
  xml_section *sect = (xml_section *) xmalloc (sizeof (xml_section));

  sect->level = level;
  sect->name = xmalloc (1 + strlen (name));
  strcpy (sect->name, name);
  sect->prev = last_section;
  last_section = sect;

  if (xml_node_open && xml_node_level == -1)
    xml_node_level = level;
}

void
xml_start_menu_entry (tem)
    char *tem;
{
  char *string;
  discard_until ("* ");

  /* The line number was already incremented in reader_loop when we
     saw the newline, and discard_until has now incremented again.  */
  line_number--;

  if (xml_in_menu_entry)
    {
      if (xml_in_menu_entry_comment)
        {
          xml_insert_element (MENUCOMMENT, END);
          xml_in_menu_entry_comment=0;
        }
      xml_insert_element (MENUENTRY, END);
      xml_in_menu_entry=0;
    }
  xml_insert_element (MENUENTRY, START);
  xml_in_menu_entry=1;

  xml_insert_element (MENUNODE, START);
  string = expansion (tem, 0);
  add_word (string);
  xml_insert_element (MENUNODE, END);
  free (string);

  /* The menu item may use macros, so expand them now.  */
  xml_insert_element (MENUTITLE, START);
  only_macro_expansion++;
  get_until_in_line (1, ":", &string);
  only_macro_expansion--;
  execute_string ("%s", string); /* get escaping done */
  xml_insert_element (MENUTITLE, END);
  free (string);

  if (looking_at ("::"))
    discard_until (":");
  else
    { /* discard the node name */
      get_until_in_line (0, ".", &string);
      free (string);
    }
  input_text_offset++;  /* discard the second colon or the period */
  xml_insert_element (MENUCOMMENT, START);
  xml_in_menu_entry_comment ++;
}

void
xml_end_menu ()
{
  if (xml_in_menu_entry)
    {
      if (xml_in_menu_entry_comment)
        {
          xml_insert_element (MENUCOMMENT, END);
          xml_in_menu_entry_comment --;
        }
      xml_insert_element (MENUENTRY, END);
      xml_in_menu_entry--;
    }
  xml_insert_element (MENU, END);
}

static int xml_last_character;
static int xml_in_legalnotice = 0;

void
xml_add_char (character)
    int character;
{
  int xml_skip_newline = 0;

  if (!book_started)
      return;
  if (docbook && !only_macro_expansion && (in_menu || in_detailmenu))
    return;

  if (docbook && xml_table_level && !xml_in_item[xml_table_level] && !in_table_title
      && !cr_or_whitespace (character) && !in_indexterm)
    {
      in_table_title = 1;
      xml_insert_element (TITLE, START);
    }

  if (!xml_in_copying && !first_section_opened && !xml_in_abstract
      && !xml_in_book_title && !xml_no_para
      && character != '\r' && character != '\n' && character != ' ')
    {
      if (!xml_in_bookinfo)
	{
	  xml_insert_element (BOOKINFO, START);
	  xml_in_bookinfo = 1;
	}
      xml_insert_element (ABSTRACT, START);
      xml_in_abstract = 1;
    }

  if (xml_in_copying && !xml_in_legalnotice)
    {
      xml_in_legalnotice = 1;
      if (docbook)
        xml_insert_element (QUOTATION, START);
      else
        xml_insert_element (COPYING, START);
    }

  if (xml_after_table_term && !xml_sort_index && !xml_in_xref_token)
    {
      xml_after_table_term = 0;
      xml_insert_element (ITEM, START);
    }

  if (xml_after_def_term && !xml_sort_index && !xml_in_xref_token)
    {
      xml_after_def_term = 0;
      xml_insert_element (DEFINITIONITEM, START);
      xml_in_def_item[xml_definition_level] = 1;
    }

  if (xml_just_after_element && !xml_in_para && !inhibit_paragraph_indentation)
    {
      if (character == '\r' || character == '\n' || character == '\t' || character == ' ')
        return;
      xml_just_after_element = 0;
    }

  if (xml_element_list[xml_current_element()].contains_para
      && !xml_in_para && !only_macro_expansion && !xml_no_para
      && !cr_or_whitespace (character) && !in_fixed_width_font)
    xml_start_para ();

  if (xml_in_para)
    {
      if (character == '\n')
        {
          if (xml_last_character == '\n' && !only_macro_expansion && !xml_no_para
              && xml_element_list[xml_current_element()].contains_para )
            {
              xml_end_para ();
              xml_just_after_element = 1;
	      xml_skip_newline = 1;
              if (xml_in_menu_entry_comment)
                {
                  xml_insert_element (MENUCOMMENT, END);
                  xml_in_menu_entry_comment = 0;
                  xml_insert_element (MENUENTRY, END);
                  xml_in_menu_entry = 0;
                }
            }
        }
    }

  if (character == '\n' && !xml_in_para && !inhibit_paragraph_indentation)
    return;

  xml_last_character = character;

  if (xml_skip_newline && !docbook)
    return;

  if (character == '&' && escape_html)
      insert_string ("&amp;");
  else if (character == '<' && escape_html)
      insert_string ("&lt;");
  else if (character == '\n' && !xml_keep_space && !docbook)
    {
      if (!xml_in_para && xml_just_after_element)
	return;
      else
	insert_string (" ");
    }
  else
    insert (character);

  return;
}

void
xml_insert_footnote (note)
    char *note;
{
  xml_in_footnote = 1;
  xml_insert_element (FOOTNOTE, START);
  insert_string ("<para>");
  execute_string ("%s", note);
  insert_string ("</para>");
  xml_insert_element (FOOTNOTE, END);
  xml_in_footnote = 0;
}

/* We need to keep the quotation stack ourself, because insertion_stack
   loses item_function when we are closing the block, so we don't know
   what to close then.  */
static char *quotation_stack[] = { NULL };
static int quotation_level = 0;

void
xml_insert_quotation (type, arg)
  char *type;
  int arg;
{
  int quotation_started = 0;

  if (arg == START)
    quotation_stack[quotation_level] = xstrdup(type);
  else
    type = quotation_stack[quotation_level-1];

  /* Make use of special quotation styles of Docbook if we can.  */
  if (docbook && strlen(type))
    {
      /* Let's assume it started.  */
      quotation_started = 1;

      if (strcasecmp (type, "tip") == 0)
        xml_insert_element (TIP, arg);
      else if (strcasecmp (type, "note") == 0)
        xml_insert_element (NOTE, arg);
      else if (strcasecmp (type, "important") == 0)
        xml_insert_element (IMPORTANT, arg);
      else if (strcasecmp (type, "warning") == 0)
        xml_insert_element (WARNING, arg);
      else if (strcasecmp (type, "caution") == 0)
        xml_insert_element (CAUTION, arg);
      else
        /* Didn't find a known quotation type :\ */
        quotation_started = 0;
    }

  if (!quotation_started)
    {
      xml_insert_element (QUOTATION, arg);
      if (strlen(type) && arg == START)
        execute_string ("@b{%s:} ", type);
    }

  if (arg == START)
    quotation_level ++;
  else
    free (quotation_stack[--quotation_level]);

  if (quotation_level < 0)
    printf ("*** quotation stack underflow (%d) ***\n", quotation_level);
}

/*
 * Lists and Tables
 */
void
xml_begin_table (type, item_function)
    enum insertion_type type;
    char *item_function;
{
  switch (type)
    {
    case ftable:
    case vtable:
    case table:
      /*if (docbook)*/ /* 05-08 */
        {
          xml_insert_element (TABLE, START);
          xml_table_level ++;
          xml_in_item[xml_table_level] = 0;
        }
      break;
    case itemize:
      if (!docbook)
        {
          xml_insert_element (ITEMIZE, START);
          xml_table_level ++;
          xml_in_item[xml_table_level] = 0;
          xml_insert_element (ITEMFUNCTION, START);
          if (*item_function == COMMAND_PREFIX
              && item_function[strlen (item_function) - 1] != '}'
              && command_needs_braces (item_function + 1))
            execute_string ("%s{}", item_function);
          else
            execute_string ("%s", item_function);
          xml_insert_element (ITEMFUNCTION, END);
        }
      else
        {
          xml_insert_element_with_attribute (ITEMIZE, START,
                                             "mark=\"%s\"",
                                             (*item_function == COMMAND_PREFIX) ?
                                             &item_function[1] : item_function);
          xml_table_level ++;
          xml_in_item[xml_table_level] = 0;
        }
      break;
    }
}

void
xml_end_table (type)
    enum insertion_type type;
{
  switch (type)
    {
    case ftable:
    case vtable:
    case table:
      /*      if (docbook)*/ /* 05-08 */
        {
          if (xml_in_item[xml_table_level])
            {
              xml_insert_element (ITEM, END);
              xml_insert_element (TABLEITEM, END);
              xml_in_item[xml_table_level] = 0;
            }
          xml_insert_element (TABLE, END);
          xml_table_level --;
        }
      break;
    case itemize:
      if (xml_in_item[xml_table_level])
        {
          xml_insert_element (ITEM, END);
          xml_in_item[xml_table_level] = 0;
        }
      /* gnat-style manual contains an itemized list without items! */
      if (in_table_title)
	{
	  xml_insert_element (TITLE, END);
	  in_table_title = 0;
	}
      xml_insert_element (ITEMIZE, END);
      xml_table_level --;
      break;
    }
}

void
xml_begin_item ()
{
  if (xml_in_item[xml_table_level])
    xml_insert_element (ITEM, END);

  xml_insert_element (ITEM, START);
  xml_in_item[xml_table_level] = 1;
}

void
xml_begin_table_item ()
{
  if (!xml_after_table_term)
    {
      if (xml_in_item[xml_table_level])
        {
          xml_insert_element (ITEM, END);
          xml_insert_element (TABLEITEM, END);
        }
      if (in_table_title)
	{
	  in_table_title = 0;
	  xml_insert_element (TITLE, END);
	}
      xml_insert_element (TABLEITEM, START);
    }
  xml_insert_element (TABLETERM, START);
  xml_in_item[xml_table_level] = 1;
  xml_after_table_term = 0;
}

void
xml_continue_table_item ()
{
  xml_insert_element (TABLETERM, END);
  xml_after_table_term = 1;
}

void
xml_begin_enumerate (enum_arg)
    char *enum_arg;
{
  if (!docbook)
    xml_insert_element_with_attribute (ENUMERATE, START, "first=\"%s\"", enum_arg);
  else
    {
      if (isdigit (*enum_arg))
      {
        if (enum_arg[0] == '1')
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "numeration=\"arabic\"", NULL);
        else
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "continuation=\"continues\" numeration=\"arabic\"", NULL);
      }
      else if (isupper (*enum_arg))
        {
        if (enum_arg[0] == 'A')
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "numeration=\"upperalpha\"", NULL);
        else
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "continuation=\"continues\" numeration=\"upperalpha\"", NULL);
      }
      else
        {
          if (enum_arg[0] == 'a')
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "numeration=\"loweralpha\"", NULL);
        else
          xml_insert_element_with_attribute (ENUMERATE, START,
                                             "continuation=\"continues\" numeration=\"loweralpha\"", NULL);
        }
    }
  xml_table_level ++;
  xml_in_item[xml_table_level] = 0;
}

void
xml_end_enumerate ()
{
  if (xml_in_item[xml_table_level])
    {
      xml_insert_element (ITEM, END);
      xml_in_item[xml_table_level] = 0;
    }
  xml_insert_element (ENUMERATE, END);
  xml_table_level --;
}

static void
xml_insert_text_file (name_arg)
    char *name_arg;
{
  char *fullname = xmalloc (strlen (name_arg) + 4 + 1);
  FILE *image_file;
  strcpy (fullname, name_arg);
  strcat (fullname, ".txt");
  image_file = fopen (fullname, "r");
  if (image_file)
    {
      int ch;
      int save_inhibit_indentation = inhibit_paragraph_indentation;
      int save_filling_enabled = filling_enabled;

      xml_insert_element (TEXTOBJECT, START);
      xml_insert_element (DISPLAY, START);

      inhibit_paragraph_indentation = 1;
      filling_enabled = 0;
      last_char_was_newline = 0;

      /* Maybe we need to remove the final newline if the image
         file is only one line to allow in-line images.  On the
         other hand, they could just make the file without a
         final newline.  */
      while ((ch = getc (image_file)) != EOF)
        add_char (ch);

      inhibit_paragraph_indentation = save_inhibit_indentation;
      filling_enabled = save_filling_enabled;

      xml_insert_element (DISPLAY, END);
      xml_insert_element (TEXTOBJECT, END);

      if (fclose (image_file) != 0)
        perror (fullname);
    }
  else
    warning (_("@image file `%s' unreadable: %s"), fullname,
             strerror (errno));

  free (fullname);
}

void
xml_insert_docbook_image (name_arg)
    char *name_arg;
{
  xml_insert_element (INFORMALFIGURE, START);
  xml_insert_element (MEDIAOBJECT, START);

  xml_insert_element (IMAGEOBJECT, START);
  xml_insert_element_with_attribute (IMAGEDATA, START, "fileref=\"%s.eps\" format=\"eps\"", name_arg);
  xml_pop_current_element ();
  xml_insert_element (IMAGEOBJECT, END);

  xml_insert_element (IMAGEOBJECT, START);
  xml_insert_element_with_attribute (IMAGEDATA, START, "fileref=\"%s.jpg\" format=\"jpg\"", name_arg);
  xml_pop_current_element ();
  xml_insert_element (IMAGEOBJECT, END);

  xml_insert_text_file (name_arg);

  xml_insert_element (MEDIAOBJECT, END);
  xml_insert_element (INFORMALFIGURE, END);
}

void
xml_asterisk ()
{
}


/*
 *     INDEX
 */
/* Used to separate primary and secondary entries in an index -- we need
   to have real multilivel indexing support, not just string analysis.  */
#define INDEX_SEP "@this string will never appear@" /* was , */

typedef struct
{
  char *from;
  char *to;
} XML_SYNONYM;

static XML_SYNONYM **xml_synonyms = NULL;
static int xml_synonyms_count = 0;

void
xml_insert_indexterm (indexterm, index)
    char *indexterm;
    char *index;
{
  if (!docbook)
    {
      /* Check to see if we need to do index redirection per @synindex.  */
      int i;
      for (i = 0; i < xml_synonyms_count; i++)
        {
          if (STREQ (xml_synonyms[i]->from, index))
            index = xstrdup (xml_synonyms[i]->to);
        }

      xml_insert_element_with_attribute (INDEXTERM, START, "index=\"%s\"", index);
      in_indexterm = 1;
      execute_string ("%s", indexterm);
      xml_insert_element (INDEXTERM, END);
      in_indexterm = 0;
    }
  else
    {
      char *primary = NULL, *secondary;
      if (strstr (indexterm+1, INDEX_SEP))
        {
          primary = xmalloc (strlen (indexterm) + 1);
          strcpy (primary, indexterm);
          secondary = strstr (primary+1, INDEX_SEP);
          *secondary = '\0';
          secondary += strlen (INDEX_SEP);
        }
      xml_insert_element_with_attribute (INDEXTERM, START, "role=\"%s\"", index);
      in_indexterm = 1;
      xml_insert_element (PRIMARY, START);
      if (primary)
        execute_string (primary);
      else
        execute_string (indexterm);
      xml_insert_element (PRIMARY, END);
      if (primary)
        {
          xml_insert_element (SECONDARY, START);
          execute_string (secondary);
          xml_insert_element (SECONDARY, END);
        }
      xml_insert_element (INDEXTERM, END);
      in_indexterm = 0;
    }
}


int xml_last_section_output_position = 0;
static char last_division_letter = ' ';
static char index_primary[2000]; /** xx no fixed limit */
static int indexdivempty = 0;

static void
xml_close_indexentry ()
{
  if (!in_indexentry)
    return;
  if (in_secondary)
    xml_insert_element (SECONDARYIE, END);
  xml_insert_element (INDEXENTRY, END);
  in_secondary = 0;
  in_indexentry = 0;
}

void
xml_begin_index ()
{
  /*
     We assume that we just opened a section, and so that the last output is
     <SECTION ID="node-name"><TITLE>Title</TITLE>
     where SECTION can be CHAPTER, ...
   */

  xml_section *temp = last_section;

  int l = output_paragraph_offset-xml_last_section_output_position;
  char *tmp = xmalloc (l+1);
  char *p = tmp;
  strncpy (tmp, output_paragraph, l);

  /* We remove <SECTION */
  tmp[l] = '\0';
  while (*p != '<')
    p++;
  while (*p != ' ')
    p++;

  output_paragraph_offset = xml_last_section_output_position;
  xml_last_section_output_position = 0;

  xml_pop_current_element (); /* remove section element from elements stack */

  if (last_section)
    last_section = last_section->prev; /* remove section from sections stack */
  if (temp)
    {
      free (temp->name);
      free (temp);
    }

  /* We put <INDEX> */
  xml_insert_element (PRINTINDEX, START);
  /* Remove the final > */
  output_paragraph_offset--;

  /* and put  ID="node-name"><TITLE>Title</TITLE> */
  insert_string (p);

  if (xml_index_divisions)
    {
      xml_insert_element (INDEXDIV, START);
      indexdivempty = 1;
    }
}

void
xml_end_index ()
{
  xml_close_indexentry ();
  if (xml_index_divisions)
    xml_insert_element (INDEXDIV, END);
  xml_insert_element (PRINTINDEX, END);
}

void
xml_index_divide (entry)
    char *entry;
{
  char c;
  if (strlen (entry) > (strlen (xml_element_list[CODE].name) + 2) &&
      strncmp (entry+1, xml_element_list[CODE].name, strlen (xml_element_list[CODE].name)) == 0)
    c = entry[strlen (xml_element_list[CODE].name)+2];
  else
    c = entry[0];
  if (tolower (c) != last_division_letter && isalpha (c))
    {
      last_division_letter = tolower (c);
      xml_close_indexentry ();
      if (!indexdivempty)
        {
          xml_insert_element (INDEXDIV, END);
          xml_insert_element (INDEXDIV, START);
        }
      xml_insert_element (TITLE, START);
      insert (toupper (c));
      xml_insert_element (TITLE, END);
    }
}

void
xml_insert_indexentry (entry, node)
    char *entry;
    char *node;
{
  char *primary = NULL, *secondary;
  if (xml_index_divisions)
    xml_index_divide (entry);

  indexdivempty = 0;
  if (strstr (entry+1, INDEX_SEP))
    {
      primary = xmalloc (strlen (entry) + 1);
      strcpy (primary, entry);
      secondary = strstr (primary+1, INDEX_SEP);
      *secondary = '\0';
      secondary += strlen (INDEX_SEP);

      if (in_secondary && strcmp (primary, index_primary) == 0)
        {
          xml_insert_element (SECONDARYIE, END);
          xml_insert_element (SECONDARYIE, START);
          execute_string (secondary);
        }
      else
        {
          xml_close_indexentry ();
          xml_insert_element (INDEXENTRY, START);
          in_indexentry = 1;
          xml_insert_element (PRIMARYIE, START);
          execute_string (primary);
          xml_insert_element (PRIMARYIE, END);
          xml_insert_element (SECONDARYIE, START);
          execute_string (secondary);
          in_secondary = 1;
        }
    }
  else
    {
      xml_close_indexentry ();
      xml_insert_element (INDEXENTRY, START);
      in_indexentry = 1;
      xml_insert_element (PRIMARYIE, START);
      execute_string (entry);
    }
  add_word_args (", %s", _("see "));
  xml_insert_element_with_attribute (XREF, START, "linkend=\"%s\"", xml_id (node));
  xml_pop_current_element ();

  if (primary)
    {
      strcpy (index_primary, primary);
      /*      xml_insert_element (SECONDARYIE, END);*/
      /*     *(secondary-1) = ',';*/ /* necessary ? */
      free (primary);
    }
  else
    xml_insert_element (PRIMARYIE, END);

  /*  xml_insert_element (INDEXENTRY, END); */
}

void
xml_synindex (from, to)
  char *from;
  char *to;
{
  int i, slot;

  slot = -1;
  for (i = 0; i < xml_synonyms_count; i++)
    if (!xml_synonyms[i])
      {
        slot = i;
        break;
      }

  if (slot < 0)
    {
      slot = xml_synonyms_count;
      xml_synonyms_count++;

      xml_synonyms = (XML_SYNONYM **) xrealloc (xml_synonyms,
          (xml_synonyms_count + 1) * sizeof (XML_SYNONYM *));
    }

  xml_synonyms[slot] = xmalloc (sizeof (XML_SYNONYM));
  xml_synonyms[slot]->from = xstrdup (from);
  xml_synonyms[slot]->to = xstrdup (to);
}

/*
 * MULTITABLE
 */
void
xml_begin_multitable (ncolumns, column_widths)
    int ncolumns;
    int *column_widths;
{
  int i;
  if (docbook)
    {
      xml_insert_element (MULTITABLE, START);
      xml_insert_element_with_attribute (TGROUP, START, "cols=\"%d\"", ncolumns);
      for (i=0; i<ncolumns; i++)
        {
          xml_insert_element_with_attribute (COLSPEC, START, "colwidth=\"%d*\"", column_widths[i]);
          xml_pop_current_element ();
        }
      xml_no_para = 1;
    }
  else
    {
      xml_insert_element (MULTITABLE, START);
      for (i=0; i<ncolumns; i++)
        {
          xml_insert_element (COLSPEC, START);
          add_word_args ("%d", column_widths[i]);
          xml_insert_element (COLSPEC, END);
        }
      xml_no_para = 1;
    }
}

void
xml_end_multitable_row (first_row)
    int first_row;
{
  if (!first_row)
    {
      xml_insert_element (ENTRY, END);
      xml_insert_element (ROW, END);
    }

  if (headitem_flag)
    xml_insert_element (THEAD, START);
  else if (after_headitem)
    {
      xml_insert_element (THEAD, END);
      xml_insert_element (TBODY, START);
    }
  else if (first_row)
    xml_insert_element (TBODY, START);

  xml_insert_element (ROW, START);
  xml_insert_element (ENTRY, START);
}

void
xml_end_multitable_column ()
{
  xml_insert_element (ENTRY, END);
  xml_insert_element (ENTRY, START);
}

void
xml_end_multitable ()
{
  if (docbook)
    {
      xml_insert_element (ENTRY, END);
      xml_insert_element (ROW, END);
      xml_insert_element (TBODY, END);
      xml_insert_element (TGROUP, END);
      xml_insert_element (MULTITABLE, END);
      xml_no_para = 0;
    }
  else
    {
      xml_insert_element (ENTRY, END);
      xml_insert_element (ROW, END);
      xml_insert_element (TBODY, END);
      xml_insert_element (MULTITABLE, END);
      xml_no_para = 0;
    }
}

/*
 * Parameters in @def definitions
 */

#define DEFUN_SELF_DELIMITING(c) \
  ((c) == '(' || (c) == ')' || (c) == '[' || (c) == ']')

void
xml_process_defun_args (defun_args, auto_var_p)
     char **defun_args;
     int auto_var_p;
{
  int pending_space = 0;
  int just_after_paramtype = 0;

  for (;;)
    {
      char *defun_arg = *defun_args++;

      if (defun_arg == NULL)
        break;

      if (defun_arg[0] == ' ')
        {
          pending_space = 1;
          continue;
        }

      if (pending_space)
        {
          add_char (' ');
          pending_space = 0;
        }

      if (DEFUN_SELF_DELIMITING (defun_arg[0]))
        {
	  xml_insert_element (DEFDELIMITER, START);
          add_char (defun_arg[0]);
	  xml_insert_element (DEFDELIMITER, END);
	  just_after_paramtype = 0;
        }
      else if (defun_arg[0] == '&')
	{
	  xml_insert_element (DEFPARAM, START);
	  add_word (defun_arg);
	  xml_insert_element (DEFPARAM, END);
	  just_after_paramtype = 0;
	}
      else if (defun_arg[0] == COMMAND_PREFIX || just_after_paramtype)
	{
	  xml_insert_element (DEFPARAM, START);
	  execute_string ("%s", defun_arg);
	  xml_insert_element (DEFPARAM, END);
	  just_after_paramtype = 0;
	}
      else if (defun_arg[0] == ',' || defun_arg[0] == ';')
	{
	  xml_insert_element (DEFDELIMITER, START);
	  add_word (defun_arg);
	  xml_insert_element (DEFDELIMITER, END);
	  just_after_paramtype = 0;
	}
      else if (auto_var_p)
	{
	  xml_insert_element (DEFPARAM, START);
	  add_word (defun_arg);
	  xml_insert_element (DEFPARAM, END);
	  just_after_paramtype = 0;
	}
      else
	{
	  xml_insert_element (DEFPARAMTYPE, START);
	  add_word (defun_arg);
	  xml_insert_element (DEFPARAMTYPE, END);
	  just_after_paramtype = 1;
	}
    }
}

void
xml_begin_definition ()
{
  xml_insert_element (DEFINITION, START);
  xml_definition_level ++;
  xml_in_def_item[xml_definition_level] = 0;
}

void
xml_end_definition ()
{
  if (xml_in_def_item[xml_definition_level])
    {
      xml_insert_element (DEFINITIONITEM, END);
      xml_in_def_item[xml_definition_level] = 0;
    }
  xml_after_def_term = 0;
  xml_insert_element (DEFINITION, END);
  xml_definition_level --;
}

void
xml_begin_def_term (base_type, category, defined_name,
    type_name, type_name2)
  int base_type;
  char *category;
  char *defined_name;
  char *type_name;
  char *type_name2;
{
  xml_after_def_term = 0;
  xml_insert_element (DEFINITIONTERM, START);

  /* Index entry */
  switch (base_type)
    {
    case deffn:
    case deftypefn:
      execute_string ("@findex %s\n", defined_name);
      break;
    case defvr:
    case deftypevr:
    case defcv:
      execute_string ("@vindex %s\n", defined_name);
      break;
    case deftypeivar:
      execute_string ("@vindex %s %s %s\n", defined_name, _("of"), type_name);
      break;
    case defop:
    case deftypeop:
    case deftypemethod:
      execute_string ("@findex %s %s %s\n", defined_name, _("on"), type_name);
      break;
    case deftp:
      execute_string ("@tindex %s\n", defined_name);
      break;
    }

  /* Start with category.  */
  xml_insert_element (DEFCATEGORY, START);
  execute_string ("%s", category);
  xml_insert_element (DEFCATEGORY, END);
  add_char(' ');

  /* Output type name first for typed definitions.  */
  switch (base_type)
    {
    case deffn:
    case defvr:
    case deftp:
      break;

    case deftypefn:
    case deftypevr:
      xml_insert_element (DEFTYPE, START);
      execute_string ("%s", type_name);
      xml_insert_element (DEFTYPE, END);
      add_char (' ');
      break;

    case deftypemethod:
    case deftypeop:
    case deftypeivar:
      xml_insert_element (DEFTYPE, START);
      execute_string ("%s", type_name2);
      xml_insert_element (DEFTYPE, END);
      add_char (' ');
      break;

    default:
      xml_insert_element (DEFCLASS, START);
      execute_string ("%s", type_name);
      xml_insert_element (DEFCLASS, END);
      add_char (' ');
      break;
    }

  /* Categorize rest of the definitions.  */
  switch (base_type)
    {
    case deffn:
    case deftypefn:
      xml_insert_element (DEFFUNCTION, START);
      execute_string ("%s", defined_name);
      xml_insert_element (DEFFUNCTION, END);
      break;

    case defvr:
    case deftypevr:
      xml_insert_element (DEFVARIABLE, START);
      execute_string ("%s", defined_name);
      xml_insert_element (DEFVARIABLE, END);
      break;

    case deftp:
      xml_insert_element (DEFDATATYPE, START);
      execute_string ("%s", defined_name);
      xml_insert_element (DEFDATATYPE, END);
      break;

    case defcv:
    case deftypeivar:
      xml_insert_element (DEFCLASSVAR, START);
      execute_string ("%s", defined_name);
      xml_insert_element (DEFCLASSVAR, END);
      break;

    case defop:
    case deftypeop:
    case deftypemethod:
      /* Operation / Method */
      xml_insert_element (DEFOPERATION, START);
      execute_string ("%s", defined_name);
      xml_insert_element (DEFOPERATION, END);
      break;
    }
}

void
xml_end_def_term ()
{
  xml_insert_element (DEFINITIONTERM, END);
  xml_after_def_term = 1;
}

#define _GNU_SOURCE
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>

#include "tree_types.h"
#include "text.h"

/* Make sure there are LEN free bytes. */
static void
text_alloc (TEXT *t, size_t len)
{
  if (t->end + len > t->space)
    {
      /* FIXME: Double it instead? */
      t->space = t->end + len;
      if (t->space < 10)
        t->space = 10;
      t->text = realloc (t->text, t->space);
      if (!t->text)
        abort ();
    }
}

void
text_printf (TEXT *t, char *format, ...)
{
  va_list v;
  char *s;

  va_start (v, format);
  vasprintf (&s, format, v);
  text_append (t, s);
  free (s);
  va_end (v);
}

void
text_append_n (TEXT *t, char *s, size_t len)
{
  text_alloc (t, len + 1);
  memcpy (t->text + t->end, s, len);
  t->end += len;
  t->text[t->end] = '\0';
}

void
text_append (TEXT *t, char *s)
{
  size_t len = strlen (s);
  text_append_n (t, s, len);
}

void
text_init (TEXT *t)
{
  t->end = t->space = 0;
  t->text = 0;
}

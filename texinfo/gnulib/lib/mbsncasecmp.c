/* Case-insensitive string comparison function.
   Copyright (C) 1998-1999, 2005-2011 Free Software Foundation, Inc.
   Written by Bruno Haible <bruno@clisp.org>, 2005,
   based on earlier glibc code.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

#include <config.h>

/* Specification.  */
#include <string.h>

#include <ctype.h>
#include <limits.h>

#include "mbuiter.h"

#define TOLOWER(Ch) (isupper (Ch) ? tolower (Ch) : (Ch))

/* Compare the initial segment of the character string S1 consisting of at most
   N characters with the initial segment of the character string S2 consisting
   of at most N characters, ignoring case, returning less than, equal to or
   greater than zero if the initial segment of S1 is lexicographically less
   than, equal to or greater than the initial segment of S2.
   Note: This function may, in multibyte locales, return 0 for initial segments
   of different lengths!  */
int
mbsncasecmp (const char *s1, const char *s2, size_t n)
{
  if (s1 == s2 || n == 0)
    return 0;

  /* Be careful not to look at the entire extent of s1 or s2 until needed.
     This is useful because when two strings differ, the difference is
     most often already in the very few first characters.  */
  if (MB_CUR_MAX > 1)
    {
      mbui_iterator_t iter1;
      mbui_iterator_t iter2;

      mbui_init (iter1, s1);
      mbui_init (iter2, s2);

      while (mbui_avail (iter1) && mbui_avail (iter2))
        {
          int cmp = mb_casecmp (mbui_cur (iter1), mbui_cur (iter2));

          if (cmp != 0)
            return cmp;

          if (--n == 0)
            return 0;

          mbui_advance (iter1);
          mbui_advance (iter2);
        }
      if (mbui_avail (iter1))
        /* s2 terminated before s1 and n.  */
        return 1;
      if (mbui_avail (iter2))
        /* s1 terminated before s2 and n.  */
        return -1;
      return 0;
    }
  else
    {
      const unsigned char *p1 = (const unsigned char *) s1;
      const unsigned char *p2 = (const unsigned char *) s2;
      unsigned char c1, c2;

      for (; ; p1++, p2++)
        {
          c1 = TOLOWER (*p1);
          c2 = TOLOWER (*p2);

          if (--n == 0 || c1 == '\0' || c1 != c2)
            break;
        }

      if (UCHAR_MAX <= INT_MAX)
        return c1 - c2;
      else
        /* On machines where 'char' and 'int' are types of the same size, the
           difference of two 'unsigned char' values - including the sign bit -
           doesn't fit in an 'int'.  */
        return (c1 > c2 ? 1 : c1 < c2 ? -1 : 0);
    }
}

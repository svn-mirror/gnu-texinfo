#! /bin/sh
# Copyright (C) 2010 Free Software Foundation, Inc.
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.

if [ z"$srcdir" = 'z' ]; then
  srcdir=.
fi

if test "z$TEX_HTML_TESTS" != z'yes'; then
  echo "Skipping HTML TeX tests that are not easily reproducible"
  exit 77
fi

"$srcdir"/parser_tests.sh "$@" \
 tex_html
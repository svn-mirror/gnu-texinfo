#!/bin/sh
# gendocs.sh -- generate a GNU manual in many formats.  This script is
#   mentioned in maintain.texi.  See the help message below for usage details.
# $Id: gendocs.sh,v 1.2 2003-10-21 23:35:44 karl Exp $
# 
# Copyright (C) 2003 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you can either send email to this
# program's maintainer or write to: The Free Software Foundation,
# Inc.; 59 Temple Place, Suite 330; Boston, MA 02111-1307, USA.
#
# Original author: Mohit Agarwal.

prog="`basename \"$0\"`"
srcdir=`pwd`

scripturl="http://savannah.gnu.org/cgi-bin/viewcvs/texinfo/texinfo/util/gendocs.sh"
templateurl="http://savannah.gnu.org/cgi-bin/viewcvs/texinfo/texinfo/util/gendocs_template"

: ${MAKEINFO="makeinfo"}
: ${TEXI2DVI="texi2dvi"}
: ${DVIPS="dvips"}
: ${GENDOCS_TEMPLATE_DIR="."}
unset CDPATH

calcsize()
{
  size="`ls -ksl $1 | awk '{print $1}'`"
  echo $size
}

curdate="`date '+%B %d, %Y'`"

if test $# -eq 2; then
  PACKAGE=$1
  MANUAL_TITLE=$2
  echo Generating the manual for $PACKAGE
else
  cat <<END_HELP
Usage: $prog PACKAGE MANUAL_TITLE

Generate various output formats from PACKAGE.texinfo (or .texi or .txi) source.
Example: $prog emacs \"GNU Emacs Manual\"

Typical sequence:
  cd YOURPACKAGESOURCE/doc
  wget "$scripturl"
  wget "$templateurl"
  $prog YOURMANUAL "YOURMANUAL - One-line description"

Output will be in a new subdirectory "manual".  Move all the new files
into your web CVS tree, as explained in the Web Pages node of maintain.texi:
http://www.gnu.org/prep/maintain_toc.html

MANUAL_TITLE is included as part of the HTML <title> of the overall
manual/index.html file.  It should include the name of the package being
documented.  manual/index.html is created by substitution from the file
$GENDOCS_TEMPLATE_DIR/gendocs_template; you can modify this generic
version for your own purposes, if you like.

If you have several manuals, you'll need to run this script several
times with different YOURMANUAL values, and move the contents of the
resulting manual/ directory after each run to a different subdirectory
on your web pages.  Then make (by hand) an overall index.html with links
to them all.

You can set the environment variables MAKEINFO, TEXI2DVI, and DVIPS to
control the programs that get executed, and GENDOCS_TEMPLATE_DIR to
control where the gendocs_template file is looked for.
END_HELP
  exit 1
fi

if test -s $srcdir/$PACKAGE.texinfo; then
  srcfile=$srcdir/$PACKAGE.texinfo
elif test -s $srcdir/$PACKAGE.texi; then
  srcfile=$srcdir/$PACKAGE.texi
elif test -s $srcdir/$PACKAGE.txi; then
  srcfile=$srcdir/$PACKAGE.txi
else
  echo "$0: cannot find .texinfo or .texi or .txi for $PACKAGE in $srcdir." >&2
  exit 1
fi

if test ! -r $GENDOCS_TEMPLATE_DIR/gendocs_template; then
  echo "$0: cannot read $GENDOCS_TEMPLATE_DIR/gendocs_template." >&2
  echo "$0: it is available from $templateurl." >&2
  exit 1
fi

echo Creating manual for the package $PACKAGE
# remove any old junk
rm -rf manual

echo Generating info files...
${MAKEINFO} -o $PACKAGE.info $srcfile
mkdir -p manual/
tar czf manual/$PACKAGE-info.tar.gz $PACKAGE.info*
info_tgz_size="`calcsize manual/$PACKAGE-info.tar.gz`"
# do not mv the info files, there's no point in having them available
# separately on the web.

echo Generating dvi ...
${TEXI2DVI} $srcfile

# now, before we compress dvi:
echo Generating postscript...
${DVIPS} $PACKAGE -o
gzip -f -9 $PACKAGE.ps
ps_gz_size="`calcsize $PACKAGE.ps.gz`"
mv $PACKAGE.ps.gz manual/

# compress/finish dvi:
gzip -f -9 $PACKAGE.dvi
dvi_gz_size="`calcsize $PACKAGE.dvi.gz`"
mv $PACKAGE.dvi.gz manual/

echo Generating pdf ...
${TEXI2DVI} --pdf $srcfile
pdf_size="`calcsize $PACKAGE.pdf`"
mv $PACKAGE.pdf manual/

echo Generating ASCII...
${MAKEINFO} -o - --no-split --no-headers $srcfile > ${srcdir}/$PACKAGE.txt
ascii_size="`calcsize $PACKAGE.txt`"
gzip -f -9 -c $PACKAGE.txt >manual/$PACKAGE.txt.gz
ascii_gz_size="`calcsize manual/$PACKAGE.txt.gz`"
mv $PACKAGE.txt manual/

echo Generating monolithic html...
rm -rf $PACKAGE.html  # in case a directory is left over
${MAKEINFO} --no-split --html $srcfile
html_mono_size="`calcsize $PACKAGE.html`"
gzip -f -9 -c $PACKAGE.html >manual/$PACKAGE.html.gz
html_mono_gz_size="`calcsize manual/$PACKAGE.html.gz`"
mv $PACKAGE.html manual/

echo Generating html by node...
${MAKEINFO} --html $srcfile
if test -d $PACKAGE; then
  split_html_dir=$PACKAGE
elif test -d $PACKAGE.html; then
  split_html_dir=$PACKAGE.html
else 
  echo "$0: can't find split html dir for $srcfile." >&2
fi
(
  cd ${split_html_dir} || exit 1
  tar -czf ../manual/$PACKAGE_html_node.tar.gz -- *.html
)
html_node_tgz_size="`calcsize manual/$PACKAGE_html_node.tar.gz`"
mv ${split_html_dir} manual/html_node

echo Making .tar.gz for sources...
srcfiles=`ls *.texinfo *.texi *.txi 2>/dev/null`
tar czfh manual/$PACKAGE.texi.tar.gz $srcfiles
texi_tgz_size="`calcsize manual/$PACKAGE.texi.tar.gz`"

echo Writing index file...
sed \
   -e "s/%%TITLE%%/$MANUAL_TITLE/g" \
   -e "s/%%DATE%%/$curdate/g" \
   -e "s/%%PACKAGE%%/$PACKAGE/g" \
   -e "s/%%HTML_MONO_SIZE%%/$html_mono_size/g" \
   -e "s/%%HTML_MONO_GZ_SIZE%%/$html_mono_gz_size/g" \
   -e "s/%%HTML_NODE_TGZ_SIZE%%/$html_node_tgz_size/g" \
   -e "s/%%INFO_TGZ_SIZE%%/$info_tgz_size/g" \
   -e "s/%%DVI_GZ_SIZE%%/$dvi_gz_size/g" \
   -e "s/%%PDF_SIZE%%/$pdf_size/g" \
   -e "s/%%PS_GZ_SIZE%%/$ps_gz_size/g" \
   -e "s/%%ASCII_SIZE%%/$ascii_size/g" \
   -e "s/%%ASCII_GZ_SIZE%%/$ascii_gz_size/g" \
   -e "s/%%TEXI_TGZ_SIZE%%/$texi_tgz_size/g" \
   -e "s,%%SCRIPTURL%%,$scripturl,g" \
   -e "s/%%SCRIPTNAME%%/$prog/g" \
$GENDOCS_TEMPLATE_DIR/gendocs_template >manual/index.html

echo "Done!  See manual/ subdirectory for new files."

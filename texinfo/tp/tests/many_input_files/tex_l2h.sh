#! /bin/sh

if test "z$LONG_TESTS" != z'yes' -a "z$ALL_TESTS" != z'yes'; then
  echo "Skipping long tests that take a lot of time to run"
  exit 77
fi

basename=tex_l2h
diffs_dir=diffs
logfile=$basename.log
stdout_file=$basename.out

[ "z$srcdir" = 'z' ] && srcdir=.

if which latex2html > /dev/null 2>&1; then
  :
else
  exit 77
fi

[ -d $diffs_dir ] || mkdir $diffs_dir

echo "$basename" > $logfile
: > $stdout_file

if tmp_dir=`mktemp -p /tmp -d l2h_t2h_XXXXXXXX`; then
  :
else
  exit 1
fi

[ -d $basename ] && rm -rf $basename
mkdir $basename
echo "perl -I $srcdir/../.. -I $srcdir/../../maintain/lib/Unicode-EastAsianWidth/lib/ -I $srcdir/../../maintain/lib/libintl-perl/lib -I $srcdir/../../maintain/lib/Text-Unidecode/lib/ -w $srcdir/../../texi2any.pl --set-init-var 'TEXI2HTML 1' --set-init-var 'TEST 1' --set-init-var L2H_TMP=$tmp_dir --conf-dir $srcdir/../../init --set-init-var 'L2H 1' --set-init-var L2H_FILE=$srcdir/../../t/init/l2h.init --iftex --out $basename/ $srcdir/../formatting/tex_complex.texi $srcdir/../formatting/tex.texi --force >> $stdout_file 2>$basename/${basename}.2" >> $logfile
perl -I $srcdir/../.. -I $srcdir/../../maintain/lib/Unicode-EastAsianWidth/lib/ -I $srcdir/../../maintain/lib/libintl-perl/lib -I $srcdir/../../maintain/lib/Text-Unidecode/lib/ -w $srcdir/../../texi2any.pl --set-init-var 'TEXI2HTML 1' --set-init-var 'TEST 1' --set-init-var L2H_TMP=$tmp_dir --conf-dir $srcdir/../../init --set-init-var 'L2H 1' --set-init-var L2H_FILE=$srcdir/../../t/init/l2h.init --iftex --out $basename/ $srcdir/../formatting/tex_complex.texi $srcdir/../formatting/tex.texi --force >> $stdout_file 2>$basename/${basename}.2

return_code=0
ret=$?
if [ $ret != 0 ]; then
  echo "F: $basename/$basename.2"
  return_code=1
else
  rm -f $basename/*_l2h_images.log $basename/*.aux $basename/*_l2h.css #$basename/*.png
  sed -i -e 's/^texexpand.*/texexpand /' "$basename/$basename.2"
  sed -i '/is no longer supported at.*line/d' "$basename/$basename.2"
  sed -i -e 's/CONTENT="LaTeX2HTML.*/CONTENT="LaTeX2HTML">/' -e \
   's/with LaTeX2HTML.*/with LaTeX2HTML/' "$basename/"*"_l2h.html"
  sed -i -e 's/^# LaTeX2HTML.*/# LaTeX2HTML/' "$basename/"*"_l2h_images.pl"  "$basename/"*"_l2h_labels.pl"
  sed -i -e 's/WIDTH="\([0-9]*\)\([0-9]\)"/WIDTH="100"/' "$basename/"*"_l2h_images.pl" "$basename/"*.html "$basename/"*-l2h_cache.pm
  rm -f "$basename/"*".aux"  "$basename/"*"_l2h_images.out"
  for dir in ${basename}; do
    if [ -d $srcdir/${dir}_res ]; then
      diff -u --exclude=CVS --exclude='*.png' -r "$srcdir/${dir}_res" "${dir}" 2>>$logfile > "$diffs_dir/$dir.diff"
      dif_ret=$?
      if [ $dif_ret != 0 ]; then
        echo "D: $diffs_dir/$dir.diff"
        return_code=1
      else
        rm "$diffs_dir/$dir.diff"
      fi
    else
      echo "no res: ${dir}_res"
    fi
  done
fi

rm -rf $tmp_dir

exit $return_code

EXTRA_DIST = contents_at_begin.texi contents_at_end.texi \
 contents_in_middle_chapter.texi contents_in_middle_section.texi \
 double_contents.texi double_contents_setcontentsaftertitlepage.texi \
 no_content.texi no_content_setcatpage.texi \
 contents_and_parts.texi \
 tests.txt res  res_all res_info

DISTCLEANFILES = tests.log tests.out

distclean-local:
	rm -rf out out_all out_info diffs

dist-hook:
	rm -rf `find $(distdir)/res $(distdir)/res_info $(distdir)/res_all -name .svn`

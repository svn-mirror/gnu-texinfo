EXTRA_DIST = nodetest.texi nodetest_latin1.texi nodetest_utf8.texi \
 multi_lang.texi unknown_language.texi umlaut.texi accent.texi \
 weird_accents.texi accentenc.texi \
 accent-text.txi ogolat2.texi  ogoutf.texi \
 at_commands_in_refs_latin1.texi at_commands_in_refs_utf8.texi \
 japanese.texi chinese_mixed_with_en.texi documentlanguage_set.texi \
 encoding_index-latin1.texi encoding_index.texi  encoding_index-utf8.texi \
 japanese_shift_jis.texi sample_utf8.texi formatting_utf8.texi \
 icons.init tests.txt res res_all res_info

DISTCLEANFILES = tests.log tests.out

distclean-local:
	rm -rf out out_all out_info diffs

dist-hook:
	rm -rf `find $(distdir)/res $(distdir)/res_info $(distdir)/res_all -name .svn`

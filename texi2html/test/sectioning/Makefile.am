EXTRA_DIST = sectioning.texi novalidate.texi first_section_no_node.texi \
 nodes_before_top.texi nodes_after_top.texi section_nodes_before_top.texi \
 nodes_after_top_before_section.texi nodes_test.texi no_section.texi \
 no_node.texi no_section_no_top.texi one_section.texi one_node.texi \
 one_node_and_section.texi first_section_and_nodes.texi double_top.texi \
 rec_nodes.texi lower_subsub.texi raiselowersections.texi \
 top_without_node.texi before_node_and_section.texi \
 section_before_chapter.texi node_footnote.texi at_commands_in_refs.texi \
 test_refs.texi equivalent_nodes.texi nodename_parentheses.texi \
 section_file.texi html-top.texi menu-whitespace.texi nodes_id.texi \
 node-whitespace.texi two_footnotes_in_nodes.texi section_in_unnumbered.texi \
 top.texi more_nodes_than_sections.texi no_node_no_top.texi \
 placed_things_before_element.texi menutextorder.texi semi_auto.texi \
 no_element.texi anchor_in_footnote.texi test_two_include.texi \
 only_documentencoding.texi more_sections_than_nodes.texi \
 nodename_parentheses.texi one_element.texi empty_nodes.texi \
 weird_at_commands_in_nodes.texi double_node_anchor_float.texi \
 nodes_after_top_before_chapter.texi \
 chapter_before_part.texi part_before_section.texi \
 part_before_chapter.texi section_before_part.texi \
 hole_in_sectioning.texi section_before_top_no_node.texi \
 section_before_top.texi \
 part_chapter_after_top.texi part_node_chapter_after_top.texi \
 node_part_chapter_after_top.texi node_part_chapter_after_chapter.texi \
 part_node_after_top.texi part_node_before_top.texi \
 section_chapter_before_top_nodes.texi section_chapter_before_top.texi \
 part_node_appendix.texi part_appendix.texi part_node_part_appendix.texi \
 part_node_part_node_appendix.texi part_node_node_part_appendix.texi \
 other_at_comands_in_nodes_refs.texi text_before_line_command.texi \
 loop_nodes.texi \
 test_directions.init test_renamed_nodes.init tests.txt renamednodes.cnf-ref \
 res res_all res_info res_docbook res_xml res_html

DISTCLEANFILES = tests.log tests.out

distclean-local:
	rm -rf out out_all out_info out_docbook out_xml out_html diffs

dist-hook:
	rm -rf `find $(distdir)/res $(distdir)/res_info $(distdir)/res_all $(distdir)/res_docbook $(distdir)/res_xml $(distdir)/res_html -name .svn`

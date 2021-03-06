# -*-perl-*-
######################################################################
# File: mediawiki.pm
#
# Override values for various customizable procedures are set in this file
# in such a way as to create text suitable for pasting into a MediaWiki.
#
# Load the file with command-line option: --init-file mediawiki.pm
#
# This file is in the public domain. Thus it may easily be used as an 
# example for further customizations.
#
# Originally written by Derek Price in 2005.
# Modified in 2008 and 2009.
#
# $Id: mediawiki.pm,v 1.1 2011-04-09 00:10:45 pertusus Exp $

use strict;

#html_default_load();
t2h_default_load_format('html');

# remark: in my tests, there was no support for mathtt in texvc
# https://bugzilla.wikimedia.org/show_bug.cgi?id=21475
default_load_tex_math();

# inline css style
set_default('INLINE_CSS_STYLE', 1);

set_default('USE_SECTIONS', 1);
set_default('USE_NODES', undef);

# numbers are added automatically based on mediawiki markup
set_default('NUMBER_SECTIONS', 0);

# if this is set footnotes are on a separated page. Otherwise they are at
# the end of each file (if the document is split).
# At the end is better for the mediawiki output which is more per page
# oriented.
set_default('footnotestyle', 'end');

# extension
set_default('EXTENSION', undef);

# extension for nodes files when NODE_FILES is true
set_default('NODE_FILE_EXTENSION', '');	    

# no title page at the beginning
set_default('USE_TITLEPAGE_FOR_TITLE', 0);

# if set and SPLIT is set, then split index pages at the next letter
# after they have more than that many entries
set_default('SPLIT_INDEX', undef);

# Use preformatted menus.
set_default('SIMPLE_MENU', 1);

# no NODE_FILES. In fact the whole ref to external manual is broken.
# This may be revisited later.
set_default('NODE_FILES', 0);

$DEFAULT_RULE = "\n----\n";

my %mediawiki_table_commands;

# FIXME b, i could be ''' ''
# FIXME ''' and '' are stopped by end of lines!
my %style_map_mediawiki = (
  'emph',       {'inline_begin' => "''"},
  'email',      {'function' => \&mediawiki_default_email},
  'math',       {'function' => \&mediawiki_default_math},
  'url',      {'function' => \&mediawiki_default_uref},
  'uref',      {'function' => \&mediawiki_default_uref},
  'strong',     {'inline_begin' => "'''"}
);

foreach my $style_command (keys(%style_map_mediawiki))
{
    if ($style_map_mediawiki{$style_command}->{'inline_begin'})
    {
        foreach my $key ('inline_attribute', 'attribute')
        {
            delete $style_map_pre{$style_command}->{$key};
            delete $style_map{$style_command}->{$key};
        }
        $style_map_pre{$style_command}->{'inline_end'} = $style_map_mediawiki{$style_command}->{'inline_begin'};
        $style_map{$style_command}->{'inline_end'} = $style_map_mediawiki{$style_command}->{'inline_begin'};
    }
    foreach my $key (keys(%{$style_map_mediawiki{$style_command}}))
    {
        $style_map_pre{$style_command}->{$key} = $style_map_mediawiki{$style_command}->{$key};
        $style_map{$style_command}->{$key} = $style_map_mediawiki{$style_command}->{$key};
    }
}

# no samp/kbd in allowed html elements in the default case.
foreach my $style_command (keys(%style_map))
{
    if ($style_map{$style_command}->{'inline_attribute'})
    {
        $style_map{$style_command}->{'inline_attribute'} =~ s/^(samp|kbd)/code/;
    }
}

foreach my $style_command (keys(%style_map_pre))
{
    if ($style_map_pre{$style_command}->{'inline_attribute'})
    {
        $style_map_pre{$style_command}->{'inline_attribute'} =~ s/^(samp|kbd)/code/;
    }
}

$style_map{'indicateurl'} = {'begin' => '&lt;<code><nowiki>', 'end' => '</nowiki></code>&gt;'};
$style_map_pre{'indicateurl'} = {'begin' => '&lt;<code><nowiki>', 'end' => '</nowiki></code>&gt;'};



sub mediawiki_default_email($$)
{
    my $command = shift;
    my $args = shift;
    my $mail = shift @$args;
    my $text = shift @$args;
    $text = '' if (!defined($text));
    $mail = main::normalise_space($mail);
    $text = main::normalise_space($text);
    return $text if ($mail eq '');
    $text = ' ' . $text if ($text ne '');
    return "[mailto:$mail$text]";
}

sub mediawiki_default_uref($$)
{
    shift;
    my $args = shift;
    my $url = shift @$args;
    my $text = shift @$args;
    my $replacement = shift @$args;
    $url = main::normalise_space($url);
    $replacement = '' if (!defined($replacement));
    $replacement = main::normalise_space($replacement);
    $text = '' if (!defined($text));
    $text = main::normalise_space($text);
    $text = $replacement if ($replacement ne '');
    return $text if ($url eq '');
    return &$anchor('', $url, $text);
}

sub mediawiki_default_math($$)
{
    shift;
    my $args = shift;
    my $text = shift @$args;
    return "<math>$text</math>";
}

foreach my $format ('enumerate', 'table', 'vtable', 'ftable')
{
   $format_map{$format} = '';
}

my %processed_formats = ();
# there are no pre used in mediawiki, to have links working in 
# complex formats, therefore the styles are copied in div that
# are used instead. This doesn't really improve the situation, 
# though, since the div outside of a <pre> is not taken into account.
foreach my $complex_format (keys(%complex_format_map))
{
   my $class = $complex_format_map{$complex_format}->{'class'};
   $class = $complex_format if (!defined($class));

   # Avoid doing things twice if the class is associated with more than one
   # complex format
   next if($processed_formats{$class});

   if (defined($css_map{"pre.$class"}))
   {
      if (defined($css_map{"div.$class"}))
      {
           $css_map{"div.$class"} .= "; ";
      }
      else
      {
            $css_map{"div.$class"} = '';
      }
      $css_map{"div.$class"} .= $css_map{"pre.$class"};
   }
   $processed_formats{$class} = 1;
}

foreach my $format ('example', 'display', 'lisp', 'format')
{
   $complex_format_map{$format}->{'begin'} = html_default_attribute_class('div', $format).">\n";
   $complex_format_map{"small$format"}->{'begin'} = html_default_attribute_class('div', "small$format").">\n";
   $complex_format_map{$format}->{'end'} = '</div>'."\n";
   $complex_format_map{"small$format"}->{'end'} = '</div>'."\n";
}
foreach my $format ('menu', 'detailmenu', 'menu_comment')
{
   my $class = $complex_format_map{$format}->{'class'};
   $class = $format if (!defined($class));
   $complex_format_map{$format}->{'begin'} = html_default_attribute_class('div', $class).">\n";
   $complex_format_map{$format}->{'end'} = '</div>'."\n";
}

$texi_formats_map{'direntry'} = 0;

# no acronym nor abbr allowed in wikitext.
$acronym_like = \&t2h_default_acronym_like;

push @command_handler_setup, \&mediawiki_default_initialize_variables;

my %mediawiki_doc_nr_to_file; # File name cache based on file index.
my %mediawiki_target_to_name;
my %mediawiki_special_file_name;
sub mediawiki_default_initialize_variables()
{
    %mediawiki_doc_nr_to_file = (); # File name cache based on file index.
    %mediawiki_target_to_name = ();
    %mediawiki_special_file_name = ();
}

my @html_files_from_tex;
my $mediawiki_out_dir;
my $tex_extension;

push @command_handler_init, \&mediawiki_default_init_html_to_wiki;

sub mediawiki_default_init_html_to_wiki
{
  # This must be done here, because the latex2html handler is added 
  # after command line scanning, so after the mediawiki.pm parsing
  push @command_handler_process, \&mediawiki_default_html_to_wiki;

  $command_handler{'math'}->{'init'} = undef;
  $command_handler{'math'}->{'expand'} = undef;
  $command_handler{'math'} = undef;
  $mediawiki_out_dir = "$Texi2HTML::THISDOC{'destination_directory'}";
  $mediawiki_out_dir = './' if (!defined($mediawiki_out_dir) or $mediawiki_out_dir =~ /^\s*$/);
  @html_files_from_tex = ();
  $tex_extension = undef;
  if ($Texi2HTML::THISDOC{'extensions'}->{'tex4ht'})
  {
    push @html_files_from_tex, "$Texi2HTML::THISDOC{'file_base_name'}_tex4ht_tex.html";
    $tex_extension = 'tex4ht';
  }
  elsif (get_conf('L2H'))
  {
    push @html_files_from_tex, "$Texi2HTML::THISDOC{'file_base_name'}_l2h.html";
    $tex_extension = 'l2h';
    # avoid use of the cache
    set_default('L2H_SKIP', 0);
  }
}

# could be in texi2html.pm...
sub mediawiki_default_readd_end_of_lines($$$$;$)
{
   my $from_file = shift;
   my $to_file = shift;
   my $tex_extension = shift;
   my $basename = shift;
   my $before_wiki = shift;
   # html2wiki removes end of lines, they are readded here
   unless (open (ORIG, $from_file))
   {
      print STDERR "open $from_file error: $!\n";
      return 0;
   }
   unless (open (FINAL, ">$to_file"))
   {
      print STDERR "open $to_file error: $!\n";
      return 0;
   }
   my $line;
   while ($line = <ORIG>)
   {
      if ($before_wiki)
      {
        $line =~ s/(<!-- ${tex_extension}_end $basename ((\w+ |)(\d+)) -->) *$/$1\n\n<p>intersticiae<\/p>\n/;
        $line = Texi2HTML::LaTeX2HTML::change_image_file_names($line) if ($tex_extension eq 'l2h');
      }
      else
      {
        $line =~ s/^(<!-- ${tex_extension}_begin $basename ((\w+ |)(\d+)) -->)(.+)/$1\n$5/;
        $line =~ s/(.+)(<!-- ${tex_extension}_end $basename ((\w+ |)(\d+)) -->) *$/$1\n$2/;
      }
      print FINAL "$line";
   }
   close ORIG;
   close FINAL;
   return 1;
}

sub mediawiki_default_html_to_wiki
{
  foreach my $file (@html_files_from_tex)
  {
     if (-f $mediawiki_out_dir.$file)
     {
        my $html_file = $mediawiki_out_dir.$file;
        my $tmp_file = $mediawiki_out_dir.$file.".tmp";
        my $tmp_file2 = $mediawiki_out_dir.$file.".tmp2";
        my $tmp_file3 = $mediawiki_out_dir.$file.".tmp3";
        my $basename = $file;
        $basename =~ s/\.html$//;
        if (!rename ($html_file, $tmp_file))
        {
           print STDERR "rename $html_file $tmp_file error: $!\n";
           return;
        }
        #system ("cp $tmp_file $tmp_file.save");
        # Add a paragraph between the end and begin comments to force
        # html2wiki to leave them appart.
        return unless (mediawiki_default_readd_end_of_lines($tmp_file, $tmp_file3, $tex_extension, $basename, 1));
        if (!rename ($tmp_file3, $tmp_file))
        {
           print STDERR "rename $tmp_file3 $tmp_file error: $!\n";
           return;
        }
        #system ("cp $tmp_file $tmp_file3.save");
        my $cmd = "html2wiki --dialect MediaWiki --strip-tags '' $tmp_file > $tmp_file2";
        print STDERR "Launching(". Cwd::cwd() ."): $cmd\n" if (get_conf('VERBOSE'));
        if (system ($cmd))
        {
           main::document_warn ("mediawiki_tex command failed: $cmd");
           return;
        }
        # this ensures that there is one end of line before the 
        # html comment, and after, even though html2wiki removed them
        return unless (mediawiki_default_readd_end_of_lines($tmp_file2, $html_file, $tex_extension, $basename));
        #system ("cp $html_file $html_file.save");
     }
     else
     { # FIXME error message?
     }
  }
}

$heading_text                 = \&mediawiki_heading_text;

sub mediawiki_heading_text($$$)
{
    my $command = shift;
    my $text = shift;
    my $level = shift;

    return '' if ($text !~ /\S/);
    $level = 1 if ($level == 0);
    return (("=" x $level) . "= $text =" . ("=" x $level) . "\n");
}

###################################################################
# Layout of standard header and footer
#

$print_page_head	      = \&mediawiki_default_print_page_head;
$print_page_foot	      = \&mediawiki_default_print_page_foot;

sub mediawiki_default_print_page_head($)
{
    my $fh = shift;
    print $fh "$AFTER_BODY_OPEN\n" if $AFTER_BODY_OPEN;
}

sub mediawiki_default_print_page_foot($)
{
    my $fh = shift;
    my $program_string = &$program_string();
    print $fh $program_string, "\n";
    print $fh $PRE_BODY_CLOSE, "\n" if $PRE_BODY_CLOSE;
}

# This function produces an anchor 
#
# arguments:
# $name           :   anchor name
# $href           :   anchor href
# $text           :   text displayed
# extra_attribs   :   added to anchor attributes list

$anchor = \&mediawiki_anchor;

sub mediawiki_anchor($;$$$)
{
    my $name = shift;
    my $href = shift;
    my $text = shift;
    my $attributes = shift; # ignored
    $href = '' if !defined $href or $href !~ /\S/;
    $text = '' if !defined $text or $text !~ /\S/;
    return $text if $name eq '' and $href eq '';
    $name = "<div id=\"$name\"></div>" if $name ne '';
    if (defined($href) and $href ne '')
    {
        my $wiki_href;
        my ($file, $target);

        if ($href =~ /^([^#]*)\#(.+)$/)
        {
            $file = $1;
            $target = $2;

            if (defined($mediawiki_target_to_name{$target}))
            {
                if ($file eq '')
                {
                    $target = $mediawiki_target_to_name{$target}->[0]->[1]->{'simple_format'}
                      if ($mediawiki_target_to_name{$target}->[0]->[1]->{'simple_format'} ne '');
                    $wiki_href = '#' . $target;
                }
                else
                {
                    foreach my $element (@{$mediawiki_target_to_name{$target}})
                    {
                        if ($file eq $element->[0])
                        {
                             $target = $element->[1]->{'simple_format'} if ($element->[1]->{'simple_format'} ne '');
                             $wiki_href = $file . '#' . $target;
                        }
                    }
                }
            }
            
            # Element pages, or misc relative links.
            # mediawiki 1.15.1 doesn't like anchor only urls, they work as wiki_ref.
            if (!defined($wiki_href) and ($mediawiki_special_file_name{$file} or $file eq ''))
            {
                $wiki_href = $href;
            }
        }
        # Element page, no target
        elsif ($mediawiki_special_file_name{$href})
        {
            $file = $href;
            $wiki_href = $href;
        }
        if (defined($wiki_href))
        {
	    $text = "|$text" if $text;
            # FIXME trouble with http://meta.wikimedia.org/wiki/Help:Namespace#Generic_namespace_names
            # and with http://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(technical_restrictions)#Forbidden_characters
            
    	    $href = "[[$wiki_href$text]]";
        }
        else
        {
	    $text = " $text" if $text;
    	    $href = "[$href$text]";
        }
    }
    else
    {
    	$href = $text;
    }
#print STDERR "!!!$name!$href!$text!$attributes!\n";
    return "$name$href";
}

# it is not possible (at least not easy) to protect only 2 consecutive
# {, although it would be better.
foreach my $brace ('{', '}')
{
   $simple_map{$brace} = "<nowiki>$simple_map{$brace}</nowiki>";
   $simple_map_pre{$brace} = "<nowiki>$simple_map_pre{$brace}</nowiki>";
}

# remark: this nullifies the change of default_load_tex_math for normal_text.
# We assume that in @math the TeX characters have already been 
# rightly protected and so don't protect once more. This is important
# for <, not to lead to &lt;.
# remark: texvc doesn't accept " \&
$normal_text = \&mediawiki_default_normal_text;
sub mediawiki_default_normal_text($$$$$$$;$)
{
   my @initial_args = @_;
   my $text = shift;
   my $in_raw_text = shift; # remove_texi
   my $in_preformatted = shift;
   my $in_code = shift;
   my $in_math = shift;
   my $in_simple = shift;
   my $style_stack = shift;
   my $state = shift;

   if ($in_math)
   {
       $text = uc($text) if (in_cmd($style_stack, 'sc'));
       return $text;
   }
   $text = &html_default_normal_text (@initial_args);
   my $colon = '';
   foreach my $command (@$style_stack)
   {
      if ($mediawiki_table_commands{$command} or $def_map{$command})
      {
          $colon = '|( :)' ;
          last;
      }
      #print STDERR "$command\n";
   }
   # '' is changed to &ldsquo; so it doesn't needs to be protected in
   # normal text...
   if (!$in_raw_text and !$in_simple)
   {
        $text =~ s/(([\[\]]|[']{2,}|(\{\{)|(\}\})$colon)+)/<nowiki>$1<\/nowiki>/g;
   }
   return $text;
}

#$heading = \&mediawiki_default_heading;
sub mediawiki_default_heading($$$$$;$$)
{
    my $element = shift;
    my $command = shift;
    my $texi_line = shift;
    my $line = shift;
    my $in_preformatted = shift;
    my $one_section = shift;
    my $element_heading = shift;

    my $result = t2h_default_heading($element, $command, $texi_line, $line,
      $in_preformatted, $one_section, $element_heading);
    if ($result ne '')
    {
        if ($element->{'no_texi'} =~ /[\#<>\[\]|{}]/)
        {
            main::msg_warn("# < > [ ] | { } not allowed in title `$element->{'texi'}'",$element->{'line_nr'});
        }
    }
    return $result;
}
# This function formats a footnote reference and the footnote text associated
# with a given footnote.
# The footnote reference is the text appearing in the main document pointing
# to the footnote text.
#
# arguments:
# absolute number of the footnote (in the document)
# relative number of the footnote (in the page)
# identifier for the footnote
# identifier for the footnote reference in the main document
# main document file
# footnote text file
# array with the footnote text lines 
# the state. See menu entry.
#
# returns:
# reference on an array containing the footnote text lines which should
#     have been updated
# the text for the reference pointing on the footnote text

# FIXME the <ref>... stuff is only available with the Cite extension.

$foot_line_and_ref = \&mediawiki_default_foot_line_and_ref;
$foot_section      = \&mediawiki_default_foot_section;

sub mediawiki_default_foot_line_and_ref($$$$$$$)
{
    my $number_in_doc = shift;
    my $number_in_page = shift;
    my $footnote_id = shift;
    my $place_id = shift;
    my $document_file = shift;
    my $footnote_file = shift;
    my $lines = shift;
    my $state = shift;
    
    my $result = '<ref>';
    foreach my $line (@$lines)
    {
       $result .= $line;
    }
    # The result shouldn't be empty, such that the call to print_Footnotes
    # and foot_section are not skipped
    return ([' '], $result . '</ref>');
}

# formats a group of footnotes.
#
# argument:
# array reference on the footnotes texts lines 
#
# returns an array reference on the group of footnotes lines
# FIXME maybe do a header?
sub mediawiki_default_foot_section($)
{
    my $lines = shift;
    #unshift @$lines, "$DEFAULT_RULE\n" if $DEFAULT_RULE;
    #unshift @$lines, "==== " . gdt('Footnotes') . " ====\n";
    @$lines = ("<references/>\n\n");
    return $lines; 
}

# FIXME maybe also a header here?
$print_Footnotes = \&mediawiki_default_print_Footnotes;
sub mediawiki_default_print_Footnotes
{
   my $fh = shift;
   my $new_file = shift;
   my $misc_page = shift;
   my $buttons = \@MISC_BUTTONS;

   &$print_misc_header($fh, $buttons, $new_file, $misc_page) if ($new_file);
   print $fh "<references/>\n\n";
   &$print_misc_footer($fh, $buttons, $new_file) if ($new_file);
}

$button_formatting	      = \&mediawiki_button_formatting;

sub mediawiki_button_formatting
{
   my $button = shift;
   my $vertical = shift;
   my ($active, $passive) = HTML_DEFAULT_button_formatting($button, $vertical);
   if (defined($active) and !ref($button))
   {
      $active =~ s/^\[/\|/;
      $active =~ s/\]$/\|/;
   }
   return ($active, $passive);
}

$element_file_name = \&mediawiki_element_file_name;

sub mediawiki_element_file_name
{
    my $element = shift;
    my $type = shift;
    my $docu_name = shift;
    my $file;
#print STDERR "!$element!$type!$docu_name!\n";

    if (!$element)
    {
	if ($type =~ /^toc$/)
	{
	    $file = $docu_name . ": Table of Contents";
	}
	elsif ($type =~ /^stoc$/)
	{
	    $file = $docu_name . ": Short Table of Contents";
	}
	elsif ($type =~ /^foot$/)
	{
	    $file = $docu_name . ": Footnotes";
	}
	elsif ($type =~ /^about$/)
	{
	    $file = $docu_name . ": About this Manual";
	}
	elsif ($type =~ /^doc$/)
	{
	    $file = $docu_name;
	}
    }
    else
    {
        my $name = main::substitute_line($element->{'texi'}, 'file name', {'remove_texi' => 1}, $element->{'line_nr'});
        if (exists $mediawiki_doc_nr_to_file{$element->{'doc_nr'}})
        {
	    $file = $mediawiki_doc_nr_to_file{$element->{'doc_nr'}};
	    $mediawiki_doc_nr_to_file{$element->{'doc_nr'}} = $file;
        }
        else
        {
	    $name =~ s,/,%47,g;
	    $name =~ s,\\,%92,g;
	    $file = "$docu_name" . (($type eq 'top') ? "" : ": " . $name);
	    $mediawiki_doc_nr_to_file{$element->{'doc_nr'}} = $file;
        }
        push @{$mediawiki_target_to_name{$element->{'target'}}}, [ $file, $element ];
        if ($name =~ /[\#<>\[\]|{}]/)
        {
            main::msg_warn("# < > [ ] | { } not allowed in title `$element->{'texi'}'",$element->{'line_nr'});
        }
    }
    $mediawiki_special_file_name{$file} = 1;
    return $file;
}

$node_file_name = \&mediawiki_default_node_file_name;
sub mediawiki_default_node_file_name($$)
{
    my $node = shift;
    my $type = shift;
    my $filename = T2H_DEFAULT_node_file_name($node, $type);
    my $command = 'node';
    $command = $node->{'tag'};
    my $name = main::substitute_line($node->{'texi'}, 'node name', {'remove_texi' => 1}, $node->{'line_nr'});
    if ($name =~ /[\#<>\[\]|{}]/)
    {
        main::msg_warn("# < > [ ] | { } not allowed in references, in \@$command `$node->{'texi'}'",$node->{'line_nr'});
    }
    
    return $filename;
}

# a preformatted region
# arguments:
# $text of the preformatted region
# $pre_style css style
# $class identifier for the preformatted region (example, menu-comment)
# The following is usefull if the preformatted is in an itemize.
# $leading_command is the leading formatting command (like @minus)
# $leading_command_formatted is the leading formatting command formatted
# $preformatted_number is a reference on the number of preformatteds appearing
#    in the format. The value should be increased if a preformatted is done
$preformatted      = \&mediawiki_default_preformatted;
sub mediawiki_default_preformatted($$$$$$$$$$)
{
    my $text = shift;
    my $pre_style = shift;
    my $class = shift;
    my $leading_command = shift;
    my $leading_command_formatted = shift;
    my $preformatted_number = shift;
    my $format = shift;
    my $item_nr = shift;
    my $enumerate_style = shift;
    my $number = shift;
    my $command_stack_at_end = shift;
    my $command_stack_at_begin = shift;

    return '' if ($text eq '');
    $leading_command_formatted = '' if (!defined($leading_command_formatted) or 
          exists($special_list_commands{$format}->{$leading_command}));
    if (defined($preformatted_number) and defined($$preformatted_number))
    {
        $$preformatted_number++;
    }

    my $top_stack = '';
    $top_stack = $command_stack_at_begin->[-1] if (scalar (@$command_stack_at_begin));
    if ($top_stack eq 'multitable')
    {
       $text =~ s/^\s*//;
       $text =~ s/\s*$//;
    }

    $text =~ s/^/ /mg;
   # return html_default_attribute_class('div', $class).">\n$text</div>\n";
    return "$text";
    #return "<pre class=\"$class\"><nowiki>$text</nowiki></pre>";
}

sub mediawiki_default_remove_eol($)
{
   my $text = shift;
   chomp($text);
   my $res = '';
   foreach my $line (split /\n/, $text)
   {
      $res .= $line . " ";
   }
   $res =~ s/ $//;
   $res .= "\n";
   return $res;
}

my %mediawiki_default_indent_symbol = (
  'itemize' => '*',
  'enumerate' => '#'
);
foreach my $table ('table', 'ftable', 'vtable')
{
   $mediawiki_default_indent_symbol{$table} = ':';
   $mediawiki_table_commands{$table} = 1;
}
foreach my $definition_command (keys(%def_map))
{
   $mediawiki_default_indent_symbol{$definition_command} = ':';
}

sub mediawiki_default_indent_string($;$)
{
   my $commands = shift;
   my $remove_last = shift;

   $commands = $Texi2HTML::THISDOC{'command_stack'} if (!defined($commands));
   my $indent_string = '';
   foreach my $format (@$commands)
   {
      $indent_string .= $mediawiki_default_indent_symbol{$format} 
         if defined($mediawiki_default_indent_symbol{$format});
   }
   $indent_string =~ s/.$// if ($remove_last);
   return $indent_string;
}

$paragraph      = \&mediawiki_default_paragraph;
sub mediawiki_default_paragraph($$$$$$$$$$$$)
{
    my $text = shift;
    my $align = shift;
    my $indent = shift;
    my $paragraph_command = shift;
    my $paragraph_command_formatted = shift;
    my $paragraph_number = shift;
    my $format = shift;
    my $item_nr = shift;
    my $enumerate_style = shift;
    my $number = shift;
    my $command_stack_at_end = shift;
    my $command_stack_at_begin = shift;
#print STDERR "format: $format\n" if (defined($format));
#print STDERR "paragraph @$command_stack_at_end; @$command_stack_at_begin\n";
#    $paragraph_command_formatted = '' if (!defined($paragraph_command_formatted) or 
#          exists($special_list_commands{$format}->{$paragraph_command}));
    return '' if ($text =~ /^\s*$/);

    if (defined($paragraph_number) and defined($$paragraph_number))
    {
         $$paragraph_number++;
    }

    # remove leading spaces, they trigger a preformatted environment in wikitext
    $text =~ s/^\s*//mg;
    my $top_stack = '';
    $top_stack = $command_stack_at_begin->[-1] if (scalar (@$command_stack_at_begin));
    if ($top_stack eq 'multitable')
    {
       $html_default_multitable_stack[-1]->[1]++;
       return mediawiki_default_remove_eol($text);
    }

    if ($align)
    {
        $text = "<p align=\"$paragraph_style{$align}\">".$text.'</p>';
    }

    my $indent_string = mediawiki_default_indent_string($command_stack_at_begin);
    if ($indent_string)
    {
       $text = $indent_string . ' ' .mediawiki_default_remove_eol($text);
    }
    
    return $text;
}

$list_item = \&mediawiki_default_list_item;
sub mediawiki_default_list_item
{
   my $text = shift;
   return $text;
}

$def_item = \&mediawiki_default_def_item;
sub mediawiki_default_def_item($$$)
{
    my $text = shift;
    my $only_inter_item_commands = shift;
    my $command = shift;
    if ($text =~ /\S/)
    {
        if (! get_conf('DEF_TABLE'))
        {
            return $text;# unless $only_inter_item_commands;
            #return $text; # invalid without dd in ul
        }
        else
        {
            return '<tr><td colspan="2">' . $text . '</td></tr>';
        }
    }
    return '';
}

$table_item = \&mediawiki_default_table_item;
sub mediawiki_default_table_item($$$$$$$)
{
    my $text = shift;
    my $index_label = shift;
    my $format = shift;
    my $command = shift;
#    my $formatted_command = shift;
    my $style_stack = shift;
#    my $text_formatted = shift;
#    my $text_formatted_leading_spaces = shift;
#    my $text_formatted_trailing_spaces = shift;
    my $item_cmd = shift;
    my $formatted_index_entry = shift;

#    if (defined($text_formatted) and !exists $special_list_commands{$format}->{$command})
#    {
#        $text = $text_formatted_leading_spaces . $text_formatted .$text_formatted_trailing_spaces;
#    }
#    $formatted_command = '' if (!defined($formatted_command) or 
#          exists($special_list_commands{$format}->{$command}));
    if (html_teletyped_in_stack($style_stack))
    {
#       $text .= '</tt>';
#       $formatted_command = '<tt>' . $formatted_command;
        $text = '<tt>' . $text . '</tt>';
    }
    $text .= "\n" . $index_label  if (defined($index_label));
#    return '<dt>' . $formatted_command . $text . '</dt>' . "\n";
    return mediawiki_default_indent_string(undef,1) .";$text\n";
}

$table_line = \&mediawiki_default_table_line;
sub mediawiki_default_table_line($$$)
{
    my $text = shift;
    my $only_inter_item_commands = shift;
    my $before_items = shift;

    $only_inter_item_commands = '' if (!defined($only_inter_item_commands));

    if ($text =~ /\S/)
    {
        #return ";$text\n";# unless ($only_inter_item_commands);
        return $text;
        #return $text; # invalid without dd in ul
    }
    return '';
}


$def_line = \&mediawiki_default_def_line;
sub mediawiki_default_def_line($$$$$$$$$$$$$$$$)
{
   my $category_prepared = shift;
   my $name = shift;
   my $type = shift;
   my $arguments = shift;
   my $index_label = shift;
   my $arguments_array = shift;
   my $arguments_type_array = shift;
   my $unformatted_arguments_array = shift;
   my $command = shift;
   my $class_name = shift;
   my $category = shift;
   my $class = shift;
   my $style = shift;
   my $original_command = shift;

   $index_label = '' if (!defined($index_label));
   chomp($index_label);
   $category_prepared = '' if (!defined($category_prepared) or ($category_prepared =~ /^\s*$/));
   $name = '' if (!defined($name) or ($name =~ /^\s*$/));
   $type = '' if (!defined($type) or $type =~ /^\s*$/);
   if (!defined($arguments) or $arguments =~ /^\s*$/)
   {
       $arguments = '';
   }
   else
   {
       chomp ($arguments);
       $arguments = '<em>' . $arguments . '</em>';
   }
   my $type_name = '';
   $type_name = " <em>$type</em>" if ($type ne '');
   $type_name .= ' <strong>' . $name . '</strong>' if ($name ne '');
   $type_name .= $arguments;
   if (! get_conf('DEF_TABLE'))
   {
       return mediawiki_default_indent_string(undef,1) .';'. $index_label. $category_prepared . '<nowiki>:</nowiki>' . $type_name . "\n";
   }
   else
   {
       return "<tr><td align=\"left\">" . $type_name .
       "</td><td align=\"right\">" . $category_prepared . $index_label . "</td></tr>\n";
   }
}


$def = \&mediawiki_default_def;
sub mediawiki_default_def($$)
{
    my $text = shift;
    my $command = shift;
    if ($text =~ /\S/)
    {
        if (! get_conf('DEF_TABLE'))
        {
            return $text;
        }
        else
        {
            return "<table width=\"100%\">\n" . $text . "</table>\n";
        }
    }
    return '';

}



$table_list = \&mediawiki_default_table_list;

sub mediawiki_default_table_list($$$$$$$$$)
{
    my $format_command = shift;
    my $text = shift;
    my $command = shift;
    my $formatted_command = shift;
# enumerate
    my $item_nr = shift;
    my $enumerate_style = shift;
# itemize
    my $prepended = shift;
    my $prepended_formatted = shift;
# multitable
    my $columnfractions = shift;
    my $prototype_row = shift;
    my $prototype_lengths = shift;
    my $column_number = shift;

    if ($format_command eq 'multitable')
    {
        pop @html_default_multitable_stack;
        return &$format('multitable', 'table', $text);
    }
    return $text;
}

# format an index summary. This is a list of letters linking to the letter
# entries.
#
# arguments:
# array reference containing the formatted alphabetical letters
# array reference containing the formatted non lphabetical letters
$index_summary     = \&mediawiki_index_summary;
sub mediawiki_index_summary($$)
{
    my $alpha = shift;
    my $nonalpha = shift;
    my $join = '';
    my $nonalpha_text = '';
    my $alpha_text = '';
    return "" if !@$nonalpha and !@$alpha;
    $nonalpha_text = join ("", map {"<td>$_</td>"} @$nonalpha) . "\n"
	if @$nonalpha;
    $alpha_text = join ("", @$alpha) . "\n &nbsp; \n"
	if @$alpha;
    return '<table cellpadding="1" cellspacing="1" border="0">'
	   . "<tr><th valign=\"top\">" . gdt('Jump to') .":</th>\n"
    	   . join ("", map {"<td>$_</td>\n"} @$nonalpha, @$alpha)
	   . "</tr></table>\n";
}

$line_command = \&mediawiki_line_command;

sub mediawiki_line_command($$$$)
{
    my $command = shift;
    my $arg_text = shift;
    my $arg_texi = shift;
    my $state = shift;

    return '' if ($arg_text eq '' or ($command eq 'author' and (!$state->{'region'} or $state->{'region'} ne 'titlepage')));
    if ($command eq 'title')
    {
        $arg_text = '== ' .$arg_text. " ==\n";
    }
    elsif ($command eq 'subtitle')
    {
        $arg_text = '=== ' .$arg_text. " ===\n";
    }
    elsif ($command eq 'author')
    {
        $arg_text = '<strong> ' .$arg_text. " </strong><br>\n";
    }
    return $arg_text;
}

$image = \&mediawiki_default_image;

sub mediawiki_default_image($$$$$$$$$$$$$$$$$)
{
    my $file = shift;
    my $base = shift;
    my $preformatted = shift;
    my $file_name = shift;
    my $alt = shift;
    my $width = shift;
    my $height = shift;
    my $raw_alt = shift;
    my $extension = shift;
    my $working_dir = shift;
    my $file_path = shift;
    my $in_paragraph = shift;
    my $file_locations = shift;
    my $base_simple_format = shift;
    my $extension_simple_format = shift;
    my $file_name_simple_format = shift;
    my $line_nr = shift;

    if (!defined($file_path) or $file_path eq '')
    {
        if (defined($extension) and $extension ne '')
        {
            $file = "$base.$extension";
        }
        else
        {
            $file = "$base.jpg";
        }
        main::line_warn (sprintf(__("\@image file `%s' not found, using `%s'"), $base, $file), $line_nr);
    }
    elsif (! get_conf('COMPLETE_IMAGE_PATHS'))
    {
        $file = $file_name;
    }
    my $alt_text = '';
    $alt_text = "|alt=$alt" if (defined($alt) and $alt ne '');
    # it is possible that $file_name is more correct as it allows the user
    # to chose the relative path.
    $file = &$protect_text($file);
    return "[[Image:$file$alt_text]]";
}

# FIXME <math> in mediawiki is only valid for one formula, not for 
# random TeX. 
# One possibility could be to use TeX -> html -> html2wiki
#$raw = \&mediawiki_default_raw;
sub mediawiki_default_raw($$;$)
{
    my $style = shift;
    my $text = shift;
    my $line_nr = shift;
    my $expanded = 1 if (grep {$style eq $_} @EXPAND);
    if ($style eq 'verbatim' or $style eq 'verbatiminclude')
    {
        $style = 'verbatim' if ($style eq 'verbatiminclude');
        return html_default_attribute_class('pre', $style).">" . &$protect_text($text) . '</pre>';
    }
    elsif ($style eq 'html' and $expanded)
    {
        chomp ($text);
        return $text;
    }
    elsif ($style eq 'tex' and $expanded)
    {
        chomp ($text);
        return "<math>$text</math>\n";
    }
    elsif ($expanded)
    {
        main::line_warn (sprintf(__("Raw format %s is not converted"), $style), $line_nr);
        return &$protect_text($text);
    }
    else
    {
        return '';
    }
}


## a simple menu entry ref in case we aren't in a standard menu context
#$simple_menu_link  = \&mediawiki_simple_menu_link;

# a menu link. We are always in preformatted because of SIMPLE_MENU.
# currently not used.
#$menu_link  = \&mediawiki_simple_menu_link;

sub mediawiki_simple_menu_link($$$$$$$)
{
    my $entry = shift;
#    my $preformatted = shift; # We assume this is true.
    my $state = shift;
    my $href = shift;
    my $node = shift;
    my $title = shift;
    my $ending = shift;
    my $has_title = shift;
    my $command_stack = shift;
    my $preformatted = shift;

    $title = '' unless ($has_title);
    $ending = '' unless defined $ending;
    $entry = "</nowiki>";
    $entry .= "$MENU_SYMBOL";
    if ($href)
    {
	$entry .= &$anchor ('', $href, $node);
    }
    else
    {
	$title .= ":" if ($title ne '');
	$entry .= "$title$node";
    }
    $entry .= $ending;
    $entry .= "<nowiki>";
    return $entry;
}

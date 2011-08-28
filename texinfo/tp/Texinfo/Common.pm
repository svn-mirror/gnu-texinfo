# Common.pm: definition of commands. Common code of other Texinfo modules.
#
# Copyright 2010, 2011 Free Software Foundation, Inc.
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License,
# or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# Original author: Patrice Dumas <pertusus@free.fr>
# Parts (also from Patrice Dumas) come from texi2html.pl or texi2html.init.

package Texinfo::Common;

use strict;

# for unicode/layer support in binmode
use 5.006;

# to determine the null file
use Config;
use File::Spec;

use Encode;

use Texinfo::Documentlanguages;

require Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration       use Texinfo::Covert::Text ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
%EXPORT_TAGS = ( 'all' => [ qw(
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = qw(
);

$VERSION = '0.01';

# i18n
sub N__($)
{
  return $_[0];
}

# determine the null devices
my $default_null_device = File::Spec->devnull();
our %null_device_file = (
  $default_null_device => 1
);
# special case, djgpp recognizes both null devices
if ($Config{osname} eq 'dos' and $Config{osvers} eq 'djgpp') {
  $null_device_file{'/dev/null'} = 1;
  $null_device_file{'NUL'} = 1;
}

# configuration options
my @document_settable_at_commands =
       ('everyheading', 'everyfooting', 'evenheading',
        'evenfooting', 'oddheading', 'oddfooting', 'headings',
        'allowcodebreaks', 'frenchspacing', 'exampleindent',
        'firstparagraphindent', 'paragraphindent', 'clickstyle',
        'documentlanguage');

# those should be unique
my @document_global_at_commands = ('contents', 'shortcontents',
        'setcontentsaftertitlepage', 'setshortcontentsaftertitlepage',
        'footnotestyle', 'novalidate', 'kbdinputstyle', 'documentencoding',
        'setfilename', 'today', 'documentdescription',
        'everyheadingmarks','everyfootingmarks',
        'evenheadingmarks','oddheadingmarks','evenfootingmarks','oddfootingmarks',
        'fonttextsize', 'pagesizes', 'setchapternewpage'
        );


my @command_line_settables = ('FILLCOLUMN', 'SPLIT', 'SPLIT_SIZE',
  'HEADERS',
  'MACRO_EXPAND', 'NUMBER_SECTIONS',
  'NUMBER_FOOTNOTES', 'NODE_FILES',
  'NO_WARN', 'VERBOSE',
  'TRANSLITERATE_FILE_NAMES', 'ERROR_LIMIT', 'ENABLE_ENCODING',
  'FORCE', 'INTERNAL_LINKS', 'OUTFILE', 'SUBDIR', 'OUT',
  'BATCH', 'SILENT'
);

# FIXME TOP_HEADING_AT_BEGINNING seems to be a no-op
# FIXME USE_SECTIONS is now a no-op, there are only two possibilities, 
# USE_NODES set or not.
my @variable_settables = (
  'DEBUG', 'FRAMES', 'FRAMESET_DOCTYPE', 'DOCTYPE', 'TEST', 'DUMP_TEXI',
  'TOP_FILE', 'TOC_FILE', 'SHOW_MENU', 'USE_NODES', 'TOC_LINKS', 'SHORTEXTN',
  'PREFIX', 'SHORT_REF', 'IDX_SUMMARY', 'DEF_TABLE', 'L2H', 'MONOLITHIC',
  'L2H_L2H', 'L2H_SKIP', 'L2H_TMP', 'L2H_FILE', 'L2H_CLEAN',
  'L2H_HTML_VERSION', 'IGNORE_PREAMBLE_TEXT', 'EXTERNAL_DIR', 'USE_ISO',
  'SPLIT_INDEX', 'IN_ENCODING', 'USE_NLS',
  'VERTICAL_HEAD_NAVIGATION', 'INLINE_CONTENTS', 'NODE_FILE_EXTENSION',
  'NO_CSS', 'INLINE_CSS_STYLE', 'USE_SECTIONS', 'USE_TITLEPAGE_FOR_TITLE',
  'SIMPLE_MENU', 'EXTENSION', 'INLINE_INSERTCOPYING', 'USE_NUMERIC_ENTITY',
  'I18N_PERL_HASH', 'ENABLE_ENCODING_USE_ENTITY', 'ICONS', 'USE_UNICODE',
  'USE_UNIDECODE', 'DATE_IN_HEADER', 'OPEN_QUOTE_SYMBOL',
  'CLOSE_QUOTE_SYMBOL', 'TOP_NODE_UP', 'TOP_NODE_UP_URL', 'TOP_NODE_FILE',
  'TOP_NODE_FILE_TARGET', 'SHOW_TITLE', 'WORDS_IN_PAGE',
  'HEADER_IN_TABLE', 'USE_ACCESSKEY', 'USE_REL_REV', 'USE_LINKS',
  'OVERVIEW_LINK_TO_TOC', 'AVOID_MENU_REDUNDANCY', 'NODE_NAME_IN_MENU',
  'NODE_NAME_IN_INDEX', 'NO_USE_SETFILENAME', 'USE_SETFILENAME_EXTENSION',
  'COMPLEX_FORMAT_IN_TABLE',
  'USE_UP_FOR_ADJACENT_NODES', 'TOP_HEADING_AT_BEGINNING',
  'SEPARATE_DESCRIPTION', 'IGNORE_BEFORE_SETFILENAME',
  'COMPLETE_IMAGE_PATHS', 'USE_NODE_TARGET', 'NEW_CROSSREF_STYLE',
  'PROGRAM_NAME_IN_FOOTER', 'NODE_FILENAMES', 'DEFAULT_ENCODING',
  'OUT_ENCODING', 'ENCODING_NAME', 'EXTERNAL_CROSSREF_SPLIT', 'BODYTEXT',
  'CSS_LINES', 'RENAMED_NODES_REDIRECTIONS', 'RENAMED_NODES_FILE',
  'TEXI2DVI', 'DUMP_TREE', 'MAX_MACRO_CALL_NESTING',
# FIXME new
  'PROGRAM_AND_VERSION', 'PROGRAM_HOMEPAGE', 'PROGRAM',
  'PRE_BODY_CLOSE', 'AFTER_BODY_OPEN', 'PRE_ABOUT', 'AFTER_ABOUT',
  'EXTRA_HEAD', 'LINKS_BUTTONS', 'DO_ABOUT',
  'TOP_BUTTONS', 'SECTION_BUTTONS', 'BUTTONS_TEXT',
  'BUTTONS_ACCESSKEY', 'BUTTONS_REL', 'BUTTONS_GOTO',
  'CHAPTER_FOOTER_BUTTONS', 'SECTION_FOOTER_BUTTONS', 
  'NODE_FOOTER_BUTTONS',
  'MISC_BUTTONS', 'CHAPTER_BUTTONS', 'BUTTONS_NAME',
  'BUTTONS_EXAMPLE', 'SPECIAL_ELEMENTS_NAME',
  'ACTIVE_ICONS', 'PASSIVE_ICONS',
  'DEFAULT_RULE', 'BIG_RULE',
  'MENU_ENTRY_COLON', 'INDEX_ENTRY_COLON', 'MENU_SYMBOL', 'DO_ABOUT',
  'CSS_FILES', 'CSS_REFS');

my %valid_options;
foreach my $var (@document_settable_at_commands, @document_global_at_commands,
         @command_line_settables, @variable_settables) {
  $valid_options{$var} = 1;
}

sub valid_option($)
{
  my $option = shift;
  return $valid_options{$option};
}

our %no_brace_commands;             # commands never taking braces

foreach my $no_brace_command ('*',' ',"\t","\n",'-', '|', '/',':','!',
                              '?','.','@','}','{','\\') {
  $no_brace_commands{$no_brace_command} = 1;
}

# commands taking a line as argument or no argument.
# sectioning commands and def* commands are added below.
# index commands are added dynamically.
#
# The values signification is:
# special:     no value and macro expansion, all the line is used, and 
#              analysed during parsing (_parse_special_misc_command)
# lineraw:     no value and macro expansion, the line is kept as-is, not 
#              analysed
# skipline:    no argument, everything else on the line is skipped
# skipspace:   no argument, following spaces are skipped.
# noarg:       no argument
# text:        the line is parsed as texinfo, and the argument is converted
#              to simple text (in _end_line)
# line:        the line is parsed as texinfo
# a number:    the line is parsed as texinfo and the result should be plain 
#              text maybe followed by a comment; the result is analysed
#              during parsing (_parse_line_command_args).  
#              The number is an indication of the number of arguments of 
#              the command.
#
# Beware that @item and @itemx may be like 'line' or 'skipspace' depending
# on the context.
our %misc_commands = (
  'node'              => 'line', # special arg
  'bye'               => 'skipline', # no arg
  'end'               => 'text',
  # set, clear
  'set'               => 'special', # special arg
  'clear'             => 'special', # special arg
  'unmacro'           => 'special', 
  # comments
  'comment'           => 'lineraw',
  'c'                 => 'lineraw',
  # special
  'definfoenclose'    => 3,
  'alias'             => 2, 
  # number of arguments is not known in advance.
  'columnfractions'   => 1, 
  # file names
  'setfilename'       => 'text',
  'verbatiminclude'   => 'text',
  'include'           => 'text',

  'raisesections'     => 'skipline',  # no arg
  'lowersections'     => 'skipline', # no arg
  'contents'          => 'skipline', # no arg
  'shortcontents'     => 'skipline', # no arg
  'summarycontents'   => 'skipline', # no arg
  'insertcopying'     => 'noarg', # no arg
  'clickstyle'        => 'special', # arg should be an @-command
  # more relevant in preamble
  'setcontentsaftertitlepage'      => 'skipline', # no arg
  'setshortcontentsaftertitlepage' => 'skipline', # no arg
  'documentencoding'  => 'text', # or 1?
  'novalidate'        => 'skipline', # no arg
  'dircategory'       => 'line', # line. Position with regard 
                                 # with direntry is significant
  'pagesizes'         => 'line', # can have 2 args 
                           # or one? 200mm,150mm 11.5in
  'finalout'          => 'skipline', # no arg
  'paragraphindent'   => 1, # arg none asis 
                       # or a number and forbids anything else on the line
  'firstparagraphindent' => 1, # none insert
  'frenchspacing'     => 1, # on off
  'codequoteundirected'       => 1, # on off
  'codequotebacktick'         => 1, # on off
  'xrefautomaticsectiontitle' => 1, # on off
  'fonttextsize'      => 1, # 10 11
  'allowcodebreaks'   => 1, # false or true
  'exampleindent'     => 1, # asis or a number
  'footnotestyle'     => 1, # end and separate, nothing else on the line
  'urefbreakstyle'    => 1, # after|before|none
  'afourpaper'        => 'skipline', # no arg
  'afivepaper'        => 'skipline', # no arg
  'afourlatex'        => 'skipline', # no arg
  'afourwide'         => 'skipline', # no arg
  'headings'          => 1, #off on single double singleafter doubleafter
                            # interacts with setchapternewpage
  'setchapternewpage' => 1, # off on odd

  # only relevant in TeX, and special
  'everyheading'      => 'lineraw',  # @*heading @*footing use @|
  'everyfooting'      => 'lineraw',  # + @thispage @thissectionname
  'evenheading'       => 'lineraw',  # @thissectionnum @thissection
  'evenfooting'       => 'lineraw',  # @thischaptername @thischapternum
  'oddheading'        => 'lineraw',  # @thischapter @thistitle @thisfile
  'oddfooting'        => 'lineraw',

  'smallbook'         => 'skipline', # no arg
  'syncodeindex'      => 2,   # args are index identifiers
  'synindex'          => 2,
  'defindex'          => 1, # one identifier arg
  'defcodeindex'      => 1, # one identifier arg
  'documentlanguage'  => 'text',     # language code arg
  'kbdinputstyle'     => 1,          # code example distinct
  'everyheadingmarks' => 1, # top bottom
  'everyfootingmarks' => 1,
  'evenheadingmarks'  => 1,
  'oddheadingmarks'   => 1,
  'evenfootingmarks'  => 1,
  'oddfootingmarks'   => 1,
  # not valid for info (should be in @iftex)
  'cropmarks'         => 'skipline', # no arg

  # formatting
  'center'            => 'line',
  'printindex'        => 1,
  'listoffloats'      => 'line',
  # especially in titlepage
  'shorttitle'        => 'line',
  'shorttitlepage'    => 'line',
  'settitle'          => 'line',
  'author'            => 'line',
  'subtitle'          => 'line',
  'title'             => 'line',
  'sp'                => 1, # numerical arg
  'page'              => 'skipline', # no arg (pagebreak)
  'need'              => 1, # one numerical/real arg
  # formatting
  'noindent'          => 'skipspace', # no arg
  'indent'            => 'skipspace',
  'exdent'            => 'line',
  'headitem'          => 'skipspace',
  'item'              => 'skipspace', # or line, depending on the context
  'itemx'             => 'skipspace',
  'tab'               => 'skipspace', 
  # only valid in heading or footing
  'thischapter'       => 'noarg',
  'thischaptername'   => 'noarg',
  'thischapternum'    => 'noarg',
  'thisfile'          => 'noarg',
  'thispage'          => 'noarg',
  'thistitle'         => 'noarg',
  # not valid for info (should be in @iftex)
  'vskip'             => 'lineraw', # arg line in TeX
  # obsolete @-commands.
  'refill'            => 'noarg',   # no arg (obsolete, to be ignored)
  # Remove spaces and end of lines after the 
  # commands? If no, they can lead to empty lines
  'quote-arg'         => 'skipline',
  'allow-recursion'   => 'skipline',
);

# key is index name, keys of the reference value are the prefixes.
# value associated with the prefix is 0 if the prefix is not a code-like
# prefix, 1 if it is a code-like prefix (set by defcodeindex/syncodeindex).
our %index_names = (
 'cp' => {'cp' => 0, 'c' => 0},
 'fn' => {'fn' => 1, 'f' => 1},
 'vr' => {'vr' => 1, 'v' => 1},
 'ky' => {'ky' => 1, 'k' => 1},
 'pg' => {'pg' => 1, 'p' => 1},
 'tp' => {'tp' => 1, 't' => 1}
);

our %default_index_commands;
# all the commands are readded dynamically in the Parser.
foreach my $index_name (keys (%index_names)) {
  foreach my $index_prefix (keys (%{$index_names{$index_name}})) {
    next if ($index_prefix eq $index_name);
    # only put the one letter versions in the hash.
    $misc_commands{$index_prefix.'index'} = 'line';
    $default_index_commands{$index_prefix.'index'} = 1;
  }
}

# command with braces. Value is the max number of arguments.
our %brace_commands;    

our %letter_no_arg_commands;
foreach my $letter_no_arg_command ('aa','AA','ae','oe','AE','OE','o','O',
                                   'ss','l','L','DH','dh','TH','th') {
  $letter_no_arg_commands{$letter_no_arg_command} = 1;
  $brace_commands{$letter_no_arg_command} = 0;
}

foreach my $no_arg_command ('TeX','LaTeX','bullet','copyright',
  'registeredsymbol','dots','enddots','equiv','error','expansion','arrow',
  'minus','point','print','result','today',
  'exclamdown','questiondown','pounds','ordf','ordm','comma','euro',
  'geq','leq','tie','textdegree','click',
  'quotedblleft','quotedblright','quoteleft','quoteright','quotedblbase',
  'quotesinglbase','guillemetleft','guillemetright','guillemotleft',
  'guillemotright','guilsinglleft','guilsinglright') {
  $brace_commands{$no_arg_command} = 0;
}

# accent commands. They may be called with and without braces.
our %accent_commands;
foreach my $accent_command ('"','~','^','`',"'",',','=',
                           'ringaccent','H','dotaccent','u','ubaraccent',
                           'udotaccent','v','ogonek','tieaccent', 'dotless') {
  $accent_commands{$accent_command} = 1;
  $brace_commands{$accent_command} = 1;
}

our %style_commands;
foreach my $style_command ('asis','b','cite','clicksequence',
  'dfn', 'emph',
  'i', 'sc', 't', 'r', 'slanted', 'sansserif', 'var',
  'headitemfont', 'code', 'command', 'env', 'file', 'kbd',
  'option', 'samp', 'strong') {
  $brace_commands{$style_command} = 1;
  $style_commands{$style_command} = 1;
}

foreach my $one_arg_command (
  'ctrl','dmn', 'w', 'key',
  'titlefont','hyphenation','anchor') {
  $brace_commands{$one_arg_command} = 1;
}

our %code_style_commands;
foreach my $command ('code', 'command', 'env', 'file', 'kbd', 'key', 'option',
   'samp', 'indicateurl', 'verb') {
  $code_style_commands{$command} = 1;
  $brace_commands{$command} = 1;
}


# Commands that enclose full texts
our %context_brace_commands;
foreach my $context_brace_command ('footnote', 'caption', 'shortcaption', 'math') {
  $context_brace_commands{$context_brace_command} = $context_brace_command;
  $brace_commands{$context_brace_command} = 1;
}

foreach my $two_arg_command('email','acronym','abbr') {
  $brace_commands{$two_arg_command} = 2;
}

foreach my $three_arg_command('uref','url','inforef') {
  $brace_commands{$three_arg_command} = 3;
}

foreach my $five_arg_command('xref','ref','pxref','image') {
  $brace_commands{$five_arg_command} = 5;
}


# some classification to help converters
our %ref_commands;
foreach my $ref_command ('xref','ref','pxref','inforef') {
  $ref_commands{$ref_command} = 1;
}

our %explained_commands;
foreach my $explained_command ('abbr', 'acronym') {
  $explained_commands{$explained_command} = 1;
}

our %in_heading_commands;
foreach my $in_heading_command ('thischapter', 'thischaptername',
  'thischapternum', 'thisfile', 'thispage', 'thistitle') {
  $in_heading_commands{$in_heading_command} = 1;
}

# commands delimiting blocks, with an @end.
# Value is either the number of arguments on the line separated by
# commas or the type of command, 'raw', 'def' or 'multitable'.
our %block_commands;

# commands that have a possible content before an item
our %block_item_commands;

# commands that forces closing an opened paragraph.
our %close_paragraph_commands;

$close_paragraph_commands{'exdent'} = 1;

our %def_map = (
    # basic commands. 
    # 'arg' and 'argtype' are for everything appearing after the other
    # arguments.
    'deffn',     [ 'category', 'name', 'arg' ],
    'defvr',     [ 'category', 'name' ],
    'deftypefn', [ 'category', 'type', 'name', 'argtype' ],
    'deftypeop', [ 'category', 'class' , 'type', 'name', 'argtype' ],
    'deftypevr', [ 'category', 'type', 'name' ],
    'defcv',     [ 'category', 'class' , 'name' ],
    'deftypecv', [ 'category', 'class' , 'type', 'name' ],
    'defop',     [ 'category', 'class' , 'name', 'arg' ],
    'deftp',     [ 'category', 'name', 'argtype' ],
    # shortcuts
    # FIXME i18n
    'defun',         {'deffn'     => 'Function'},
    'defmac',        {'deffn'     => 'Macro'},
    'defspec',       {'deffn'     => '{Special Form}'},
    'defvar',        {'defvr'     => 'Variable'},
    'defopt',        {'defvr'     => '{User Option}'},
    'deftypefun',    {'deftypefn' => 'Function'},
    'deftypevar',    {'deftypevr' => 'Variable'},
    'defivar',       {'defcv'     => '{Instance Variable}'},
    'deftypeivar',   {'deftypecv' => '{Instance Variable}'},
    'defmethod',     {'defop'     => 'Method'},
    'deftypemethod', {'deftypeop' => 'Method'},
);

# the type of index, f: function, v: variable, t: type
my %index_type_def = (
 'f' => ['deffn', 'deftypefn', 'deftypeop', 'defop'],
 'v' => ['defvr', 'deftypevr', 'defcv', 'deftypecv' ],
 't' => ['deftp']
);

our %command_index_prefix;

$command_index_prefix{'vtable'} = 'v';
$command_index_prefix{'ftable'} = 'f';

foreach my $index_type (keys %index_type_def) {
  foreach my $def (@{$index_type_def{$index_type}}) {
    $command_index_prefix{$def} = $index_type;
  }
}

our %def_commands;
our %def_aliases;
foreach my $def_command(keys %def_map) {
  if (ref($def_map{$def_command}) eq 'HASH') {
    my ($real_command) = keys (%{$def_map{$def_command}});
    $command_index_prefix{$def_command} = $command_index_prefix{$real_command};
    $def_aliases{$def_command} = $real_command;
  }
  $block_commands{$def_command} = 'def';
  $misc_commands{$def_command.'x'} = 'line';
  $def_commands{$def_command} = 1;
  $def_commands{$def_command.'x'} = 1;
  $command_index_prefix{$def_command.'x'} = $command_index_prefix{$def_command};
}

#print STDERR "".Data::Dumper->Dump([\%def_aliases]);
#print STDERR "".Data::Dumper->Dump([\%def_prepended_content]);

$block_commands{'multitable'} = 'multitable';
$block_item_commands{'multitable'} = 1;

# block commands in which menu entry and menu comments appear
our %menu_commands;
foreach my $menu_command ('menu', 'detailmenu', 'direntry') {
  $menu_commands{$menu_command} = 1;
  $block_commands{$menu_command} = 0;
};

our %align_commands;
foreach my $align_command('raggedright', 'flushleft', 'flushright') {
  $block_commands{$align_command} = 0;
  $align_commands{$align_command} = 1;
}
$align_commands{'center'} = 1;

foreach my $block_command(
    'cartouche', 'group') {
  $block_commands{$block_command} = 0;
}

our %region_commands;
foreach my $block_command('titlepage', 'copying', 'documentdescription') {
  $block_commands{$block_command} = 0;
  $region_commands{$block_command} = 1;
}
  
our %preformatted_commands;
our %preformatted_code_commands;
foreach my $preformatted_command(
    'example', 'smallexample', 'lisp', 'smalllisp') {
  $block_commands{$preformatted_command} = 0;
  $preformatted_commands{$preformatted_command} = 1;
  $preformatted_code_commands{$preformatted_command} = 1;
}

foreach my $preformatted_command(
    'display', 'smalldisplay', 'format', 'smallformat') {
  $block_commands{$preformatted_command} = 0;
  $preformatted_commands{$preformatted_command} = 1;
}

our %raw_commands;
our @out_formats = ('html', 'tex', 'xml', 'docbook');
# macro/rmacro are special
foreach my $raw_command (@out_formats, 'verbatim', 
                         'ignore', 'macro', 'rmacro') {
  $block_commands{$raw_command} = 'raw';
  $raw_commands{$raw_command} = 1;
}

foreach my $command (@out_formats, 'info', 'plaintext') {
  $block_commands{'if' . $command} = 'conditional';
  $block_commands{'ifnot' . $command} = 'conditional';
}

$block_commands{'ifset'} = 'conditional';
$block_commands{'ifclear'} = 'conditional';

# 'macro' ?
foreach my $block_command_one_arg('table', 'ftable', 'vtable',
  'itemize', 'enumerate', 'quotation', 'smallquotation') {
  $block_commands{$block_command_one_arg} = 1;
  $block_item_commands{$block_command_one_arg} = 1 
    unless ($block_command_one_arg =~ /quotation/);
}

$block_commands{'float'} = 2;

foreach my $block_command (keys(%block_commands)) {
  $close_paragraph_commands{$block_command} = 1
     unless ($block_commands{$block_command} eq 'raw' or
             $block_commands{$block_command} eq 'conditional');
}

$close_paragraph_commands{'verbatim'} = 1;

foreach my $close_paragraph_command ('titlefont', 'insertcopying', 'sp',
  'verbatiminclude', 'page', 'item', 'itemx', 'tab', 'headitem',
  'printindex', 'listoffloats', 'center', 'dircategory', 'contents',
  'shortcontents', 'summarycontents', 'caption', 'shortcaption',
  'setfilename') {
  $close_paragraph_commands{$close_paragraph_command} = 1;
}

foreach my $close_paragraph_command (keys(%def_commands)) {
  $close_paragraph_commands{$close_paragraph_command} = 1;
}

our %item_container_commands;
foreach my $item_container_command ('itemize', 'enumerate') {
  $item_container_commands{$item_container_command} = 1;
}
our %item_line_commands;
foreach my $item_line_command ('table', 'ftable', 'vtable') {
  $item_line_commands{$item_line_command} = 1;
}

our %deprecated_commands = (
  'ctrl' => '',
  'allow-recursion' => N__('recursion is always allowed'),
  'quote-arg' => N__('arguments are quoted by default'),
);

# commands that should only appear at the root level and contain up to
# the next root command.  @node and sectioning commands.
our %root_commands;

our %command_structuring_level = (
              'top', 0,
              'chapter', 1,
              'unnumbered', 1,
              'chapheading', 1,
              'appendix', 1,
              'section', 2,
              'unnumberedsec', 2,
              'heading', 2,
              'appendixsec', 2,
              'subsection', 3,
              'unnumberedsubsec', 3,
              'subheading', 3,
              'appendixsubsec', 3,
              'subsubsection', 4,
              'unnumberedsubsubsec', 4,
              'subsubheading', 4,
              'appendixsubsubsec', 4,
         );

our %level_to_structuring_command;

{
  my $sections = [ ];
  my $appendices = [ ];
  my $unnumbered = [ ];
  my $headings = [ ];
  foreach my $command (keys (%command_structuring_level)) {
    if ($command =~ /^appendix/) {
      $level_to_structuring_command{$command} = $appendices;
    } elsif ($command =~ /^unnumbered/ or $command eq 'top') {
      $level_to_structuring_command{$command} = $unnumbered;
    } elsif ($command =~ /section$/ or $command eq 'chapter') {
      $level_to_structuring_command{$command} = $sections;
    } else {
      $level_to_structuring_command{$command} = $headings;
    }
    $level_to_structuring_command{$command}->[$command_structuring_level{$command}] 
      = $command;
  }
  $level_to_structuring_command{'appendixsection'} = $appendices;
  $level_to_structuring_command{'majorheading'} = $headings;
  $level_to_structuring_command{'centerchap'} = $unnumbered;
}


# out of the main hierarchy
$command_structuring_level{'part'} = 0;
# this are synonyms
$command_structuring_level{'appendixsection'} = 2;
# command_structuring_level{'majorheading'} is also 1 and not 0
$command_structuring_level{'majorheading'} = 1;
$command_structuring_level{'centerchap'} = 1;

our %sectioning_commands;

foreach my $sectioning_command (keys (%command_structuring_level)) {
  $misc_commands{$sectioning_command} = 'line';
  if ($sectioning_command =~ /heading/) {
    $close_paragraph_commands{$sectioning_command} = 1;
  } else {
    $root_commands{$sectioning_command} = 1;
  }
  $sectioning_commands{$sectioning_command} = 1;
}

$root_commands{'node'} = 1;



# charset related definitions.

our %perl_charset_to_html = (
              'utf8'       => 'utf-8',
              'utf-8-strict'       => 'utf-8',
              'ascii'      => 'us-ascii',
              'shiftjis'      => 'shift_jis',
);

# encoding name normalization to html-compatible encoding names
our %encoding_aliases = (
              'latin1' => 'iso-8859-1',
);

foreach my $perl_charset (keys(%perl_charset_to_html)) {
   $encoding_aliases{$perl_charset} = $perl_charset_to_html{$perl_charset};
   $encoding_aliases{$perl_charset_to_html{$perl_charset}}
        = $perl_charset_to_html{$perl_charset};
}
our %eight_bit_encoding_aliases = (
  "iso-8859-1",  'iso8859_1',
  "iso-8859-2",  'iso8859_2',
  "iso-8859-15", 'iso8859_15',
  "koi8-r",      'koi8',
  "koi8-u",      'koi8',
);

foreach my $encoding (keys(%eight_bit_encoding_aliases)) {
  $encoding_aliases{$encoding} = $encoding;
  $encoding_aliases{$eight_bit_encoding_aliases{$encoding}} = $encoding;
}

our @MONTH_NAMES =
    (
     'January', 'February', 'March', 'April', 'May',
     'June', 'July', 'August', 'September', 'October',
     'November', 'December'
    );

sub locate_include_file($$)
{
  my $self = shift;
  my $text = shift;
  my $file;

  #print STDERR "$self $text @{$self->{'include_directories'}}\n";
  if ($text =~ m,^(/|\./|\.\./),) {
    $file = $text if (-e $text and -r $text);
  } else {
    my @dirs;
    if ($self) {
      @dirs = @{$self->{'include_directories'}};
    } else {
      # no object with directory list and not an absolute path, never succeed
      return undef;
    }
    foreach my $dir (@{$self->{'include_directories'}}) {
      $file = "$dir/$text" if (-e "$dir/$text" and -r "$dir/$text");
      last if (defined($file));
    }
  }
  return $file;
}

sub open_out ($$;$)
{
  my $self = shift;
  my $file = shift;
  my $encoding = shift;
  if ($file eq '-') {
    binmode(STDOUT, ":encoding($encoding)") if (defined($encoding));
    return \*STDOUT;
  }
  my $filehandle = do { local *FH };
  if (!open ($filehandle, '>', $file)) {
    return undef; 
  }
  if (defined($encoding)) {
    if ($encoding eq 'utf8' or $encoding eq 'utf-8-strict') {
      binmode($filehandle, ':utf8');
    } else { # FIXME also right for shiftijs or similar encodings?
      binmode($filehandle, ':bytes');
    }
    binmode($filehandle, ":encoding($encoding)");
  }
  push @{$self->{'opened_files'}}, $file;
  return $filehandle;
}

sub warn_unknown_language($$) {
  my $lang = shift;
  my $gettext = shift;

  my @messages = ();
  my $lang_code = $lang;
  my $region_code;

  if ($lang =~ /^([a-z]+)_([A-Z]+)/) {
    $lang_code = $1;
    $region_code = $2;
  }

  if (! $Texinfo::Documentlanguages::language_codes{$lang_code}) {
    push @messages, sprintf(&$gettext("%s is not a valid language code"), 
                            $lang_code);
  }
  if (defined($region_code) 
       and ! $Texinfo::Documentlanguages::region_codes{$region_code}) {
    push @messages, sprintf(&$gettext("%s is not a valid region code"), 
                            $region_code);
  }
  return @messages;
}

our %canonical_texinfo_encodings;
# These are the encodings from the texinfo manual
foreach my $canonical_encoding('us-ascii', 'utf-8', 'iso-8859-1',
  'iso-8859-15','iso-8859-2','koi8-r', 'koi8-u') {
  $canonical_texinfo_encodings{$canonical_encoding} = 1;
}

sub encoding_alias ($)
{
  my $encoding = shift;
  my $canonical_texinfo_encoding;
  $canonical_texinfo_encoding 
    = $encoding if ($canonical_texinfo_encodings{lc($encoding)});
  my $perl_encoding = Encode::resolve_alias($encoding);
  my $canonical_output_encoding;
  if ($perl_encoding) {
    $canonical_output_encoding = $encoding_aliases{$perl_encoding};
  }
  return ($canonical_texinfo_encoding, $perl_encoding, $canonical_output_encoding);
}

# This should do the job, or at least don't do wrong if $self
# is not defined, as could be the case if called from 
# Texinfo::Convert::Text.
sub expand_verbatiminclude($$)
{
  my $self = shift;
  my $current = shift;

  return unless ($current->{'extra'} and defined($current->{'extra'}->{'text_arg'}));
  my $text = $current->{'extra'}->{'text_arg'};
  my $file = locate_include_file($self, $text);

  my $verbatiminclude;

  if (defined($file)) {
    # FIXME encoding?
    if (!open(VERBINCLUDE, $file)) {
      if ($self) {
        $self->line_error (sprintf($self->__("Cannot read %s: %s"), $file, $!), 
                            $current->{'line_nr'});
      }
    } else {
      $verbatiminclude = { 'cmdname' => 'verbatim',
                           'parent' => $current->{'parent'},
                           'extra' => 
                        {'text_arg' => $current->{'extra'}->{'text_arg'}} };
      while (<VERBINCLUDE>) {
        push @{$verbatiminclude->{'contents'}}, 
                  {'type' => 'raw', 'text' => $_ };
      }
      close (VERBINCLUDE);
    }
  } elsif ($self) {
    $self->line_error (sprintf($self->__("\@%s: Cannot find %s"), 
                    $current->{'cmdname'}, $text), $current->{'line_nr'});
  }
  return $verbatiminclude;
}

sub definition_category($$)
{
  my $self = shift;
  my $current = shift;

  return undef if (!$current->{'extra'} or !$current->{'extra'}->{'def_args'});

  my $arg_category = $current->{'extra'}->{'def_parsed_hash'}->{'category'};
  my $arg_class = $current->{'extra'}->{'def_parsed_hash'}->{'class'};

  return $arg_category
    if (!defined($arg_class));
  
  my $style = 
    $command_index_prefix{$current->{'extra'}->{'def_command'}};
  if ($style eq 'f') {
    if ($self) {
      return $self->gdt('{category} on {class}', { 'category' => $arg_category,
                                          'class' => $arg_class });
    } else {
      return {'contents' => [$arg_category, {'text' => ' on '}, $arg_class]};
    }
  } elsif ($style eq 'v') {
    if ($self) {
      return $self->gdt('{category} of {class}', { 'category' => $arg_category,
                                          'class' => $arg_class });
    } else {
      return {'contents' => [$arg_category, {'text' => ' of '}, $arg_class]};
    }
  }
}

sub expand_today($)
{
  my $self = shift;
  if ($self->get_conf('TEST')) {
    return {'text' => 'a sunny day'};
  }
  my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst)
   = localtime(time);
  $year += ($year < 70) ? 2000 : 1900;
  return $self->gdt('{month} {day}, {year}',
          { 'month' => $self->gdt($MONTH_NAMES[$mon]),
            'day' => $mday, 'year' => $year });
}

sub definition_arguments_content($)
{
  my $root = shift;
  my $result;

  return undef if (!defined($root->{'extra'}) 
                    or !defined($root->{'extra'}->{'def_args'}));
  my @args = @{$root->{'extra'}->{'def_args'}};
  while (@args) {
    last if ($args[0]->[0] ne 'spaces'
             and !$root->{'extra'}->{'def_parsed_hash'}->{$args[0]->[0]});
    shift @args;
  }
  if (@args) {
    foreach my $arg (@args) {
      push @$result, $arg->[1];
    }
  }
  return $result;
}

sub trim_spaces_comment_from_content($)
{
  my $contents = shift;
  shift @$contents 
    if ($contents->[0] and $contents->[0]->{'type'}
       and ($contents->[0]->{'type'} eq 'empty_line_after_command'
            or $contents->[0]->{'type'} eq 'empty_spaces_after_command'
            or $contents->[0]->{'type'} eq 'empty_spaces_before_argument'
            or $contents->[0]->{'type'} eq 'empty_space_at_end_def_bracketed'
            or $contents->[0]->{'type'} eq 'empty_spaces_after_close_brace'));

  while (@$contents 
         and (($contents->[-1]->{'cmdname'}
               and ($contents->[-1]->{'cmdname'} eq 'c' 
                    or $contents->[-1]->{'cmdname'} eq 'comment'))
              or ($contents->[-1]->{'type'}
                  and ($contents->[-1]->{'type'} eq 'spaces_at_end'
                       or $contents->[-1]->{'type'} eq 'space_at_end_block_command')))) {
    pop @$contents;
  }
}

sub float_name_caption($$)
{
  my $self = shift;
  my $root = shift;

  my $caption;
  if ($root->{'extra'}->{'caption'}) {
    $caption = $root->{'extra'}->{'caption'};
  } elsif ($root->{'extra'}->{'shortcaption'}) {
    $caption = $root->{'extra'}->{'shortcaption'};
  }
  #if ($self->get_conf('DEBUG')) {
  #  my $caption_texi = 
  #    Texinfo::Convert::Texinfo::convert({ 'contents' => $caption->{'contents'}});
  #  print STDERR "  CAPTION: $caption_texi\n";
  #}
  my $type;
  if ($root->{'extra'}->{'type'}->{'normalized'} ne '') {
    $type = {'contents' => $root->{'extra'}->{'type'}->{'content'}};
  }

  my $prepended;
  if ($type) {
  #print STDERR "AAAAAAA $root->{'extra'}->{'type'} "
  #   .Data::Dumper->Dump([$root->{'extra'}->{'type'}]);
    if ($caption) {
      if (defined($root->{'number'})) {
        $prepended = $self->gdt('{float_type} {float_number}: ',
            {'float_type' => $type,
             'float_number' => $root->{'number'}});
      } else {
        $prepended = $self->gdt('{float_type}: ',
          {'float_type' => $type});
      }
    } else {
      if (defined($root->{'number'})) {
        $prepended = $self->gdt("{float_type} {float_number}\n",
            {'float_type' => $type,
              'float_number' => $root->{'number'}});
      } else {
        $prepended = $self->gdt("{float_type}\n",
            {'float_type' => $type});
      }
    }
  } elsif (defined($root->{'number'})) {
    if ($caption) {
      $prepended = $self->gdt('{float_number}: ',
          {'float_number' => $root->{'number'}});
    } else {
      $prepended = $self->gdt("{float_number}\n",
           {'float_number' => $root->{'number'}});
    }
  }
  return ($caption, $prepended);
}

our %htmlxref_entries = (
 'node' => [ 'node', 'section', 'chapter', 'mono' ],
 'section' => [ 'section', 'chapter','node', 'mono' ],
 'chapter' => [ 'chapter', 'section', 'node', 'mono' ],
 'mono' => [ 'mono', 'chapter', 'section', 'node' ],
);

sub parse_htmlxref_files($$)
{
  my $self = shift;
  my $files = shift;
  my $htmlxref;

  foreach my $file (@$files) {
    print STDERR "html refs config file: $file\n" if ($self->get_conf('DEBUG'));
    unless (open (HTMLXREF, $file)) {
      $self->document_warn(
        sprintf($self->__("Cannot open html refs config file %s: %s"),
          $file, $!));
      next;
    }
    my $line_nr = 0;
    my %variables;
    while (my $hline = <HTMLXREF>) {
      my $line = $hline;
      $line_nr++;
      next if $hline =~ /^\s*#/;
      #$hline =~ s/[#]\s.*//;
      $hline =~ s/^\s*//;
      next if $hline =~ /^\s*$/;
      chomp ($hline);
      if ($hline =~ s/^\s*(\w+)\s*=\s*//) {
        # handle variables
        my $var = $1;
        my $re = join '|', map { quotemeta $_ } keys %variables;
        $hline =~ s/\$\{($re)\}/defined $variables{$1} ? $variables{$1} 
                                                       : "\${$1}"/ge;
        $variables{$var} = $hline;
        next;
      }
      my @htmlxref = split /\s+/, $hline;
      my $manual = shift @htmlxref;
      my $split_or_mono = shift @htmlxref;
      #print STDERR "$split_or_mono $Texi2HTML::Config::htmlxref_entries{$split_or_mono} $line_nr\n";
      if (!defined($split_or_mono)) {
        $self->file_line_warn($self->__("Missing type"), $file, $line_nr);
        next;
      } elsif (!defined($htmlxref_entries{$split_or_mono})) {
        $self->file_line_warn(sprintf($self->__("Unrecognized type: %s"), 
                               $split_or_mono), $file, $line_nr);
        next;
      }
      my $href = shift @htmlxref;
      next if (exists($htmlxref->{$manual}->{$split_or_mono}));

      if (defined($href)) { # substitute 'variables'
        my $re = join '|', map { quotemeta $_ } keys %variables;
        $href =~ s/\$\{($re)\}/defined $variables{$1} ? $variables{$1} 
                                                      : "\${$1}"/ge;
        $href =~ s/\/*$// if ($split_or_mono ne 'mono');
      }
      $htmlxref->{$manual}->{$split_or_mono} = $href;
    }
    close (HTMLXREF);
  }
  return $htmlxref;
}

sub parse_renamed_nodes_file($$;$$)
{
  my $self = shift;
  my $renamed_nodes_file = shift;
  # if not given they are automatically created
  my $renamed_nodes = shift;
  my $renamed_nodes_lines = shift;

  if (open(RENAMEDFILE, "<$renamed_nodes_file")) {
    if ($self->{'info'} and $self->{'info'}->{'perl_encoding'}) {
      binmode(RENAMEDFILE, ":encoding($self->{'info'}->{'perl_encoding'})");
    }
    my $renamed_nodes_line_nr = 0;
    my @old_names = ();
    while (<RENAMEDFILE>) {
      $renamed_nodes_line_nr++;
      next unless (/\S/);
      next if (/^\s*\@c\b/);
      if (s/^\s*\@\@\{\}\s+(\S)/$1/) {
        chomp;
        if (scalar(@old_names)) {
          foreach my $old_node_name (@old_names) {
            $renamed_nodes->{$old_node_name} = $_;
            $renamed_nodes_lines->{$_} = $renamed_nodes_line_nr;
          }
          @old_names = ();
        } else {
          warn (sprintf($self->__("%s:%d: no node to be renamed\n"), 
                        $renamed_nodes_file, $renamed_nodes_line_nr));
        }
      } else {
        chomp;
        s/^\s*//;
        $renamed_nodes_lines->{$_} = $renamed_nodes_line_nr;
        push @old_names, $_;
      }
    }
    if (scalar(@old_names)) {
      warn (sprintf($self->__("%s:%d: nodes without a new name at the end of file\n"),
             $renamed_nodes_file, $renamed_nodes_line_nr));
    }
    close(RENAMEDFILE);
  } else {
    warn (sprintf($self->__("Cannot read %s: %s"), $renamed_nodes_file, $!));
  }
  return ($renamed_nodes, $renamed_nodes_lines);
}

sub collect_renamed_nodes($$;$$)
{
  my $self = shift;
  my $basename = shift;
  my $renamed_nodes = shift;
  my $renamed_nodes_lines = shift;

  my $renamed_nodes_file;
  if (defined($self->get_conf('RENAMED_NODES_FILE'))) {
    $renamed_nodes_file = $self->get_conf('RENAMED_NODES_FILE');
  } elsif (-f $basename . '-noderename.cnf') {
    $renamed_nodes_file = $basename . '-noderename.cnf';
  }
  if (defined($renamed_nodes_file)) {
    my ($renamed_nodes, $renamed_nodes_lines)
     = parse_renamed_nodes_file($self, $renamed_nodes_file, $renamed_nodes,
                                $renamed_nodes_lines);
    return ($renamed_nodes, $renamed_nodes_lines, $renamed_nodes_file);
  }
  return (undef, undef, undef);
}

sub normalize_top_node($)
{
  my $node = shift;
  if ($node =~ /^top$/i) {
    return 'Top';
  }
  return $node;
}

1;

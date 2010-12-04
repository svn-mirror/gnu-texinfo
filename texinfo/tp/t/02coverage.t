use strict;

require 't/test_utils.pl';

my @test_cases = (
['commands','@@ @TeX{} @
@"e @^{@dotless{i}} @~{a} @ringaccent a
@clicksequence{File @click{} Open}@.
@email{a, b}

@cindex index entry in text @LaTeX{}

@majorheading majorheading @b{in b}
'],
['lettered_accent_and_spaces',
'@ringaccent    a
'],
['math',
'Simple math
@math{{x^i}\over{\tan y}}

Math with @@-command
@math{@code{math code} a < b}

Complex
@math{ \underline{@code{math \hbox{ code }}} @\i \sum_{i}{\underline{f}}}

@@\ outside of math
@\

'],
['block_commands','
@group
in group
@end group

@quotation warning
in quotation
@end quotation

@float a float, b float
In float


@caption{in caption

in caption}
@end float
'],
['item_container','
@itemize +
@item i--tem +
@end itemize

@itemize @bullet
@item
 b--ullet
@end itemize
'],
['table','
@table @asis
@item table item
@itemx table itemx

In table
@end table

@vtable @samp@c samp
@c after vtable
@cindex index entry

@item vtable item
@c after item
@kindex key
@itemx itemx vtable @comment comment in itemx line

@end vtable
'],
['table_command_comment',
'@table @code@c in comment
@item item
@end table'
],
['multitable','
@multitable @columnfractions 0.6 0.4
@headitem mu--ltitable headitem @tab another tab
@item mu--ltitable item @tab multitable tab
@c comment in multitable
@item mu--ltitable item 2 @tab multitable tab 2
@cindex index entry within multitable
@item lone mu--ltitable item
@end multitable

@multitable {truc} {bidule}
@item truc @tab bidule
@end multitable
'],
['preformatted','
@example
e--xample  some  

   text
@end example

@format
@vtable @code
@item item in table in format

in table in format
@end vtable
@end format
'],
['def','
@deffn {c--ategory} d--effn_name a--rguments...
d--effn
@end deffn

@deffn cate--gory de--ffn_name ar--guments @
   more args @* even more so
def--fn
@end deffn

@deffn fset @var{i} a g
@deffnx {cmde} truc {}
@deffnx Command {log trap} {}
@deffnx Command { log trap1} {}  
@deffnx Command {log trap2 } {}
@deffnx cmde @b{id ule} truc
@deffnx cmde2 @b{id @samp{i} ule} truc
@deffnx{} machin
@deffnx{} {bidule machin}
@deffnx{truc} machin
@deffnx {truc} followed by a comment
@c comment
@deffnx {truc} after a deff item
@c comment
@deffnx {truc} deffnx before end deffn
Various deff lines
@end deffn
'],
['nested_block_commands',
'@group
In group
@quotation
in quotation
@end quotation
@end group

@group
@quotation
in quotation
@end quotation
@end group

@group
In group
@quotation
in quotation
@end quotation
after quotation
@end group

@group

In group sp b
@quotation
in quotation
@end quotation
@end group

@group

In group sp b a

@quotation
in quotation
@end quotation
@end group

@group
In group sp a

@quotation
in quotation
@end quotation
@end group

@group
@quotation

in quotation sp b
@end quotation
@end group

@group
@quotation

in quotation sp b a

@end quotation
@end group

@group
@quotation
in quotation sp a

@end quotation
@end group

@group
@quotation
in quotation
@end quotation

After quotation sp b
@end group

@group
@quotation
in quotation
@end quotation
After quotation sp a

@end group

@group
@quotation
in quotation
@end quotation

After quotation sp b a

@end group
'],
['cartouche',
'@cartouche
in cartouche.
@end cartouche'],
['insertcopying',
'@copying
License.

@quotation 
You are not allowed.
@end quotation
@end copying

License:

@insertcopying
']
);

my @test_invalid = (
['arg_in_brace_no_arg_command',
'@TeX{in tex}
'],
['accents_errors',
'accent at end of line @ringaccent
accent at end of line and spaces @ringaccent  
accent followed by @@ @ringaccent@.

accent character with spaces @~ following.
accent character at end of line @~
accent character followed by @@ @~@.

With @@:
@ringaccent @@. @^@@.
'],
['accent_no_closed',
'@~{e'],
['accent_no_closed_newline',
'@~{e

'],
['accent_no_closed_paragraph',
'@~{e

other para.
'],
['accent_no_closed_comment',
'@~{e @c comment
'],
['flushright_not_closed',
'@flushright

text flushed right
'],
['group_not_closed',
'@group

text in group
'],
['unknown_commands',
'@unknwon
@#
']
);

foreach my $test (@test_cases) {
  $test->[2]->{'test_formats'} = ['plaintext'];
}

our ($arg_test_case, $arg_generate, $arg_debug);

run_all ('coverage', [@test_cases, @test_invalid], $arg_test_case,
   $arg_generate, $arg_debug);

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Pod-Simple-Texinfo.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More;
BEGIN { plan tests => 15 };
use Pod::Simple::Texinfo;
ok(1); # If we made it this far, we're ok.

#########################

sub run_test($$$)
{
  my $in = shift;
  my $out = shift;
  my $name = shift;

  my $parser = Pod::Simple::Texinfo->new();
  $parser->set_source(\$in);
  my $result;
  $parser->output_string(\$result);
  $parser->bare_output(1);
  $parser->run();
  if (defined($out)) {
    is ($result, $out, $name);
  } else {
    print "$name:\n";
    print STDERR $result;
  }
}

run_test ('=head1 T
X<aaa>
',
'@chapter T
@anchor{T}
@cindex aaa

', 'index in head');

run_test ('=head1 T

Para X<bb>
in para X<cc>  
qtil X<ff> ggg
n X<ww> X<ff> C<aa>.
C<JJ> X<tt>.
X<-r>X<+p>
X<fff>
X<WWW>
I<GG>X<DD>C<MM>.
',
'@chapter T
@anchor{T}

@cindex bb
@cindex cc
@cindex ff
@cindex ww
@cindex ff
@cindex tt
@cindex -r
@cindex +p
@cindex fff
@cindex WWW
@cindex DD
Para in para qtil ggg
n @code{aa}.
@code{JJ} .
@emph{GG}@code{MM}.

', 'index in paragaph');

run_test('=over

=item a
X<it> b

=item c
X<C<code>>

Para

=back
',
'@table @asis
@item a b
@anchor{a b}
@cindex it

@item c
@anchor{c}
@cindex @code{code}

Para

@end table

', 'index in item-text');

run_test('=over

=item L</somewhere>
', '@table @asis
@item @ref{somewhere}


@end table

', 'ref in item');

run_test('=head1 NAME

=head1 NAME 
', '@chapter NAME
@anchor{NAME}

@chapter NAME
@anchor{NAME 1}

', 'double ref');

run_test('=head1 head with
new line
', '@chapter head with new line
@anchor{head with new line}

', 'head with new line');

run_test('=head1 L</somewhere>
', '@chapter somewhere


', 'ref in section');

run_test('=over

=item a L<pod2text|pod2text>

=item a L<pod2latex|pod2latex>

', '@table @asis
@item a @ref{, pod2text,, pod2text}
@anchor{a }

@item a @ref{, pod2latex,, pod2latex}
@anchor{a  1}

@end table

', 'duplicate anchors ref');

run_test('=head1 a, b', '@chapter a, b
@anchor{a@comma{} b}

', 'comma in head1');

run_test('=head1 a, b

=over

=item c, d

=back

L</a, b>. L</c, d>.
', '@chapter a, b
@anchor{a@comma{} b}

@table @asis
@item c, d
@anchor{c@comma{} d}

@end table

@ref{a@comma{} b}. @ref{c@comma{} d}.

', 'comma in refs');

run_test('=head1 (man) t

L</(man) t>', '@chapter (man) t
@anchor{@asis{(}man) t}

@ref{@asis{(}man) t,, (man) t}

', 'node beginning with a parenthesis');

run_test('=head1 head

# line 4 "ggggg"
and
 # line 5 "fff"

# line 4 "bbb"
# 7 "aaaa"
', '@chapter head
@anchor{head}

@hashchar{} line 4 "ggggg"
and
 @hashchar{} line 5 "fff"

@hashchar{} line 4 "bbb"
@hashchar{} 7 "aaaa"

', 'cpp lines');

run_test('=head1 head

 # line 4 "ggggg"
 and @
 # line 5 "fff"

Text

  # line 4 "bbb"
  # 7 "aaaa"
', '@chapter head
@anchor{head}

@format
 @hashchar{} line 4 "ggggg"
 and @@
 @hashchar{} line 5 "fff"
@end format

Text

@format
  @hashchar{} line 4 "bbb"
  @hashchar{} 7 "aaaa"
@end format

', 'cpp lines in verbatim');

run_test('=head1 head

=for html
 # line 4 "ggggg" 
  <html> @

=begin html

 # line 8 "kkk"
 and @
 # line 5 "fff"

=end html
', '@chapter head
@anchor{head}

@html

 @hashchar{} line 4 "ggggg" 
  <html> @@
@end html
@html
 @hashchar{} line 8 "kkk"
 and @@
 @hashchar{} line 5 "fff"

@end html
','cpp lines in formats');

1;


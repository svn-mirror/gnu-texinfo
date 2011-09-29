# Text.pm: output tree as simple text.
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

package Texinfo::Convert::Text;

use 5.00405;
use strict;

# accent commands list.
use Texinfo::Common;
use Texinfo::Convert::Unicode;
# for debugging
use Texinfo::Convert::Texinfo;
use Data::Dumper;
use Carp qw(cluck);

require Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration       use Texinfo::Convert::Text ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
%EXPORT_TAGS = ( 'all' => [ qw(
  convert
) ] );

@EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

@EXPORT = qw(
);

$VERSION = '0.01';

# this is in fact not needed for 'footnote', 'shortcaption', 'caption'
# when they have no brace_command_arg, see below.
my %ignored_brace_commands;
foreach my $ignored_brace_command ('xref','ref','pxref','inforef','anchor',
   'footnote', 'shortcaption', 'caption', 'hyphenation') {
  $ignored_brace_commands{$ignored_brace_command} = 1;
}

my %ignored_block_commands;
foreach my $ignored_command ('titlepage', 'copying', 'documentdescription',
  'html', 'tex', 'xml', 'docbook', 'ignore', 'macro', 'rmacro') {
  $ignored_block_commands{$ignored_command} = 1;
}

# used by Texinfo::Convert::NodeNormalization
our %text_brace_no_arg_commands = (
               'TeX'                => 'TeX',
               'LaTeX'              => 'LaTeX',
               'bullet'             => '*',
               'copyright'          => '(C)',
               'registeredsymbol'   => '(R)',
               'dots'         => '...',
               'enddots'      => '...',
               'equiv'        => '==',
# FIXME i18n
               'error'        => 'error-->',
               'expansion'    => '==>',
               'arrow'        => '->',
               'minus'        => '-',
               'point'        => '-!-',
               'print'        => '-|',
               'result'       => '=>',
               'today'        => '',
               'aa'           => 'aa',
               'AA'           => 'AA',
               'ae'           => 'ae',
               'oe'           => 'oe',
               'AE'           => 'AE',
               'OE'           => 'OE',
               'o'            => '/o',
               'O'            => '/O',
               'ss'           => 'ss',
               'l'            => '/l',
               'L'            => '/L',
               'DH'           => 'D',
               'dh'           => 'd',
               'TH'           => 'TH', # http://www.evertype.com/standards/wynnyogh/thorn.html

               'th'           => 'th',
               'exclamdown'   => '!',
               'questiondown' => '?',
               'pounds'       => '#',
               'ordf'         => 'a',
               'ordm'         => 'o',
               'comma'        => ',',
               'euro'         => 'Euro',
               'geq'          => '>=',
               'leq'          => '<=',
               'tie'          => ' ',
               'textdegree'      => 'o',
               'quotedblleft'    => '``',
               'quotedblright'   => "''",
               'quoteleft'       => '`',
               'quoteright'      => "'",
               'quotedblbase'    => ',,',
               'quotesinglbase'  => ',',
               'guillemetleft'   => '<<',
               'guillemetright'  => '>>',
               'guillemotleft'   => '<<',
               'guillemotright'  => '>>',
               'guilsinglleft'   => '<',
               'guilsinglright'  => '>',
               'click'           => '', # specially treated
);

my %sort_brace_no_arg_commands = (
  'copyright' => 'C',
  'registeredsymbol' => 'R',
  'today' => 't', 
);

foreach my $accent_letter ('o','O','l','L') {
  $sort_brace_no_arg_commands{$accent_letter} = $accent_letter;
}

my %accent_commands = %Texinfo::Common::accent_commands;
my %no_brace_commands = %Texinfo::Common::no_brace_commands;

our %formatting_misc_commands;
foreach my $command ('verbatiminclude', 'sp', 'center', 'exdent', 
                     'item', 'itemx', 'tab', 'headitem',
    'node', keys(%Texinfo::Common::sectioning_commands)) {
  $formatting_misc_commands{$command} = 1;
}
 
my %ignored_types;
foreach my $type ('empty_line_after_command', 'preamble',
            'empty_spaces_after_command', 'spaces_at_end',
            'empty_spaces_before_argument', 'empty_spaces_before_paragraph',
            'empty_spaces_after_close_brace', 
            'empty_space_at_end_def_bracketed') {
  $ignored_types{$type} = 1;
}


sub ascii_accent($$)
{
  my $text = shift;
  my $command = shift;
  my $accent = $command->{'cmdname'};
  return $text if ($accent eq 'dotless');
  return $text . "''" if ($accent eq 'H');
  return $text . '.' if ($accent eq 'dotaccent');
  return $text . '*' if ($accent eq 'ringaccent');
  return $text . '[' if ($accent eq 'tieaccent');
  return $text . '(' if ($accent eq 'u');
  return $text . '_' if ($accent eq 'ubaraccent');
  return '.' . $text  if ($accent eq 'udotaccent');
  return $text . '<' if ($accent eq 'v');
  return $text . ';' if ($accent eq 'ogonek');
  return $text . $accent;
}

# format a stack of accents as ascii
sub ascii_accents ($$;$)
{
  my $result = shift;
  my $stack = shift;
  my $in_upper_case = shift;

  $result = uc($result) if ($in_upper_case and $result =~ /^\w$/);
  foreach my $accent_command (reverse(@$stack)) {
    $result = ascii_accent ($result, $accent_command);
  }
  return $result;
}

# format an accent command and nested accents within as Text.
sub text_accents($$;$)
{
  my $accent = shift;
  my $encoding = shift;
  my $in_upper_case = shift;
  
  return '' if (!$accent->{'args'});

  my ($contents, $stack)
      = Texinfo::Common::find_innermost_accent_contents($accent);

  my $options = {};
  $options->{'enabled_encoding'} = $encoding if (defined($encoding));
  $options->{'sc'} = $in_upper_case if (defined($in_upper_case));
  my $text = convert({'contents' => $contents}, $options);

  if ($encoding and $encoding eq 'utf-8') {
    return Texinfo::Convert::Unicode::unicode_accents($text, $stack, 
                                              \&ascii_accent, $in_upper_case);
  } elsif ($encoding 
           and $Texinfo::Encoding::eight_bit_encoding_aliases{$encoding}) {
    return Texinfo::Convert::Unicode::eight_bit_accents($text, $stack, 
                                     $encoding, \&ascii_accent, $in_upper_case);
  } else {
    my $result = ascii_accents($text, $stack, $in_upper_case);
  }
}

sub brace_no_arg_command($;$)
{
  my $root = shift;
  my $options = shift;
  my $encoding;
  $encoding = $options->{'enabled_encoding'}
    if ($options and $options->{'enabled_encoding'});

  my $command = $root->{'cmdname'};
  $command = $root->{'extra'}->{'clickstyle'}
     if ($root->{'extra'}
      and defined($root->{'extra'}->{'clickstyle'})
      and defined($text_brace_no_arg_commands{$root->{'extra'}->{'clickstyle'}}));
  my $result = Texinfo::Convert::Unicode::unicode_for_brace_no_arg_command(
                       $command, $encoding);
  if (!defined($result)) {
    if ($options and $options->{'sort_string'} 
        and $sort_brace_no_arg_commands{$command}) {
      $result = $sort_brace_no_arg_commands{$command};
    } else {
      $result = $text_brace_no_arg_commands{$command};
    }
  }
  if ($options and $options->{'sc'} 
      and $Texinfo::Common::letter_no_arg_commands{$command}) {
    $result = uc($result);
  }
  return $result;
}

my %underline_symbol = (
  0 => '*',
  1 => '*',
  2 => '=',
  3 => '-',
  4 => '.'
);

sub numbered_heading($$$)
{
  my $current = shift;
  my $text = shift;
  my $numbered = shift;

  $text = $current->{'number'}.' '.$text if (defined($current->{'number'}) 
                                         and ($numbered or !defined($numbered)));
  if ($current->{'cmdname'} eq 'appendix' and $current->{'level'} == 1) {
    # FIXME i18n
    $text = 'Appendix '.$text;
  }
  chomp ($text);
  return $text;
}

sub heading($$$)
{
  my $current = shift;
  my $text = shift;
  my $numbered = shift;

  $text = numbered_heading($current, $text, $numbered);
  return '' if ($text !~ /\S/);
  my $result = $text ."\n";
  $result .=($underline_symbol{$current->{'level'}} 
     x Texinfo::Convert::Unicode::string_width($text))."\n";
  return $result;
}

sub _normalise_space($)
{
  return undef unless (defined ($_[0]));
  my $text = shift;
  $text =~ s/\s+/ /go;
  $text =~ s/ $//;
  $text =~ s/^ //;
  return $text;
}

sub _code_options($)
{
  my $options = shift;
  my $code_options;
  if (defined($options)) {
    $code_options = { %$options };
  } else {
    $code_options = {};
  }
  $code_options->{'code'} = 1;
  return $code_options;
}

sub convert($;$);

sub convert($;$)
{
  my $root = shift;
  my $options = shift;

  if (0) {
    print STDERR "root\n";
    print STDERR "  Command: $root->{'cmdname'}\n" if ($root->{'cmdname'});
    print STDERR "  Type: $root->{'type'}\n" if ($root->{'type'});
    print STDERR "  Text: $root->{'text'}\n" if (defined($root->{'text'}));
    #print STDERR "  Special def_command: $root->{'extra'}->{'def_command'}\n"
    #  if (defined($root->{'extra'}) and $root->{'extra'}->{'def_command'});
  }

  return '' if (!($root->{'type'} and $root->{'type'} eq 'def_line')
     and (($root->{'type'} and $ignored_types{$root->{'type'}})
          or ($root->{'cmdname'} 
             and ($ignored_brace_commands{$root->{'cmdname'}} 
                 or $ignored_block_commands{$root->{'cmdname'}}
             # here ignore most of the misc commands
                 or ($root->{'args'} and $root->{'args'}->[0] 
                     and $root->{'args'}->[0]->{'type'} 
                     and ($root->{'args'}->[0]->{'type'} eq 'misc_line_arg'
                         or $root->{'args'}->[0]->{'type'} eq 'misc_arg') 
                     and !$formatting_misc_commands{$root->{'cmdname'}})))));
  my $result = '';
  if (defined($root->{'text'})) {
    $result = $root->{'text'};
    if (! defined($root->{'type'}) or $root->{'type'} ne 'raw') {
      if ($options->{'sc'}) {
        $result = uc($result);
      }
      if (!$options->{'code'}) {
        $result =~ s/``/"/g;
        $result =~ s/\'\'/"/g;
        $result =~ s/---/\x{1F}/g;
        $result =~ s/--/-/g;
        $result =~ s/\x{1F}/--/g;
      }
    }
  }
  if ($root->{'cmdname'}) {
    my $command = $root->{'cmdname'};
    if (defined($no_brace_commands{$root->{'cmdname'}})) {
      return $no_brace_commands{$root->{'cmdname'}};
    } elsif ($root->{'cmdname'} eq 'today') {
      if ($options->{'sort_string'} 
          and $sort_brace_no_arg_commands{$root->{'cmdname'}}) {
        return $sort_brace_no_arg_commands{$root->{'cmdname'}};
      } elsif ($options->{'converter'}) {
        return convert(Texinfo::Common::expand_today($options->{'converter'}),
                       $options);
      } elsif ($options->{'TEST'}) {
        return 'a sunny day';
      } else {
        my($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst)
          = localtime(time);
        $year += ($year < 70) ? 2000 : 1900;
        return "$Texinfo::Common::MONTH_NAMES[$mon] $mday, $year";
      }
    } elsif (defined($text_brace_no_arg_commands{$root->{'cmdname'}})) {
      return brace_no_arg_command($root, $options);
    # commands with braces
    } elsif ($accent_commands{$root->{'cmdname'}}) {
      my $result = text_accents ($root, $options->{'enabled_encoding'}, 
                                        $options->{'sc'});
      return $result;
    } elsif ($root->{'cmdname'} eq 'image') {
      return convert($root->{'args'}->[0], _code_options($options));
    } elsif ($root->{'cmdname'} eq 'email') {
      my $mail = _normalise_space(convert($root->{'args'}->[0], 
                                          _code_options($options)));
      my $text;
      $text = _normalise_space(convert($root->{'args'}->[1], $options)) 
         if (defined($root->{'args'}->[1]));
      return $text if (defined($text) and ($text ne ''));
      return $mail;
    } elsif ($root->{'cmdname'} eq 'uref' or $root->{'cmdname'} eq 'url') {
      my $replacement;
      $replacement = _normalise_space(convert($root->{'args'}->[2], $options))
        if (defined($root->{'args'}->[2]));
      return $replacement if (defined($replacement) and $replacement ne '');
      my $text;
      $text = convert($root->{'args'}->[1], $options)
        if (defined($root->{'args'}->[1]));
      my $url = convert($root->{'args'}->[0], _code_options($options));
      if (defined($text) and $text ne '') {
        return "$url ($text)";
      } else {
        return $url;
      }
    } elsif ($Texinfo::Common::explained_commands{$root->{'cmdname'}}
             and $root->{'args'} and $root->{'args'}->[1]) {
      my $explanation = convert($root->{'args'}->[1], $options);
      if ($explanation ne '') {
        return convert($root->{'args'}->[0], $options) ." ($explanation)";
      } else {
        return convert($root->{'args'}->[0], $options);
      }
    } elsif ($root->{'args'} and $root->{'args'}->[0] 
           and (($root->{'args'}->[0]->{'type'}
                and $root->{'args'}->[0]->{'type'} eq 'brace_command_arg')
                or $root->{'cmdname'} eq 'math')) {
      my $result;
      if ($root->{'cmdname'} eq 'sc') {
        $options = {%$options, 'sc' => 1};
      } elsif ($Texinfo::Common::code_style_commands{$root->{'cmdname'}}
               or $root->{'cmdname'} eq 'math') {
        $options = _code_options($options);
      }
      $result = convert($root->{'args'}->[0], $options);
      return $result;
    # block commands
    } elsif ($root->{'cmdname'} eq 'quotation'
             or $root->{'cmdname'} eq 'smallquotation'
             or $root->{'cmdname'} eq 'float') {
      if ($root->{'args'}) {
        foreach my $arg (@{$root->{'args'}}) {
          my $converted_arg = convert($arg, $options);
          if ($converted_arg =~ /\S/) {
            $result .= $converted_arg.", ";
          }
        }
        $result =~ s/, $//;
        chomp ($result);
        $result .= "\n";
      }
    } elsif ($formatting_misc_commands{$root->{'cmdname'}} and $root->{'args'}) {
      if ($root->{'cmdname'} eq 'sp') {
        if ($root->{'extra'} and $root->{'extra'}->{'misc_args'}
            and $root->{'extra'}->{'misc_args'}->[0]) {
          # this useless copy avoids perl changing the type to integer!
          my $sp_nr = $root->{'extra'}->{'misc_args'}->[0];
          $result = "\n" x $sp_nr;
        }
      } elsif ($root->{'cmdname'} eq 'verbatiminclude') {
        my $verbatim_include_verbatim
          = Texinfo::Common::expand_verbatiminclude($options->{'converter'},
                                                    $root);
        if (defined($verbatim_include_verbatim)) {
          $result .= convert($verbatim_include_verbatim, $options);
        }
      } elsif ($root->{'cmdname'} ne 'node') {
        $result = convert($root->{'args'}->[0], $options);
        if ($Texinfo::Common::sectioning_commands{$root->{'cmdname'}}) {
          $result = heading ($root, $result, $options->{'NUMBER_SECTIONS'});
        } else {
        # we always want an end of line even if is was eaten by a 
          chomp ($result);
          $result .= "\n";
        }
      }
    } elsif ($root->{'cmdname'} eq 'item' 
            and $root->{'parent'}->{'cmdname'} 
            and $root->{'parent'}->{'cmdname'} eq 'enumerate') {
      $result .= Texinfo::Common::enumerate_item_representation(
         $root->{'parent'}->{'extra'}->{'enumerate_specification'},
         $root->{'extra'}->{'item_number'}) . '. ';
    }
  }
  if ($root->{'type'} and $root->{'type'} eq 'def_line') {
    #print STDERR "$root->{'extra'}->{'def_command'}\n";
    if ($root->{'extra'} and $root->{'extra'}->{'def_args'}
             and @{$root->{'extra'}->{'def_args'}}) {
      my $parsed_definition_category
        = Texinfo::Common::definition_category ($options->{'converter'}, $root);
      my @contents = ($parsed_definition_category, {'text' => ': '});
      if ($root->{'extra'}->{'def_parsed_hash'}->{'type'}) {
        push @contents, ($root->{'extra'}->{'def_parsed_hash'}->{'type'},
                         {'text' => ' '});
      }
      push @contents, $root->{'extra'}->{'def_parsed_hash'}->{'name'};

      my $arguments = Texinfo::Common::definition_arguments_content($root);
      if ($arguments) {
        push @contents, {'text' => ' '};
        push @contents, @$arguments;
      }
      push @contents, {'text' => "\n"};
      $result = convert({'contents' => \@contents}, _code_options($options));
    }
    #$result = convert($root->{'args'}->[0], $options) if ($root->{'args'});
  } elsif ($root->{'type'} and $root->{'type'} eq 'menu_entry') {
    foreach my $arg (@{$root->{'args'}}) {
      if ($arg->{'type'} eq 'menu_entry_node') {
        $result .= convert($arg, _code_options($options));
      } else {
        $result .= convert($arg, $options);
      }
    }
  }
  if ($root->{'contents'}) {
    if ($root->{'cmdname'} 
        and $Texinfo::Common::preformatted_code_commands{$root->{'cmdname'}}) {
      $options = _code_options($options);
    }
    if (ref($root->{'contents'}) ne 'ARRAY') {
      cluck "contents not an array($root->{'contents'}).";
    }
    foreach my $content (@{$root->{'contents'}}) {
      $result .= convert($content, $options);
    }
  }
  $result = '{'.$result.'}' 
     if ($root->{'type'} and $root->{'type'} eq 'bracketed'
         and (!$root->{'parent'}->{'type'} or
              ($root->{'parent'}->{'type'} ne 'block_line_arg'
               and $root->{'parent'}->{'type'} ne 'misc_line_arg')));
  return $result;
}

1;

#! /usr/bin/env perl
#
# texixml2texi -- convert Texinfo XML to Texinfo code
#
# Copyright 2012 Free Software Foundation, Inc.
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

use strict;
use Getopt::Long qw(GetOptions);
# for dirname.
use File::Basename;

Getopt::Long::Configure("gnu_getopt");

BEGIN {
  my $dir;
  if ('@datadir@' ne '@' . 'datadir@') {
    my $pkgdatadir = eval '"@datadir@/@PACKAGE@"';
    my $datadir = eval '"@datadir@"';
    $dir = $pkgdatadir;
    unshift @INC, ($dir);
  } elsif (($0 =~ /\.pl$/ and !(defined($ENV{'TEXINFO_DEV_SOURCE'})
     and $ENV{'TEXINFO_DEV_SOURCE'} eq 0)) or $ENV{'TEXINFO_DEV_SOURCE'}) {
    my $srcdir = defined $ENV{'srcdir'} ? $ENV{'srcdir'} : dirname $0;
    my $tpdir = "$srcdir/../tp";
    $dir = "$tpdir/maintain";
    unshift @INC, $tpdir;
  }
  if (defined($dir)) {
    unshift @INC, (
        "$dir/lib/libintl-perl/lib",
        "$dir/lib/Unicode-EastAsianWidth/lib",
        "$dir/lib/Text-Unidecode/lib");
  }
}

use XML::LibXML::Reader;

# gather information on Texinfo XML elements
use Texinfo::Common;
use Texinfo::Convert::XML;

my $debug = 0;
my $result_options = Getopt::Long::GetOptions (
 'debug|d' => \$debug,
);

sub command_with_braces($)
{
  my $command = shift;
  if ($command =~ /^[a-z]/i) {
    return "\@".$command.'{}';
  } else {
    return "\@".$command;
  }
}

my %ignored_elements = (
  'prepend' => 1,
  'formalarg' => 1,
  # not ignored everytime
  'indexterm' => 1,
);

my %elements_end_attributes = (
  'accent' => 1,
  'menunode' => 1,
  'menutitle' => 1,
);

my %element_at_commands;
my %entity_texts = (
  'textldquo' => '``',
  'textrdquo' => "''",
  'textmdash' => '---',
  'textndash' => '--',
  'textrsquo' => "'",
  'textlsquo' => '`',
);

foreach my $command (keys(%Texinfo::Convert::XML::xml_commands_formatting)) {
  my $xml_output = $Texinfo::Convert::XML::xml_commands_formatting{$command};
  if ($xml_output =~ /^&(\w+);$/) {
    my $entity = $1;
    $entity_texts{$entity} = command_with_braces($command);
    #print STDERR "$xml_output $command $1\n";
  } elsif ($xml_output =~ /^<(\w+)/) {
    my $element = $1;
    if ($element eq 'spacecmd') {
      if ($xml_output =~ /^<(\w+) type="(\w+)"/) {
        $element_at_commands{$element}->{"type"}->{$2} 
          = command_with_braces($command); 
      }
    } else {
      $element_at_commands{$element} = command_with_braces($command);
    }
  }
}
$element_at_commands{'accent'} = 0;

my %arg_elements;
foreach my $command (keys(%Texinfo::Convert::XML::commands_args_elements)) {
  my $arg_index = 0;
  foreach my $element_argument (@{$Texinfo::Convert::XML::commands_args_elements{$command}}) {
    $arg_elements{$element_argument} = [$arg_index, $command];
    $arg_index++;
  }
}

my %accent_type_command;
foreach my $accent_command (keys(%Texinfo::Convert::XML::xml_accent_types)) {
  $accent_type_command{$Texinfo::Convert::XML::xml_accent_types{$accent_command}} 
    = $accent_command;
}

my %eat_space_elements;
foreach my $element ('texinfo', 'filename') {
  $eat_space_elements{$element} = 1;
}

my $infile = shift @ARGV;

if (!defined($infile) or $infile !~ /\S/) {
  die "Missing file\n";
}

my $reader = XML::LibXML::Reader->new('location' => $infile,
                                       'expand_entities' => 0,
                                    )
       or die "cannot read $infile\n";

#(my $mydir = $0) =~ s,/[^/]*$,,;  # dir we are in
#my $txi_dtd_libdir = "$mydir";  # find tp relative to $0

sub skip_until_end($$)
{
  my $reader = shift;
  my $name = shift;
  while ($reader->read) {
    if ($reader->nodeType() eq XML_READER_TYPE_END_ELEMENT
        and $reader->name eq $name) {
      return;
    }
  }
}

my $eat_space = 0;
my @commands_with_args_stack;

while ($reader->read) {

  # ============================================================ begin debug
  if ($debug) {
    printf STDERR "(args: @commands_with_args_stack) (eat_space $eat_space) %d %d %s %d", ($reader->depth,
                           $reader->nodeType,
                           $reader->name,
                           $reader->isEmptyElement);
    my $value = '';
    if ($reader->hasValue()) {
      $value = $reader->value();
      $value =~ s/\n/\\n/g;
      print STDERR " |$value|";
    }
    if ($reader->nodeType() eq XML_READER_TYPE_ELEMENT
        and $reader->hasAttributes() 
        and defined($reader->getAttribute('spaces'))) {
      my $spaces = $reader->getAttribute('spaces');
      print STDERR " spaces:$spaces|";
    }
    print STDERR "\n";
  }
  # ============================================================ end debug

  if ($reader->nodeType() eq XML_READER_TYPE_SIGNIFICANT_WHITESPACE
      and $eat_space) {
    $eat_space = 0;
    next;
  } elsif ($reader->nodeType() eq XML_READER_TYPE_TEXT
      or $reader->nodeType() eq XML_READER_TYPE_WHITESPACE
      or $reader->nodeType() eq XML_READER_TYPE_SIGNIFICANT_WHITESPACE 
     ) {
    if ($reader->hasValue()) {
      print $reader->value();
    }
  }
  my $name = $reader->name;
  if ($reader->nodeType() eq XML_READER_TYPE_ELEMENT) {
    if (($name eq 'entry' or $name eq 'indexcommand')
        and $reader->hasAttributes()
        and defined($reader->getAttribute('command'))) {
      $name = $reader->getAttribute('command');
    } elsif ($name eq 'listitem') {
      $name = 'item';
    }
    if ($Texinfo::Convert::XML::commands_args_elements{$name}) {
      push @commands_with_args_stack, 0;
    }
    if (exists $element_at_commands{$name}) {
      if ($name eq 'accent') {
        if ($reader->hasAttributes()) {
          if (defined($reader->getAttribute('type'))) {
            my $command = $accent_type_command{$reader->getAttribute('type')};
            print "\@$command"
              if (defined($command));
          }
          if (!defined($reader->getAttribute('spaces'))
              and !(defined($reader->getAttribute('bracketed'))
                    and $reader->getAttribute('bracketed') eq 'off')) {
            print '{';
          }
        } else {
          print '{';
        }
      } elsif (!ref($element_at_commands{$name})) {
        print $element_at_commands{$name};
      } else {
        my ($attribute) = keys(%{$element_at_commands{$name}});
        if ($reader->hasAttributes() 
            and defined($reader->getAttribute($attribute))) {
          print
            $element_at_commands{$name}->{$attribute}->{$reader->getAttribute($attribute)};
        }
      }
    } elsif (exists($Texinfo::Common::brace_commands{$name})) {
      print "\@${name}{";
      if ($name eq 'verb' and $reader->hasAttributes() 
          and defined($reader->getAttribute('delimiter'))) {
        print $reader->getAttribute('delimiter');
      }
    } elsif (exists($Texinfo::Common::block_commands{$name})) {
      print "\@$name";
      if ($name eq 'macro') {
        if ($reader->hasAttributes() and defined($reader->getAttribute('line'))) {
          print $reader->getAttribute('line');
        }
        print "\n";
      }
    } elsif (defined($Texinfo::Common::misc_commands{$name})) {
      if ($reader->hasAttributes()
          and defined($reader->getAttribute('originalcommand'))) {
        $name = $reader->getAttribute('originalcommand');
      }
      if ($name eq 'documentencoding' and $reader->hasAttributes() 
          and defined($reader->getAttribute('encoding'))) {
        my ($texinfo_encoding, $perl_encoding, $output_encoding)
         = Texinfo::Encoding::encoding_alias($reader->getAttribute('encoding'));

        if (defined($perl_encoding)) {
          if ($debug) {
            print STDERR "Using encoding $perl_encoding\n";
          }
          binmode(STDOUT, ":encoding($perl_encoding)");
        }
      }
      print "\@$name";
      if ($reader->hasAttributes() and defined($reader->getAttribute('line'))) {
        print $reader->getAttribute('line');
      }
      if ($name eq 'set' or $name eq 'clickstyle') {
        skip_until_end($reader, $name);
      }
    } elsif ($arg_elements{$name}) {
      if ($reader->hasAttributes() 
          and defined($reader->getAttribute('automatic'))
          and $reader->getAttribute('automatic') eq 'on') {
        skip_until_end($reader, $name);
        next;
      }
      while ($arg_elements{$name}->[0] 
             and $commands_with_args_stack[-1] < $arg_elements{$name}->[0]) {
        $commands_with_args_stack[-1]++;
        print ',';
      }
    } elsif ($ignored_elements{$name}) {
      my $keep_indexterm = 0;
      if ($name eq 'indexterm') {
        my $node_path = $reader->nodePath();
        if ($node_path =~ m:([a-z]+)/indexterm$:) {
          my $parent = $1;
          if ($parent =~ /^[a-z]?[a-z]index$/ or $parent eq 'indexcommand') {
            $keep_indexterm = 1;
          }
        }
      }
      if (!$keep_indexterm) {
        skip_until_end($reader, $name);
        next;
      }
    } elsif ($name eq 'formattingcommand') {
      if ($reader->hasAttributes()
          and defined($reader->getAttribute('command'))) {
        print '@'.$reader->getAttribute('command');
      }
    # def* automatic 
    } elsif ($reader->hasAttributes() 
          and defined($reader->getAttribute('automatic'))
          and $reader->getAttribute('automatic') eq 'on') {
      skip_until_end($reader, $name);
      # eat the following space
      $reader->read();
    } elsif ($eat_space_elements{$name}) {
      $eat_space = 1;
    } else {
      print STDERR "UNKNOWN $name\n" if ($debug);
    }
    if ($reader->hasAttributes()) {
      if (defined($reader->getAttribute('bracketed'))
          and $reader->getAttribute('bracketed') eq 'on') {
        print '{';
      }
      if (defined($reader->getAttribute('spaces'))) {
        my $spaces = $reader->getAttribute('spaces');
        $spaces =~ s/\\n/\n/g;
        print $spaces;
      }
      if (defined($reader->getAttribute('leadingtext'))) {
        print $reader->getAttribute('leadingtext');
      }
    }
    if ($Texinfo::Common::item_line_commands{$name}
        and $reader->hasAttributes() 
        and defined($reader->getAttribute('commandarg'))) {
      print '@'.$reader->getAttribute('commandarg');
    }
  } elsif ($reader->nodeType() eq XML_READER_TYPE_END_ELEMENT) {
    if ($Texinfo::Convert::XML::commands_args_elements{$name}) {
      pop @commands_with_args_stack;
    }
    if ($reader->hasAttributes()) {
      if (defined($reader->getAttribute('bracketed'))
          and $reader->getAttribute('bracketed') eq 'on') {
        print '}';
      }
    }
    if (exists ($Texinfo::Common::brace_commands{$name})) {
      if ($name eq 'verb' and $reader->hasAttributes() 
          and defined($reader->getAttribute('delimiter'))) {
        print $reader->getAttribute('delimiter');
      }
      print '}';
    } elsif (exists($Texinfo::Common::block_commands{$name})) {
      my $end_spaces;
      if ($reader->hasAttributes() 
          and defined($reader->getAttribute('endspaces'))) {
        $end_spaces = $reader->getAttribute('endspaces');
      }
      $end_spaces = ' ' if (!defined($end_spaces) or $end_spaces eq '');
      print "\@end".$end_spaces."$name";
    } elsif (defined($Texinfo::Common::misc_commands{$name})) {
      if ($Texinfo::Common::root_commands{$name} and $name ne 'node') {
        $eat_space = 1;
      }
    } elsif ($elements_end_attributes{$name}) {
      if ($name eq 'accent') {
        if ($reader->hasAttributes()) {
          if (!defined($reader->getAttribute('spaces'))
              and !(defined($reader->getAttribute('bracketed'))
                    and $reader->getAttribute('bracketed') eq 'off')) {
            print '}';
          }
        } else {
          print '}';
        }
      } elsif ($reader->hasAttributes() 
               and defined($reader->getAttribute('separator'))) {
        print $reader->getAttribute('separator');
      }
    } elsif ($eat_space_elements{$name}) {
      $eat_space = 1;
    } else {
      print STDERR "END UNKNOWN $name\n" if ($debug);
    }
    if ($reader->hasAttributes() 
        and defined($reader->getAttribute('trailingspaces'))) {
      print $reader->getAttribute('trailingspaces');
    }
  } elsif ($reader->nodeType() eq XML_READER_TYPE_ENTITY_REFERENCE) {
    if (defined($entity_texts{$name})) {
      print $entity_texts{$name};
    }
  } elsif ($reader->nodeType() eq XML_READER_TYPE_COMMENT) {
    my $comment;
    if ($reader->hasValue()) {
      $comment = $reader->value();
      $comment =~ s/^ (comment|c)//;
      my $command = $1;
      $comment =~ s/ $//;
      print "\@${command}$comment";
    }
  } elsif ($reader->nodeType() eq XML_READER_TYPE_DOCUMENT_TYPE) {
    $eat_space = 1;
  }
}

1;

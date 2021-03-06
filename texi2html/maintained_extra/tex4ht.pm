# -*-perl-*-

#+##############################################################################
#
# tex4ht.pm: use tex4ht to convert tex to html
#
#    Copyright (C) 2005, 2007, 2009 Free Software Foundation, Inc.
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
# Originally written by Patrice Dumas.
#
#-##############################################################################
# To customize the command and the options, you could set
# $Texi2HTML::TeX4HT::STYLE_MATH to latex/tex
# $Texi2HTML::TeX4HT::STYLE_TEX to latex/texi
# and/or change
# $Texi2HTML::TeX4HT::tex4ht_command_math 
#    and $Texi2HTML::TeX4HT::tex4ht_options_math
# $Texi2HTML::TeX4HT::tex4ht_command_tex 
#    and $Texi2HTML::TeX4HT::tex4ht_options_tex

use strict;

if (defined($OUTPUT_FORMAT) and $OUTPUT_FORMAT eq 'html')
{
push @command_handler_init, \&Texi2HTML::TeX4HT::tex4ht_init;
push @command_handler_process, \&Texi2HTML::TeX4HT::tex4ht_process;
# do it once here to have something ready for special regions formatting
push @command_handler_process, \&Texi2HTML::TeX4HT::tex4ht_output;
# do it once more if the file was modified (for example see mediawiki.pm)
push @command_handler_output, \&Texi2HTML::TeX4HT::tex4ht_output;
push @command_handler_finish, \&Texi2HTML::TeX4HT::tex4ht_finish;

$command_handler{'math'} =
     { 'init' => \&Texi2HTML::TeX4HT::tex4ht_to_latex,
       'expand' => \&Texi2HTML::TeX4HT::tex4ht_do_tex
     };
$command_handler{'tex'} =
     { 'init' => \&Texi2HTML::TeX4HT::tex4ht_to_latex,
       'expand' => \&Texi2HTML::TeX4HT::tex4ht_do_tex
     };
}


{
use Cwd;

package Texi2HTML::TeX4HT;

use vars qw(
$STYLE_MATH
$STYLE_TEX
$tex4ht_command_math
$tex4ht_command_tex
$tex4ht_options_math
$tex4ht_options_tex
);

$STYLE_MATH = 'texi' if (!defined($STYLE_MATH));
$STYLE_TEX = 'tex' if (!defined($STYLE_TEX));

if (!defined($tex4ht_command_math))
{
   $tex4ht_command_math = 'httexi';
   $tex4ht_command_math = 'htlatex' if ($STYLE_MATH eq 'latex');
   $tex4ht_command_math = 'httex' if ($STYLE_MATH eq 'tex');
}
if (!defined($tex4ht_command_tex))
{
   $tex4ht_command_tex = 'httex';
   $tex4ht_command_tex = 'htlatex' if ($STYLE_TEX eq 'latex');
   $tex4ht_command_tex = 'httexi' if ($STYLE_TEX eq 'texi');
}

my %commands = ();

my $tex4ht_initial_dir;
my $tex4ht_out_dir;
my $tex4ht_latex_failed = 0;
my %tex4ht_results;

sub tex4ht_init
{
  # set file names
  $tex4ht_initial_dir = Cwd::abs_path;
  if ($Texi2HTML::Config::null_device_file{$Texi2HTML::THISDOC{'filename'}->{'top'}})
  {
    # when output is a null device we skip entirely the tex4ht stuff.
    $tex4ht_latex_failed = 1;
    return;
  }
  $tex4ht_out_dir = "$Texi2HTML::THISDOC{'destination_directory'}";
  $tex4ht_out_dir = './' if (!defined($tex4ht_out_dir) or $tex4ht_out_dir =~ /^\s*$/);
  my $tex4ht_basename = "$Texi2HTML::THISDOC{'file_base_name'}_tex4ht";
  %tex4ht_results = ();
  $tex4ht_latex_failed = 0;
  # this initialization doesn't seems to be needed, but it is cleaner anyway
  %commands = ();
  $commands{'math'}->{'style'} = $STYLE_MATH;
  $commands{'tex'}->{'style'} = $STYLE_TEX;
  $commands{'math'}->{'exec'} = $tex4ht_command_math;
  $commands{'tex'}->{'exec'} = $tex4ht_command_tex;
  foreach my $command ('math', 'tex')
  {
    my $style = $commands{$command}->{'style'};
    $commands{$command}->{'basename'} = $tex4ht_basename . "_$command";
    my $suffix = '.tex';
    $suffix = '.texi' if ($style eq 'texi');
    $commands{$command}->{'basefile'} = $commands{$command}->{'basename'} . $suffix;
    $commands{$command}->{'html_file'} = $commands{$command}->{'basename'} . '.html';
    $commands{$command}->{'rfile'} = $tex4ht_out_dir . $commands{$command}->{'basefile'};
    my $rfile = $commands{$command}->{'rfile'};
    local *TEX4HT_TEXFILE;
    unless (open (*TEX4HT_TEXFILE, ">$rfile"))  
    {
       main::document_warn ("t2h_tex4ht error opening $rfile: $!");
       $tex4ht_latex_failed = 1;
       return;
    }
    $commands{$command}->{'handle'} = *TEX4HT_TEXFILE;
  }
  foreach my $command ('math', 'tex')
  {
    $commands{$command}->{'counter'} = 0;
    my $style = $commands{$command}->{'style'};
    my $fh = $commands{$command}->{'handle'};
    my $comment = '@c';
    $comment = '%' if ($style ne 'texi');
    $comment .= " Automatically generated\n";
    if ($style eq 'texi')
    {
      print $fh "\\input texinfo
\@setfilename $commands{$command}->{'basename'}.info\n";
      print $fh "$comment";
    }
    else
    {
      print $fh "$comment";
      if ($style eq 'latex')
      {
        print $fh "\\documentstyle{article}\n\\begin{document}\n";
      }
      elsif ($style eq 'tex')
      {
        print $fh "\\csname tex4ht\\endcsname\n";
      }
    }
  }
  $Texi2HTML::THISDOC{'extensions'}->{'tex4ht'} = 1;
}

sub tex4ht_to_latex
{
  my $command = shift;
  my $text = shift;
  my $counter = shift;
  my $style = $commands{$command}->{'style'};
  my $fh = $commands{$command}->{'handle'};

  # write to tex file
  my $before_comment_open = "\@verbatim\n\n";
  my $after_comment_open = "\n\@end verbatim\n";
  my $before_comment_close = "\@verbatim\n";
  my $after_comment_close = "\n\n\@end verbatim\n";
 
  if ($style ne 'texi')
  {
    $before_comment_open = "\\HCode{\\Hnewline \\Hnewline ";
    $after_comment_open = "\\Hnewline}\n";
    $before_comment_close = "\\HCode{\\Hnewline ";
    $after_comment_close = "\\Hnewline \\Hnewline}\n";
  }
  
  my $begin_comment = "<!-- tex4ht_begin $commands{$command}->{'basename'} $command $counter -->";
  print $fh "$before_comment_open$begin_comment$after_comment_open";
  if ($command eq 'tex')
  {
     print $fh $text;
  }
  elsif ($command eq 'math')
  {
     if ($style eq 'texi')
     {
         print $fh '@math{' . $text . "}\n";
     }
     else
     {
         print $fh "\\IgnorePar \$" . $text . "\$";
     }
  }
  my $end_comment = "<!-- tex4ht_end $commands{$command}->{'basename'} $command $counter -->";
  print $fh "$before_comment_close$end_comment$after_comment_close";
  $commands{$command}->{'counter'}++;
  return 1;
}

sub tex4ht_process
{
  foreach my $command ('math', 'tex')
  {
     tex4ht_finish_latex($command);
  }
  unless (chdir $tex4ht_out_dir)
  {
     main::document_warn ("t2h_tex4ht chdir to $tex4ht_out_dir failed");
     $tex4ht_latex_failed = 1;
     return;
  }
  print STDERR "cwd($tex4ht_out_dir):" . Cwd::cwd() ."\n" if (Texi2HTML::Config::get_conf('VERBOSE'));

  foreach my $command ('math', 'tex')
  {
     tex4ht_process_command($command);
  }
  tex4ht_return_to_dir();
}

my $tex4ht_output_counter;

sub tex4ht_output
{
  $tex4ht_output_counter = 0;
  unless (chdir $tex4ht_out_dir)
  {
     main::document_warn ("t2h_tex4ht chdir to $tex4ht_out_dir failed");
     $tex4ht_latex_failed = 1;
     return;
  }
  foreach my $command ('math', 'tex')
  {
     tex4ht_output_command($command);
  }
  tex4ht_return_to_dir();
}

sub tex4ht_finish_latex
{
#print STDERR "$style $tex4ht_latex_failed $tex4ht_counter\n";
  my $command = shift;
  return if ($tex4ht_latex_failed);

  my $style = $commands{$command}->{'style'};
  my $fh = $commands{$command}->{'handle'};
  # finish the tex file
  if ($style eq 'latex')
  {
     print $fh "\\end{document}\n";
  }
  elsif ($style eq 'tex')
  {
     print $fh "\n\\bye\n";
  }
  else
  {
     print $fh "\n\@bye\n";
  }
  close ($fh);
}

sub tex4ht_process_command($)
{
  my $command = shift;
  return unless ($commands{$command}->{'counter'});
  main::document_warn ("t2h_tex4ht $commands{$command}->{'basefile'} missing") unless (-f $commands{$command}->{'basefile'});
  my $style = $commands{$command}->{'style'};
  # now run tex4ht
  my $options = '';
  $options = $tex4ht_options_math if (($style eq 'math') and defined($tex4ht_options_math));
  $options = $tex4ht_options_tex if (($style eq 'tex') and defined($tex4ht_options_tex));
  my $cmd = "$commands{$command}->{'exec'} $commands{$command}->{'basefile'} $options";
  print STDERR "tex4ht command: $cmd\n" if (Texi2HTML::Config::get_conf('VERBOSE'));
  if (system($cmd))
  {
     main::document_warn ("t2h_tex4ht command: $cmd failed");
     tex4ht_return_to_dir();
     $tex4ht_latex_failed = 1;
     return;
  }
  # this have to be done during the 'process' phase, in 'output' it is 
  # too late.
  push @{$Texi2HTML::THISDOC{'css_import_lines'}}, "\@import \"$commands{$command}->{'basename'}.css\";\n";
}

sub tex4ht_output_command($)
{
  my $command = shift;
  return unless ($commands{$command}->{'counter'});
  # extract the html from the file created by tex4ht
  my $html_basefile = $commands{$command}->{'html_file'};
  unless (open (TEX4HT_HTMLFILE, $html_basefile))
  {
     main::document_warn ("t2h_tex4ht error opening $html_basefile: $!");
     tex4ht_return_to_dir();
     $tex4ht_latex_failed = 1;
     return;
  }
  my $got_count = 0;
  my $line;
  while ($line = <TEX4HT_HTMLFILE>)
  {
     #print STDERR "$html_basefile: while $line";
     if ($line =~ /!-- tex4ht_begin $commands{$command}->{'basename'} (\w+) (\d+) --/)
     {
        my $command = $1;
        my $count = $2;
        my $text = '';
        my $end_found = 0;
        while ($line = <TEX4HT_HTMLFILE>)
        {
           #print STDERR "while search $command $count $line";
           if ($line =~ /!-- tex4ht_end $commands{$command}->{'basename'} $command $count --/)
           {
              $got_count++;
              chomp($text);
              $tex4ht_results{"${command}_$count"} = $text;
              $end_found = 1;
              last;
           }
           else
           {
              $text .= $line;
           }
        }
        unless ($end_found)
        {
           main::document_warn ("t2h_tex4ht: end of $command $count not found");
        }
     }
  }
  if ($got_count != $commands{$command}->{'counter'} and (Texi2HTML::Config::get_conf('VERBOSE')))
  {
     main::document_warn ("t2h_tex4ht: got $got_count for $commands{$command}->{'counter'} items entered");
  }
  close (TEX4HT_HTMLFILE);

}

sub tex4ht_return_to_dir
{
  unless (chdir $tex4ht_initial_dir)
  {
     die "* t2h_tex4ht unable to return to the initial dir\n";
  }
}

sub tex4ht_do_tex
{
  my $command = shift;
  my $counter = shift;
  # return the resulting html 
  if (exists ($tex4ht_results{"${command}_$counter"}) and defined($tex4ht_results{"${command}_$counter"}))
  {
     $tex4ht_output_counter++;
     return $tex4ht_results{"${command}_$counter"};
  }
  else
  {
    main::document_warn ("t2h_tex4ht: cannot find text to output for $command number $counter");
    return '';
  }
}

sub tex4ht_finish
{ 
  my $tex4ht_in_counter = 0;
  foreach my $command (keys(%commands))
  {
    $tex4ht_in_counter += $commands{$command}->{'counter'};
  }
  if (($tex4ht_output_counter != $tex4ht_in_counter) and (Texi2HTML::Config::get_conf('VERBOSE')))
  {
     main::document_warn ("t2h_tex4ht: output $tex4ht_output_counter for $tex4ht_in_counter items entered");
  }
}

}
1;  

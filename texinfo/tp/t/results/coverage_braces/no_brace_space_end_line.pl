use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'no_brace_space_end_line'} = {
  'contents' => [
    {
      'contents' => [
        {
          'args' => [
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'c'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_arg'
            }
          ],
          'cmdname' => 'code',
          'contents' => [],
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 1,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '.
'
        }
      ],
      'parent' => {},
      'type' => 'paragraph'
    },
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line'
    },
    {
      'contents' => [
        {
          'cmdname' => 'code',
          'contents' => [],
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => 'Arg.'
        }
      ],
      'parent' => {},
      'type' => 'paragraph'
    }
  ],
  'type' => 'text_root'
};
$result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[0];
$result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[0];
$result_trees{'no_brace_space_end_line'}{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[0];
$result_trees{'no_brace_space_end_line'}{'contents'}[0]{'parent'} = $result_trees{'no_brace_space_end_line'};
$result_trees{'no_brace_space_end_line'}{'contents'}[1]{'parent'} = $result_trees{'no_brace_space_end_line'};
$result_trees{'no_brace_space_end_line'}{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[2];
$result_trees{'no_brace_space_end_line'}{'contents'}[2]{'contents'}[1]{'parent'} = $result_trees{'no_brace_space_end_line'}{'contents'}[2];
$result_trees{'no_brace_space_end_line'}{'contents'}[2]{'parent'} = $result_trees{'no_brace_space_end_line'};

$result_texis{'no_brace_space_end_line'} = '@code{c}.

@codeArg.';


$result_texts{'no_brace_space_end_line'} = 'c.

Arg.';

$result_errors{'no_brace_space_end_line'} = [
  {
    'error_line' => ':4: @code expected braces
',
    'file_name' => '',
    'line_nr' => 4,
    'macro' => '',
    'text' => '@code expected braces',
    'type' => 'error'
  }
];


1;

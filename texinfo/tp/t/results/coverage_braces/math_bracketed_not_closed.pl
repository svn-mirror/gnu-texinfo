use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

use utf8;

$result_trees{'math_bracketed_not_closed'} = {
  'contents' => [
    {
      'contents' => [
        {
          'args' => [
            {
              'contents' => [
                {
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => 'x^i'
                    }
                  ],
                  'parent' => {},
                  'type' => 'bracketed'
                },
                {
                  'parent' => {},
                  'text' => '\\over'
                },
                {
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => '\\tan '
                    }
                  ],
                  'parent' => {},
                  'type' => 'bracketed'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_context'
            }
          ],
          'cmdname' => 'math',
          'contents' => [],
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 1,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
      'parent' => {},
      'type' => 'paragraph'
    }
  ],
  'type' => 'text_root'
};
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'}{'contents'}[0];
$result_trees{'math_bracketed_not_closed'}{'contents'}[0]{'parent'} = $result_trees{'math_bracketed_not_closed'};

$result_texis{'math_bracketed_not_closed'} = '@math{{x^i}\\over{\\tan }}';


$result_texts{'math_bracketed_not_closed'} = '{x^i}\\over{\\tan }';

$result_errors{'math_bracketed_not_closed'} = [
  {
    'error_line' => ':1: Misplaced {
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => 'Misplaced {',
    'type' => 'error'
  },
  {
    'error_line' => ':1: @math missing close brace
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => '@math missing close brace',
    'type' => 'error'
  }
];


1;

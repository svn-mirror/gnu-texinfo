use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

use utf8;

$result_trees{'end_of_line_end_file'} = {
  'contents' => [
    {
      'cmdname' => 'deffn',
      'contents' => [
        {
          'args' => [
            {
              'contents' => [
                {
                  'extra' => {
                    'command' => {}
                  },
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'category deffn_name arguments '
                }
              ],
              'parent' => {},
              'type' => 'block_line_arg'
            }
          ],
          'extra' => {
            'def_command' => 'deffn',
            'original_def_cmdname' => 'deffn'
          },
          'parent' => {},
          'type' => 'def_line'
        }
      ],
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 1,
        'macro' => ''
      },
      'parent' => {}
    }
  ],
  'type' => 'text_root'
};
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'end_of_line_end_file'}{'contents'}[0];
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0];
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'end_of_line_end_file'}{'contents'}[0];
$result_trees{'end_of_line_end_file'}{'contents'}[0]{'parent'} = $result_trees{'end_of_line_end_file'};

$result_texis{'end_of_line_end_file'} = '@deffn category deffn_name arguments @end deffn
';


$result_texts{'end_of_line_end_file'} = '';

$result_errors{'end_of_line_end_file'} = [
  {
    'error_line' => ':1: No matching `@end deffn\'
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => 'No matching `@end deffn\'',
    'type' => 'error'
  }
];


1;

use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'defindex_too_much_args'} = {
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
              'text' => 'chose    machin'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'defindex',
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
$result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'defindex_too_much_args'}{'contents'}[0];
$result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0];
$result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0];
$result_trees{'defindex_too_much_args'}{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'defindex_too_much_args'}{'contents'}[0];
$result_trees{'defindex_too_much_args'}{'contents'}[0]{'parent'} = $result_trees{'defindex_too_much_args'};

$result_texis{'defindex_too_much_args'} = '@defindex chose    machin';


$result_texts{'defindex_too_much_args'} = '';

$result_errors{'defindex_too_much_args'} = [
  {
    'error_line' => ':1: Bad argument to @defindex: chose    machin
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => 'Bad argument to @defindex: chose    machin',
    'type' => 'error'
  }
];


1;
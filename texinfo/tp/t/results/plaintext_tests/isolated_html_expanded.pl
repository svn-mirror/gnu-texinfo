use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'isolated_html_expanded'} = {
  'contents' => [
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line'
    },
    {
      'cmdname' => 'html',
      'contents' => [
        {
          'extra' => {
            'command' => {}
          },
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'parent' => {},
          'text' => 'html',
          'type' => 'raw'
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'last_raw_newline'
        }
      ],
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 2,
        'macro' => ''
      },
      'parent' => {}
    },
    {
      'extra' => {
        'command' => {}
      },
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line_after_command'
    }
  ],
  'type' => 'text_root'
};
$result_trees{'isolated_html_expanded'}{'contents'}[0]{'parent'} = $result_trees{'isolated_html_expanded'};
$result_trees{'isolated_html_expanded'}{'contents'}[1]{'contents'}[0]{'extra'}{'command'} = $result_trees{'isolated_html_expanded'}{'contents'}[1];
$result_trees{'isolated_html_expanded'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'isolated_html_expanded'}{'contents'}[1];
$result_trees{'isolated_html_expanded'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'isolated_html_expanded'}{'contents'}[1];
$result_trees{'isolated_html_expanded'}{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'isolated_html_expanded'}{'contents'}[1];
$result_trees{'isolated_html_expanded'}{'contents'}[1]{'parent'} = $result_trees{'isolated_html_expanded'};
$result_trees{'isolated_html_expanded'}{'contents'}[2]{'extra'}{'command'} = $result_trees{'isolated_html_expanded'}{'contents'}[1];
$result_trees{'isolated_html_expanded'}{'contents'}[2]{'parent'} = $result_trees{'isolated_html_expanded'};

$result_texis{'isolated_html_expanded'} = '
@html
html
@end html
';


$result_texts{'isolated_html_expanded'} = '
';

$result_errors{'isolated_html_expanded'} = [];



$result_converted{'plaintext'}->{'isolated_html_expanded'} = 'html
';

1;

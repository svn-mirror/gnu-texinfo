use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted);

$result_trees{'ctrl'} = {
  'contents' => [
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line'
    },
    {
      'contents' => [
        {
          'args' => [
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'A'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_arg'
            }
          ],
          'cmdname' => 'ctrl',
          'contents' => [],
          'extra' => {
            'brace_command_contents' => [
              [
                {}
              ]
            ]
          },
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
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
          'parent' => {},
          'text' => 'With '
        },
        {
          'args' => [
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'B'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_arg'
            }
          ],
          'cmdname' => 'ctrl',
          'contents' => [],
          'extra' => {
            'brace_command_contents' => [
              [
                {}
              ]
            ]
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
    }
  ],
  'type' => 'text_root'
};
$result_trees{'ctrl'}{'contents'}[0]{'parent'} = $result_trees{'ctrl'};
$result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[1]{'contents'}[0];
$result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'extra'}{'brace_command_contents'}[0][0] = $result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0];
$result_trees{'ctrl'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[1];
$result_trees{'ctrl'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'ctrl'}{'contents'}[1];
$result_trees{'ctrl'}{'contents'}[1]{'parent'} = $result_trees{'ctrl'};
$result_trees{'ctrl'}{'contents'}[2]{'parent'} = $result_trees{'ctrl'};
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[3];
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'args'}[0];
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'ctrl'}{'contents'}[3]{'contents'}[1];
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'extra'}{'brace_command_contents'}[0][0] = $result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[0];
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[1]{'parent'} = $result_trees{'ctrl'}{'contents'}[3];
$result_trees{'ctrl'}{'contents'}[3]{'contents'}[2]{'parent'} = $result_trees{'ctrl'}{'contents'}[3];
$result_trees{'ctrl'}{'contents'}[3]{'parent'} = $result_trees{'ctrl'};

$result_texis{'ctrl'} = '
@ctrl{A}

With @ctrl{B}.
';


$result_texts{'ctrl'} = '
A

With B.
';

$result_errors{'ctrl'} = [
  {
    'error_line' => ':2: warning: @ctrl is obsolete.
',
    'file_name' => '',
    'line_nr' => 2,
    'macro' => '',
    'text' => '@ctrl is obsolete.',
    'type' => 'warning'
  },
  {
    'error_line' => ':4: warning: @ctrl is obsolete.
',
    'file_name' => '',
    'line_nr' => 4,
    'macro' => '',
    'text' => '@ctrl is obsolete.',
    'type' => 'warning'
  }
];



$result_converted{'plaintext'}->{'ctrl'} = '
A

   With B.
';

1;

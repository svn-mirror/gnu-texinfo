use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

$result_trees{'space_at_menu_end'} = {
  'contents' => [
    {
      'contents' => [],
      'parent' => {},
      'type' => 'text_root'
    },
    {
      'args' => [
        {
          'contents' => [
            {
              'parent' => {},
              'text' => ' ',
              'type' => 'empty_spaces_after_command'
            },
            {
              'parent' => {},
              'text' => 'Top'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'spaces_at_end'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'node',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
        },
        {
          'cmdname' => 'menu',
          'contents' => [
            {
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line_after_command'
            },
            {
              'args' => [
                {
                  'parent' => {},
                  'text' => '* ',
                  'type' => 'menu_entry_leading_text'
                },
                {
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => '(out)'
                    }
                  ],
                  'parent' => {},
                  'type' => 'menu_entry_node'
                },
                {
                  'parent' => {},
                  'text' => '::',
                  'type' => 'menu_entry_separator'
                },
                {
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => '
'
                    }
                  ],
                  'parent' => {},
                  'type' => 'menu_entry_description'
                }
              ],
              'extra' => {
                'menu_entry_node' => {
                  'manual_content' => [
                    {
                      'parent' => {},
                      'text' => 'out'
                    }
                  ]
                }
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 4,
                'macro' => ''
              },
              'parent' => {},
              'type' => 'menu_entry'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'after_description_line'
            },
            {
              'contents' => [],
              'parent' => {},
              'type' => 'menu_comment'
            },
            {
              'args' => [
                {
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => ' ',
                      'type' => 'empty_spaces_after_command'
                    },
                    {
                      'parent' => {},
                      'text' => 'menu'
                    },
                    {
                      'parent' => {},
                      'text' => '
',
                      'type' => 'spaces_at_end'
                    }
                  ],
                  'parent' => {},
                  'type' => 'misc_line_arg'
                }
              ],
              'cmdname' => 'end',
              'extra' => {
                'command' => {},
                'command_argument' => 'menu',
                'text_arg' => 'menu'
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 6,
                'macro' => ''
              },
              'parent' => {}
            }
          ],
          'extra' => {
            'end_command' => {}
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 3,
            'macro' => ''
          },
          'parent' => {}
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
              'text' => 'A para.
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        }
      ],
      'extra' => {
        'node_content' => [
          {}
        ],
        'nodes_manuals' => [
          {
            'node_content' => [],
            'normalized' => 'Top'
          }
        ],
        'normalized' => 'Top'
      },
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 1,
        'macro' => ''
      },
      'parent' => {}
    }
  ],
  'type' => 'document_root'
};
$result_trees{'space_at_menu_end'}{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'};
$result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[1]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[2]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[3];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[3]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'extra'}{'menu_entry_node'}{'manual_content'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'args'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[3]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'args'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'extra'}{'command'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'extra'}{'end_command'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'contents'}[4];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[3];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'contents'}[3]{'parent'} = $result_trees{'space_at_menu_end'}{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'extra'}{'node_content'}[0] = $result_trees{'space_at_menu_end'}{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'space_at_menu_end'}{'contents'}[1]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'space_at_menu_end'}{'contents'}[1]{'extra'}{'node_content'};
$result_trees{'space_at_menu_end'}{'contents'}[1]{'parent'} = $result_trees{'space_at_menu_end'};

$result_texis{'space_at_menu_end'} = '@node Top

@menu
* (out)::

@end menu

A para.
';


$result_texts{'space_at_menu_end'} = '
* (out)::


A para.
';

$result_sectioning{'space_at_menu_end'} = {};

$result_nodes{'space_at_menu_end'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  },
  'menus' => [
    {
      'cmdname' => 'menu',
      'extra' => {
        'end_command' => {
          'cmdname' => 'end',
          'extra' => {
            'command' => {},
            'command_argument' => 'menu',
            'text_arg' => 'menu'
          }
        }
      }
    }
  ],
  'node_up' => {
    'extra' => {
      'manual_content' => [
        {
          'text' => 'dir'
        }
      ]
    }
  }
};
$result_nodes{'space_at_menu_end'}{'menus'}[0]{'extra'}{'end_command'}{'extra'}{'command'} = $result_nodes{'space_at_menu_end'}{'menus'}[0];

$result_menus{'space_at_menu_end'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  }
};

$result_errors{'space_at_menu_end'} = [];



$result_converted{'plaintext'}->{'space_at_menu_end'} = '
* Menu:

* (out)::

A para.
';

1;

use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'top_node_up_url'} = [
  {
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
                'extra' => {
                  'command' => {}
                },
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
        'contents' => [],
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
      },
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
                'text' => 'internal top node up'
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
        'cmdname' => 'top',
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
                'extra' => {
                  'command' => {}
                },
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
                        'text' => 'first'
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
                        'contents' => [
                          {
                            'parent' => {},
                            'text' => '
'
                          }
                        ],
                        'parent' => {},
                        'type' => 'preformatted'
                      }
                    ],
                    'parent' => {},
                    'type' => 'menu_entry_description'
                  }
                ],
                'extra' => {
                  'menu_entry_description' => {},
                  'menu_entry_node' => {
                    'node_content' => [
                      {}
                    ],
                    'normalized' => 'first'
                  }
                },
                'line_nr' => {
                  'file_name' => '',
                  'line_nr' => 5,
                  'macro' => ''
                },
                'parent' => {},
                'type' => 'menu_entry'
              },
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
              'line_nr' => 4,
              'macro' => ''
            },
            'parent' => {}
          },
          {
            'parent' => {},
            'text' => '
',
            'type' => 'empty_line'
          }
        ],
        'extra' => {
          'misc_content' => [
            {}
          ]
        },
        'level' => 0,
        'line_nr' => {
          'file_name' => '',
          'line_nr' => 2,
          'macro' => ''
        },
        'parent' => {}
      }
    ],
    'extra' => {
      'element_command' => {},
      'node' => {},
      'section' => {}
    },
    'type' => 'element'
  },
  {
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
                'text' => 'first'
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
        'contents' => [],
        'extra' => {
          'node_content' => [
            {}
          ],
          'nodes_manuals' => [
            {
              'node_content' => [],
              'normalized' => 'first'
            }
          ],
          'normalized' => 'first'
        },
        'line_nr' => {
          'file_name' => '',
          'line_nr' => 8,
          'macro' => ''
        },
        'parent' => {}
      }
    ],
    'element_prev' => {},
    'extra' => {
      'element_command' => {},
      'node' => {}
    },
    'type' => 'element'
  }
];
$result_trees{'top_node_up_url'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'extra'}{'node_content'}[0] = $result_trees{'top_node_up_url'}[0]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1]{'extra'}{'node_content'};
$result_trees{'top_node_up_url'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3]{'contents'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'extra'}{'menu_entry_description'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[3];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'extra'}{'menu_entry_node'}{'node_content'}[0] = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'args'}[1]{'contents'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'extra'}{'end_command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'top_node_up_url'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[0];
$result_trees{'top_node_up_url'}[0]{'extra'}{'element_command'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'extra'}{'node'} = $result_trees{'top_node_up_url'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[0]{'extra'}{'section'} = $result_trees{'top_node_up_url'}[0]{'contents'}[2];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'extra'}{'node_content'}[0] = $result_trees{'top_node_up_url'}[1]{'contents'}[0]{'args'}[0]{'contents'}[1];
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0]{'extra'}{'node_content'};
$result_trees{'top_node_up_url'}[1]{'contents'}[0]{'parent'} = $result_trees{'top_node_up_url'}[1];
$result_trees{'top_node_up_url'}[1]{'element_prev'} = $result_trees{'top_node_up_url'}[0];
$result_trees{'top_node_up_url'}[1]{'extra'}{'element_command'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0];
$result_trees{'top_node_up_url'}[1]{'extra'}{'node'} = $result_trees{'top_node_up_url'}[1]{'contents'}[0];

$result_texis{'top_node_up_url'} = '@node Top
@top internal top node up

@menu
* first::
@end menu

@node first
';


$result_texts{'top_node_up_url'} = 'internal top node up
********************

* first::

';

$result_sectioning{'top_node_up_url'} = {
  'level' => -1,
  'section_childs' => [
    {
      'cmdname' => 'top',
      'extra' => {
        'associated_node' => {
          'cmdname' => 'node',
          'extra' => {
            'normalized' => 'Top'
          }
        }
      },
      'level' => 0,
      'section_up' => {}
    }
  ]
};
$result_sectioning{'top_node_up_url'}{'section_childs'}[0]{'section_up'} = $result_sectioning{'top_node_up_url'};

$result_nodes{'top_node_up_url'} = {
  'cmdname' => 'node',
  'extra' => {
    'associated_section' => {
      'cmdname' => 'top',
      'extra' => {},
      'level' => 0
    },
    'normalized' => 'Top'
  },
  'menu_child' => {
    'cmdname' => 'node',
    'extra' => {
      'normalized' => 'first'
    },
    'node_prev' => {},
    'node_up' => {}
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
  'node_next' => {},
  'node_up' => {
    'extra' => {
      'normalized' => 'GNU-manuals',
      'top_node_up' => {}
    },
    'type' => 'top_node_up'
  }
};
$result_nodes{'top_node_up_url'}{'menu_child'}{'node_prev'} = $result_nodes{'top_node_up_url'};
$result_nodes{'top_node_up_url'}{'menu_child'}{'node_up'} = $result_nodes{'top_node_up_url'};
$result_nodes{'top_node_up_url'}{'menus'}[0]{'extra'}{'end_command'}{'extra'}{'command'} = $result_nodes{'top_node_up_url'}{'menus'}[0];
$result_nodes{'top_node_up_url'}{'node_next'} = $result_nodes{'top_node_up_url'}{'menu_child'};
$result_nodes{'top_node_up_url'}{'node_up'}{'extra'}{'top_node_up'} = $result_nodes{'top_node_up_url'};

$result_menus{'top_node_up_url'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  },
  'menu_child' => {
    'cmdname' => 'node',
    'extra' => {
      'normalized' => 'first'
    },
    'menu_up' => {},
    'menu_up_hash' => {
      'Top' => 1
    }
  }
};
$result_menus{'top_node_up_url'}{'menu_child'}{'menu_up'} = $result_menus{'top_node_up_url'};

$result_errors{'top_node_up_url'} = [];


$result_elements{'top_node_up_url'} = [
  {
    'extra' => {
      'directions' => {
        'Forward' => {
          'extra' => {
            'directions' => {
              'Back' => {},
              'FastBack' => {},
              'NodeBack' => {},
              'NodePrev' => {},
              'NodeUp' => {},
              'This' => {},
              'Up' => {}
            },
            'element_command' => {
              'cmdname' => 'node',
              'extra' => {
                'normalized' => 'first'
              },
              'menu_up' => {
                'cmdname' => 'node',
                'extra' => {
                  'normalized' => 'Top'
                },
                'menu_child' => {}
              },
              'menu_up_hash' => {
                'Top' => 1
              }
            },
            'node' => {}
          },
          'type' => 'element'
        },
        'NodeForward' => {},
        'NodeNext' => {},
        'NodeUp' => {
          'extra' => {
            'normalized' => 'GNU-manuals',
            'top_node_up' => {}
          },
          'type' => 'top_node_up'
        },
        'This' => {}
      },
      'element_command' => {},
      'node' => {},
      'section' => {
        'cmdname' => 'top',
        'extra' => {},
        'level' => 0
      }
    },
    'type' => 'element'
  },
  {}
];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'Back'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'FastBack'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'NodeBack'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'NodePrev'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'NodeUp'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'This'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'directions'}{'Up'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'}{'menu_up'}{'menu_child'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'node'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'NodeForward'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'NodeNext'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'NodeUp'}{'extra'}{'top_node_up'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'}{'menu_up'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'This'} = $result_elements{'top_node_up_url'}[0];
$result_elements{'top_node_up_url'}[0]{'extra'}{'element_command'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'}{'menu_up'};
$result_elements{'top_node_up_url'}[0]{'extra'}{'node'} = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'}{'extra'}{'element_command'}{'menu_up'};
$result_elements{'top_node_up_url'}[1] = $result_elements{'top_node_up_url'}[0]{'extra'}{'directions'}{'Forward'};



$result_directions_text{'top_node_up_url'} = 'element: @node Top
  Forward: @node first
  NodeForward: @node first
  NodeNext: @node first
  NodeUp: No associated command (type top_node_up)
  This: @node Top
element: @node first
  Back: @node Top
  FastBack: @node Top
  NodeBack: @node Top
  NodePrev: @node Top
  NodeUp: @node Top
  This: @node first
  Up: @node Top
';


$result_converted{'info'}->{'top_node_up_url'} = 'This is , produced by makeinfo version 4.13 from .


File: ,  Node: Top,  Next: first,  Up: GNU (GNU\'s Not Unix) manuals

internal top node up
********************

* Menu:

* first::


File: ,  Node: first,  Prev: Top,  Up: Top



Tag Table:
Node: Top52
Node: first186

End Tag Table
';


$result_converted{'html'}->{'top_node_up_url'} = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Created by texi2html, http://www.gnu.org/software/texinfo/ -->
<head>
<title>internal top node up</title>

<meta name="description" content="internal top node up">
<meta name="keywords" content="internal top node up">
<meta name="resource-type" content="document">
<meta name="distribution" content="global">
<meta name="Generator" content="texi2html">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="#Top" rel="start" title="Top">
<style type="text/css">
<!--
a.summary-letter {text-decoration: none}
blockquote.smallquotation {font-size: smaller}
div.display {margin-left: 3.2em}
div.example {margin-left: 3.2em}
div.lisp {margin-left: 3.2em}
div.smalldisplay {margin-left: 3.2em}
div.smallexample {margin-left: 3.2em}
div.smalllisp {margin-left: 3.2em}
pre.display {font-family: serif}
pre.format {font-family: serif}
pre.menu-comment {font-family: serif}
pre.menu-preformatted {font-family: serif}
pre.smalldisplay {font-family: serif; font-size: smaller}
pre.smallexample {font-size: smaller}
pre.smallformat {font-family: serif; font-size: smaller}
pre.smalllisp {font-size: smaller}
span.nocodebreak {white-space:pre}
span.nolinebreak {white-space:pre}
span.roman {font-family:serif; font-weight:normal}
span.sansserif {font-family:sans-serif; font-weight:normal}
ul.no-bullet {list-style: none}
-->
</style>


</head>

<body lang="en" bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000">

<a name="Top"></a>
<div class="header">
<p>
Next: <a href="#first" accesskey="n" rel="next">first</a>, Up: <a href="http://www.gnu.org/manual/" accesskey="u" rel="up"><acronym title="GNU&rsquo;s Not Unix">GNU</acronym> (<acronym>GNU</acronym>\'s Not Unix) manuals</a> &nbsp; </p>
</div>
<a name="internal-top-node-up"></a>
<h1 class="top">internal top node up</h1>

<table class="menu" border="0" cellspacing="0">
<tr><td align="left" valign="top">&bull; <a href="#first" accesskey="1">first</a>:</td><td>&nbsp;&nbsp;</td><td align="left" valign="top">
</td></tr>
</table>

<hr>
<a name="first"></a>
<div class="header">
<p>
Previous: <a href="#Top" accesskey="p" rel="previous">Top</a>, Up: <a href="#Top" accesskey="u" rel="up">Top</a> &nbsp; </p>
</div>
<h3 class="node-heading">first</h3>
<hr>
<p>


</p>
</body>
</html>
';

1;
use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

$result_trees{'printindex_index_entry_in_copying'} = {
  'contents' => [
    {
      'contents' => [
        {
          'cmdname' => 'copying',
          'contents' => [
            {
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line_after_command'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line'
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
                      'text' => 'Copying this document'
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
              'cmdname' => 'cindex',
              'extra' => {
                'index_entry' => {
                  'command' => {},
                  'content' => [
                    {}
                  ],
                  'index_at_command' => 'cindex',
                  'index_name' => 'cp',
                  'index_prefix' => 'c',
                  'key' => 'Copying this document',
                  'number' => 1,
                  'region' => {}
                },
                'misc_content' => []
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
                      'text' => 'cp'
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
              'cmdname' => 'printindex',
              'extra' => {
                'misc_args' => [
                  'cp'
                ]
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 5,
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
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 1,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
        }
      ],
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
          'contents' => [
            {
              'parent' => {},
              'text' => 'Top.
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        },
        {
          'cmdname' => 'insertcopying',
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
'
        },
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
                      'text' => 'chapter'
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
                  'node_content' => [
                    {}
                  ],
                  'normalized' => 'chapter'
                }
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 15,
                'macro' => ''
              },
              'parent' => {},
              'type' => 'menu_entry'
            }
          ],
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 14,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
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
        'line_nr' => 9,
        'macro' => ''
      },
      'parent' => {}
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
              'text' => 'chapter'
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
            'normalized' => 'chapter'
          }
        ],
        'normalized' => 'chapter'
      },
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 18,
        'macro' => ''
      },
      'parent' => {}
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
              'text' => 'Chapter'
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
      'cmdname' => 'chapter',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
        },
        {
          'cmdname' => 'insertcopying',
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
'
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
      'level' => 1,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 19,
        'macro' => ''
      },
      'number' => 1,
      'parent' => {}
    }
  ],
  'type' => 'document_root'
};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'command'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'content'}[0] = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'region'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'extra'}{'misc_content'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'content'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[3]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'contents'}[5]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[3]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[4]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[3]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'extra'}{'menu_entry_node'}{'node_content'}[0] = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'args'}[1]{'contents'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[5]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[6]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'contents'}[7]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'extra'}{'node_content'}[0] = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'extra'}{'node_content'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'extra'}{'node_content'}[0] = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'extra'}{'node_content'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'};
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'contents'}[1]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'contents'}[2]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'contents'}[3]{'parent'} = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'extra'}{'misc_content'}[0] = $result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'args'}[0]{'contents'}[1];
$result_trees{'printindex_index_entry_in_copying'}{'contents'}[3]{'parent'} = $result_trees{'printindex_index_entry_in_copying'};

$result_texis{'printindex_index_entry_in_copying'} = '@copying

@cindex Copying this document

@printindex cp

@end copying

@node Top

Top.
@insertcopying

@menu
* chapter::
@end menu

@node chapter
@chapter Chapter

@insertcopying

';


$result_texts{'printindex_index_entry_in_copying'} = '

Top.


* chapter::

1 Chapter
*********



';

$result_sectioning{'printindex_index_entry_in_copying'} = {
  'level' => 0,
  'section_childs' => [
    {
      'cmdname' => 'chapter',
      'extra' => {
        'associated_node' => {
          'cmdname' => 'node',
          'extra' => {
            'normalized' => 'chapter'
          }
        }
      },
      'level' => 1,
      'number' => 1,
      'section_up' => {}
    }
  ]
};
$result_sectioning{'printindex_index_entry_in_copying'}{'section_childs'}[0]{'section_up'} = $result_sectioning{'printindex_index_entry_in_copying'};

$result_nodes{'printindex_index_entry_in_copying'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  },
  'menu_child' => {
    'cmdname' => 'node',
    'extra' => {
      'associated_section' => {
        'cmdname' => 'chapter',
        'extra' => {},
        'level' => 1,
        'number' => 1
      },
      'normalized' => 'chapter'
    },
    'node_prev' => {},
    'node_up' => {}
  },
  'menus' => [
    {
      'cmdname' => 'menu'
    }
  ],
  'node_next' => {},
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
$result_nodes{'printindex_index_entry_in_copying'}{'menu_child'}{'node_prev'} = $result_nodes{'printindex_index_entry_in_copying'};
$result_nodes{'printindex_index_entry_in_copying'}{'menu_child'}{'node_up'} = $result_nodes{'printindex_index_entry_in_copying'};
$result_nodes{'printindex_index_entry_in_copying'}{'node_next'} = $result_nodes{'printindex_index_entry_in_copying'}{'menu_child'};

$result_menus{'printindex_index_entry_in_copying'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  },
  'menu_child' => {
    'cmdname' => 'node',
    'extra' => {
      'normalized' => 'chapter'
    },
    'menu_up' => {},
    'menu_up_hash' => {
      'Top' => 1
    }
  }
};
$result_menus{'printindex_index_entry_in_copying'}{'menu_child'}{'menu_up'} = $result_menus{'printindex_index_entry_in_copying'};

$result_errors{'printindex_index_entry_in_copying'} = [];



$result_converted{'info'}->{'printindex_index_entry_in_copying'} = 'This is , produced by makeinfo version 4.13 from .

 [index ]
* Menu:



File: ,  Node: Top,  Next: chapter,  Up: (dir)

Top.

 [index ]
* Menu:

* Copying this document:                 Top.                   (line 5)

* Menu:

* chapter::


File: ,  Node: chapter,  Prev: Top,  Up: Top

1 Chapter
*********

 [index ]
* Menu:

* Copying this document:                 chapter.               (line 6)



Tag Table:
Node: Top74
Node: chapter247

End Tag Table
';

1;

use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'sectioning_part_appendix'} = {
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
              'text' => 'top'
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
      'cmdname' => 'chapter',
      'contents' => [
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
        'line_nr' => 3,
        'macro' => ''
      },
      'number' => 1,
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
              'text' => 'section'
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
      'cmdname' => 'section',
      'contents' => [
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
      'level' => 2,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 5,
        'macro' => ''
      },
      'number' => '1.1',
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
              'text' => 'subsection'
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
      'cmdname' => 'subsection',
      'contents' => [
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
      'level' => 3,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 7,
        'macro' => ''
      },
      'number' => '1.1.1',
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
              'text' => 'subsubsection'
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
      'cmdname' => 'subsubsection',
      'contents' => [
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
      'level' => 4,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 9,
        'macro' => ''
      },
      'number' => '1.1.1.1',
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
              'text' => 'part'
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
      'cmdname' => 'part',
      'contents' => [
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
        'line_nr' => 11,
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
              'text' => 'chapter in part'
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
        }
      ],
      'extra' => {
        'associated_part' => {},
        'misc_content' => [
          {}
        ]
      },
      'level' => 1,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 13,
        'macro' => ''
      },
      'number' => 2,
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
              'text' => 'second chapter in part'
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
        'line_nr' => 15,
        'macro' => ''
      },
      'number' => 3,
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
              'text' => 'unnumbered'
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
      'cmdname' => 'unnumbered',
      'contents' => [
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
        'line_nr' => 17,
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
              'text' => 'appendix'
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
      'cmdname' => 'appendix',
      'contents' => [
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
      'number' => 'A',
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
              'text' => 'appendixsec'
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
      'cmdname' => 'appendixsec',
      'contents' => [],
      'extra' => {
        'misc_content' => [
          {}
        ]
      },
      'level' => 2,
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 21,
        'macro' => ''
      },
      'number' => 'A.1',
      'parent' => {}
    }
  ],
  'type' => 'document_root'
};
$result_trees{'sectioning_part_appendix'}{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[2];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[3];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[3]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[3]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[4];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[4]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[4]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[5];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[5]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[5]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[6]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[6]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[7];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'extra'}{'associated_part'} = $result_trees{'sectioning_part_appendix'}{'contents'}[6];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[7]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[7]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[8];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[8]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[8]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[9];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[9]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[9]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[10];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[10]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[10]{'parent'} = $result_trees{'sectioning_part_appendix'};
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'sectioning_part_appendix'}{'contents'}[11];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'parent'} = $result_trees{'sectioning_part_appendix'}{'contents'}[11];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'extra'}{'misc_content'}[0] = $result_trees{'sectioning_part_appendix'}{'contents'}[11]{'args'}[0]{'contents'}[1];
$result_trees{'sectioning_part_appendix'}{'contents'}[11]{'parent'} = $result_trees{'sectioning_part_appendix'};

$result_texis{'sectioning_part_appendix'} = '@top top

@chapter chapter

@section section

@subsection subsection

@subsubsection subsubsection

@part part

@chapter chapter in part

@chapter second chapter in part

@unnumbered unnumbered

@appendix appendix

@appendixsec appendixsec
';


$result_texts{'sectioning_part_appendix'} = 'top
***

1 chapter
*********

1.1 section
===========

1.1.1 subsection
----------------

1.1.1.1 subsubsection
.....................

part
****

2 chapter in part
*****************

3 second chapter in part
************************

unnumbered
**********

Appendix A appendix
*******************

A.1 appendixsec
===============
';

$result_sectioning{'sectioning_part_appendix'} = {
  'level' => -1,
  'section_childs' => [
    {
      'cmdname' => 'top',
      'extra' => {},
      'level' => 0,
      'section_childs' => [
        {
          'cmdname' => 'chapter',
          'extra' => {},
          'level' => 1,
          'number' => 1,
          'section_childs' => [
            {
              'cmdname' => 'section',
              'extra' => {},
              'level' => 2,
              'number' => '1.1',
              'section_childs' => [
                {
                  'cmdname' => 'subsection',
                  'extra' => {},
                  'level' => 3,
                  'number' => '1.1.1',
                  'section_childs' => [
                    {
                      'cmdname' => 'subsubsection',
                      'extra' => {},
                      'level' => 4,
                      'number' => '1.1.1.1',
                      'section_up' => {}
                    }
                  ],
                  'section_up' => {}
                }
              ],
              'section_up' => {}
            }
          ],
          'section_up' => {},
          'toplevel_prev' => {}
        }
      ],
      'section_up' => {}
    },
    {
      'cmdname' => 'part',
      'extra' => {
        'part_associated_section' => {
          'cmdname' => 'chapter',
          'extra' => {
            'associated_part' => {}
          },
          'level' => 1,
          'number' => 2,
          'section_up' => {},
          'toplevel_prev' => {}
        }
      },
      'level' => 0,
      'section_childs' => [
        {},
        {
          'cmdname' => 'chapter',
          'extra' => {},
          'level' => 1,
          'number' => 3,
          'section_prev' => {},
          'section_up' => {},
          'toplevel_prev' => {}
        },
        {
          'cmdname' => 'unnumbered',
          'extra' => {},
          'level' => 1,
          'section_prev' => {},
          'section_up' => {},
          'toplevel_prev' => {}
        },
        {
          'cmdname' => 'appendix',
          'extra' => {},
          'level' => 1,
          'number' => 'A',
          'section_childs' => [
            {
              'cmdname' => 'appendixsec',
              'extra' => {},
              'level' => 2,
              'number' => 'A.1',
              'section_up' => {}
            }
          ],
          'section_prev' => {},
          'section_up' => {},
          'toplevel_prev' => {}
        }
      ],
      'section_prev' => {},
      'section_up' => {}
    }
  ]
};
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0]{'toplevel_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'};
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'}{'extra'}{'associated_part'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'}{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'}{'toplevel_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0]{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[0] = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'};
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[1]{'section_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'};
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[1]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[1]{'toplevel_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'extra'}{'part_associated_section'};
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[2]{'section_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[2]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[2]{'toplevel_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[3]{'section_childs'}[0]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[3];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[3]{'section_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[2];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[3]{'section_up'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[3]{'toplevel_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_childs'}[2];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_prev'} = $result_sectioning{'sectioning_part_appendix'}{'section_childs'}[0];
$result_sectioning{'sectioning_part_appendix'}{'section_childs'}[1]{'section_up'} = $result_sectioning{'sectioning_part_appendix'};

$result_errors{'sectioning_part_appendix'} = [];



$result_converted{'xml'}->{'sectioning_part_appendix'} = '<top>
<sectiontitle>top</sectiontitle>

</top>
<chapter>
<sectiontitle>chapter</sectiontitle>

<section>
<sectiontitle>section</sectiontitle>

<subsection>
<sectiontitle>subsection</sectiontitle>

<subsubsection>
<sectiontitle>subsubsection</sectiontitle>

</subsubsection>
</subsection>
</section>
</chapter>
<part>
<sectiontitle>part</sectiontitle>

<chapter>
<sectiontitle>chapter in part</sectiontitle>

</chapter>
<chapter>
<sectiontitle>second chapter in part</sectiontitle>

</chapter>
<unnumbered>
<sectiontitle>unnumbered</sectiontitle>

</unnumbered>
<appendix>
<sectiontitle>appendix</sectiontitle>

<appendixsec>
<sectiontitle>appendixsec</sectiontitle>
</appendixsec>
</appendix>
</part>
';

1;
use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'top_part_chapter'} = [
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
      }
    ],
    'extra' => {
      'element_command' => {},
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
          'line_nr' => 3,
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
        'contents' => [],
        'extra' => {
          'associated_part' => {},
          'misc_content' => [
            {}
          ]
        },
        'level' => 1,
        'line_nr' => {
          'file_name' => '',
          'line_nr' => 5,
          'macro' => ''
        },
        'number' => 1,
        'parent' => {}
      }
    ],
    'element_prev' => {},
    'extra' => {
      'element_command' => {},
      'section' => {}
    },
    'type' => 'element'
  }
];
$result_trees{'top_part_chapter'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[0];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'top_part_chapter'}[0]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_part_chapter'}[0];
$result_trees{'top_part_chapter'}[0]{'extra'}{'element_command'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[0]{'extra'}{'section'} = $result_trees{'top_part_chapter'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'extra'}{'misc_content'}[0] = $result_trees{'top_part_chapter'}[1]{'contents'}[0]{'args'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'extra'}{'associated_part'} = $result_trees{'top_part_chapter'}[1]{'contents'}[0];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'top_part_chapter'}[1]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'contents'}[1]{'parent'} = $result_trees{'top_part_chapter'}[1];
$result_trees{'top_part_chapter'}[1]{'element_prev'} = $result_trees{'top_part_chapter'}[0];
$result_trees{'top_part_chapter'}[1]{'extra'}{'element_command'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1];
$result_trees{'top_part_chapter'}[1]{'extra'}{'section'} = $result_trees{'top_part_chapter'}[1]{'contents'}[1];

$result_texis{'top_part_chapter'} = '@top top

@part part

@chapter chapter 
';


$result_texts{'top_part_chapter'} = 'top
***

part
****

1 chapter
*********
';

$result_sectioning{'top_part_chapter'} = {
  'level' => -1,
  'section_childs' => [
    {
      'cmdname' => 'top',
      'extra' => {},
      'level' => 0,
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
          'number' => 1,
          'section_up' => {}
        }
      },
      'level' => 0,
      'section_childs' => [
        {}
      ],
      'section_prev' => {},
      'section_up' => {}
    }
  ]
};
$result_sectioning{'top_part_chapter'}{'section_childs'}[0]{'section_up'} = $result_sectioning{'top_part_chapter'};
$result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'extra'}{'part_associated_section'}{'extra'}{'associated_part'} = $result_sectioning{'top_part_chapter'}{'section_childs'}[1];
$result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'extra'}{'part_associated_section'}{'section_up'} = $result_sectioning{'top_part_chapter'}{'section_childs'}[1];
$result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'section_childs'}[0] = $result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'extra'}{'part_associated_section'};
$result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'section_prev'} = $result_sectioning{'top_part_chapter'}{'section_childs'}[0];
$result_sectioning{'top_part_chapter'}{'section_childs'}[1]{'section_up'} = $result_sectioning{'top_part_chapter'};

$result_errors{'top_part_chapter'} = [];


$result_elements{'top_part_chapter'} = [
  {
    'extra' => {
      'directions' => {
        'FastForward' => {
          'extra' => {
            'directions' => {
              'Back' => {},
              'FastBack' => {},
              'This' => {},
              'Up' => {}
            },
            'element_command' => {
              'cmdname' => 'chapter',
              'extra' => {
                'associated_part' => {
                  'cmdname' => 'part',
                  'extra' => {},
                  'level' => 0
                }
              },
              'level' => 1,
              'number' => 1
            },
            'section' => {}
          },
          'type' => 'element'
        },
        'Forward' => {},
        'Next' => {},
        'This' => {}
      },
      'element_command' => {
        'cmdname' => 'top',
        'extra' => {},
        'level' => 0
      },
      'section' => {}
    },
    'type' => 'element'
  },
  {}
];
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'directions'}{'Back'} = $result_elements{'top_part_chapter'}[0];
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'directions'}{'FastBack'} = $result_elements{'top_part_chapter'}[0];
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'directions'}{'This'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'};
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'directions'}{'Up'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'};
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'section'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'}{'extra'}{'element_command'};
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'Forward'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'};
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'Next'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'};
$result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'This'} = $result_elements{'top_part_chapter'}[0];
$result_elements{'top_part_chapter'}[0]{'extra'}{'section'} = $result_elements{'top_part_chapter'}[0]{'extra'}{'element_command'};
$result_elements{'top_part_chapter'}[1] = $result_elements{'top_part_chapter'}[0]{'extra'}{'directions'}{'FastForward'};



$result_directions_text{'top_part_chapter'} = 'element: @top top
  FastForward: @chapter chapter
  Forward: @chapter chapter
  Next: @chapter chapter
  This: @top top
element: @chapter chapter
  Back: @top top
  FastBack: @top top
  This: @chapter chapter
  Up: @chapter chapter
';

1;

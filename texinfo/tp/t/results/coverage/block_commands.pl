use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'block_commands'} = {
  'contents' => [
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line'
    },
    {
      'cmdname' => 'group',
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
          'contents' => [
            {
              'parent' => {},
              'text' => 'in group
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
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
                  'text' => 'group'
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
            'command_argument' => 'group',
            'spaces_after_command' => {},
            'text_arg' => 'group'
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 4,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
      'extra' => {
        'end_command' => {},
        'spaces_after_command' => {}
      },
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 2,
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
              'extra' => {
                'command' => {}
              },
              'parent' => {},
              'text' => ' ',
              'type' => 'empty_spaces_after_command'
            },
            {
              'parent' => {},
              'text' => 'warning'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'space_at_end_block_command'
            }
          ],
          'parent' => {},
          'type' => 'block_line_arg'
        }
      ],
      'cmdname' => 'quotation',
      'contents' => [
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'in quotation
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
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
                  'text' => 'quotation'
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
            'command_argument' => 'quotation',
            'spaces_after_command' => {},
            'text_arg' => 'quotation'
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 8,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
      'extra' => {
        'block_command_line_contents' => [
          [
            {}
          ]
        ],
        'end_command' => {},
        'spaces_after_command' => {}
      },
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 6,
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
              'extra' => {
                'command' => {}
              },
              'parent' => {},
              'text' => ' ',
              'type' => 'empty_spaces_after_command'
            },
            {
              'parent' => {},
              'text' => 'a float'
            }
          ],
          'parent' => {},
          'type' => 'block_line_arg'
        },
        {
          'contents' => [
            {
              'text' => ' ',
              'type' => 'empty_spaces_before_argument'
            },
            {
              'parent' => {},
              'text' => 'b float'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'space_at_end_block_command'
            }
          ],
          'parent' => {},
          'type' => 'block_line_arg'
        }
      ],
      'cmdname' => 'float',
      'contents' => [
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'In float
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
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => 'in caption
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
                      'text' => 'in caption'
                    }
                  ],
                  'parent' => {},
                  'type' => 'paragraph'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_context'
            }
          ],
          'cmdname' => 'caption',
          'contents' => [],
          'extra' => {
            'float' => {},
            'spaces_before_argument' => {
              'parent' => {},
              'text' => '',
              'type' => 'empty_spaces_before_argument'
            }
          },
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
'
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
                  'text' => 'float'
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
            'command_argument' => 'float',
            'spaces_after_command' => {},
            'text_arg' => 'float'
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 17,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
      'extra' => {
        'block_command_line_contents' => [
          [
            {}
          ],
          [
            {}
          ]
        ],
        'caption' => {},
        'end_command' => {},
        'node_content' => [
          {}
        ],
        'normalized' => 'b-float',
        'spaces_after_command' => {},
        'type' => {
          'content' => [
            {}
          ],
          'normalized' => 'a-float'
        }
      },
      'line_nr' => {
        'file_name' => '',
        'line_nr' => 10,
        'macro' => ''
      },
      'number' => 1,
      'parent' => {}
    }
  ],
  'type' => 'text_root'
};
$result_trees{'block_commands'}{'contents'}[0]{'parent'} = $result_trees{'block_commands'};
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[1]{'extra'}{'end_command'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[2];
$result_trees{'block_commands'}{'contents'}[1]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[1]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[1]{'parent'} = $result_trees{'block_commands'};
$result_trees{'block_commands'}{'contents'}[2]{'parent'} = $result_trees{'block_commands'};
$result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[3]{'extra'}{'block_command_line_contents'}[0][0] = $result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[3]{'extra'}{'end_command'} = $result_trees{'block_commands'}{'contents'}[3]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[3]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[3]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[3]{'parent'} = $result_trees{'block_commands'};
$result_trees{'block_commands'}{'contents'}[4]{'parent'} = $result_trees{'block_commands'};
$result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[1]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'args'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[1]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'args'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'args'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[2];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'extra'}{'float'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'extra'}{'spaces_before_argument'}{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[3]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[4]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'parent'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'extra'}{'command'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'contents'}[5]{'parent'} = $result_trees{'block_commands'}{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'block_command_line_contents'}[0][0] = $result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'block_command_line_contents'}[1][0] = $result_trees{'block_commands'}{'contents'}[5]{'args'}[1]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'caption'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[3];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'end_command'} = $result_trees{'block_commands'}{'contents'}[5]{'contents'}[5];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'node_content'}[0] = $result_trees{'block_commands'}{'contents'}[5]{'args'}[1]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'spaces_after_command'} = $result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[0];
$result_trees{'block_commands'}{'contents'}[5]{'extra'}{'type'}{'content'}[0] = $result_trees{'block_commands'}{'contents'}[5]{'args'}[0]{'contents'}[1];
$result_trees{'block_commands'}{'contents'}[5]{'parent'} = $result_trees{'block_commands'};

$result_texis{'block_commands'} = '
@group
in group
@end group

@quotation warning
in quotation
@end quotation

@float a float, b float
In float


@caption{in caption

in caption}
@end float
';


$result_texts{'block_commands'} = '
in group

warning
in quotation

a float, b float
In float



';

$result_errors{'block_commands'} = [];


$result_floats{'block_commands'} = {
  'a-float' => [
    {
      'cmdname' => 'float',
      'extra' => {
        'caption' => {
          'cmdname' => 'caption',
          'extra' => {
            'float' => {},
            'spaces_before_argument' => {
              'text' => '',
              'type' => 'empty_spaces_before_argument'
            }
          }
        },
        'end_command' => {
          'cmdname' => 'end',
          'extra' => {
            'command' => {},
            'command_argument' => 'float',
            'text_arg' => 'float'
          }
        },
        'normalized' => 'b-float',
        'type' => {
          'content' => [
            {
              'text' => 'a float'
            }
          ],
          'normalized' => 'a-float'
        }
      },
      'number' => 1
    }
  ]
};
$result_floats{'block_commands'}{'a-float'}[0]{'extra'}{'caption'}{'extra'}{'float'} = $result_floats{'block_commands'}{'a-float'}[0];
$result_floats{'block_commands'}{'a-float'}[0]{'extra'}{'end_command'}{'extra'}{'command'} = $result_floats{'block_commands'}{'a-float'}[0];



$result_converted{'plaintext'}->{'block_commands'} = 'in group

     warning: in quotation

In float

a float 1: in caption

in caption
';


$result_converted{'html_text'}->{'block_commands'} = '
<p>in group
</p>
<blockquote>
<p><b>warning:</b> in quotation
</p></blockquote>

<div class="float"><a name="b-float"></a>
<p>In float
</p>


<div class="float-caption"><p><strong>a float 1: </strong>in caption
</p>
<p>in caption</p></div></div>';


$result_converted{'xml'}->{'block_commands'} = '
<group>
<para>in group
</para></group>

<quotation spaces=" "><quotationtype>warning</quotationtype>
<para>in quotation
</para></quotation>

<float name="b-float" type="a-float" spaces=" "><floattype>a float</floattype><floatname spaces=" ">b float</floatname>
<para>In float
</para>

<caption><para>in caption
</para>
<para>in caption</para></caption>
</float>
';


$result_converted{'docbook'}->{'block_commands'} = '
<para>in group
</para>
<warning><para>in quotation
</para></warning>
<anchor id="b-float"/>
<para>In float
</para>


';

1;

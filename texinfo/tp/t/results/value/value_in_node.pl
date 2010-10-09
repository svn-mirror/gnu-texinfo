use vars qw(%result_texts %result_trees %result_errors);

$result_trees{'value_in_node'} = {
  'contents' => [
    {
      'args' => [
        {
          'parent' => {},
          'text' => 'node1',
          'type' => 'misc_arg'
        },
        {
          'parent' => {},
          'text' => 'Node 1',
          'type' => 'misc_arg'
        }
      ],
      'cmdname' => 'set',
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
              'text' => 'Top'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => '(dir)'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => '(dir)'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => '(dir)
'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'node',
      'parent' => {},
      'remaining_args' => 1
    },
    {
      'args' => [
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Expansion in Node Names
'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'top',
      'parent' => {}
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
                  'text' => 'Node 1  '
                }
              ],
              'parent' => {},
              'type' => 'menu_entry_node'
            },
            {
              'parent' => {},
              'text' => '::
',
              'type' => 'menu_entry_separator'
            },
            {
              'contents' => [],
              'parent' => {},
              'type' => 'menu_entry_description'
            }
          ],
          'parent' => {},
          'type' => 'menu_entry'
        }
      ],
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
              'text' => 'Node 1'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Top'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Top
'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'node',
      'parent' => {},
      'remaining_args' => 1
    },
    {
      'args' => [
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Chapter 1
'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'chapter',
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
          'parent' => {},
          'text' => 'sec1',
          'type' => 'misc_arg'
        },
        {
          'parent' => {},
          'text' => 'Section 1.1',
          'type' => 'misc_arg'
        }
      ],
      'cmdname' => 'set',
      'parent' => {}
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
                  'text' => 'Section 1.1'
                }
              ],
              'parent' => {},
              'type' => 'menu_entry_node'
            },
            {
              'parent' => {},
              'text' => '::
',
              'type' => 'menu_entry_separator'
            },
            {
              'contents' => [],
              'parent' => {},
              'type' => 'menu_entry_description'
            }
          ],
          'parent' => {},
          'type' => 'menu_entry'
        }
      ],
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
              'text' => 'Section 1.1'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Node 1'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Node 1
'
            }
          ],
          'parent' => {},
          'type' => 'misc_line_arg'
        }
      ],
      'cmdname' => 'node',
      'parent' => {},
      'remaining_args' => 1
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
          'args' => [
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'Node 1'
                }
              ],
              'parent' => {},
              'type' => 'brace_command_arg'
            }
          ],
          'cmdname' => 'xref',
          'contents' => [],
          'parent' => {},
          'remaining_args' => 4
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
  ]
};
$result_trees{'value_in_node'}{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[0]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[0]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[1]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2]{'args'}[1];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[2]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2]{'args'}[2];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[2]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2]{'args'}[3];
$result_trees{'value_in_node'}{'contents'}[2]{'args'}[3]{'parent'} = $result_trees{'value_in_node'}{'contents'}[2];
$result_trees{'value_in_node'}{'contents'}[2]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[3]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[3];
$result_trees{'value_in_node'}{'contents'}[3]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[4]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[1];
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[2]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'args'}[3]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[5]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[5];
$result_trees{'value_in_node'}{'contents'}[5]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[6]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[2]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7]{'args'}[2];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[2]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7]{'args'}[3];
$result_trees{'value_in_node'}{'contents'}[7]{'args'}[3]{'parent'} = $result_trees{'value_in_node'}{'contents'}[7];
$result_trees{'value_in_node'}{'contents'}[7]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[8]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[8]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[8]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[8];
$result_trees{'value_in_node'}{'contents'}[8]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[9]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[10]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[10];
$result_trees{'value_in_node'}{'contents'}[10]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[10];
$result_trees{'value_in_node'}{'contents'}[10]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[11]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[1]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[1];
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[2]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'args'}[3]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[12]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[12];
$result_trees{'value_in_node'}{'contents'}[12]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[13]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[2]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14]{'args'}[2];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[2]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[3]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14]{'args'}[3];
$result_trees{'value_in_node'}{'contents'}[14]{'args'}[3]{'parent'} = $result_trees{'value_in_node'}{'contents'}[14];
$result_trees{'value_in_node'}{'contents'}[14]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[15]{'parent'} = $result_trees{'value_in_node'};
$result_trees{'value_in_node'}{'contents'}[16]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[16]{'contents'}[0]{'args'}[0];
$result_trees{'value_in_node'}{'contents'}[16]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[16]{'contents'}[0];
$result_trees{'value_in_node'}{'contents'}[16]{'contents'}[0]{'parent'} = $result_trees{'value_in_node'}{'contents'}[16];
$result_trees{'value_in_node'}{'contents'}[16]{'contents'}[1]{'parent'} = $result_trees{'value_in_node'}{'contents'}[16];
$result_trees{'value_in_node'}{'contents'}[16]{'parent'} = $result_trees{'value_in_node'};

$result_texts{'value_in_node'} = '@set node1 Node 1

@node Top, (dir), (dir), (dir)
@top Expansion in Node Names

@menu
* Node 1  ::
@end menu

@node Node 1, , Top, Top
@chapter Chapter 1

@set sec1 Section 1.1

@menu
* Section 1.1::
@end menu

@node Section 1.1, , Node 1, Node 1

@xref{Node 1}.
';

$result_errors{'value_in_node'} = [];



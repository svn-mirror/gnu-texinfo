use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

use utf8;

$result_trees{'defx_after_comment'} = {
  'contents' => [
    {
      'cmdname' => 'deffn',
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
                  'text' => 'fset '
                },
                {
                  'args' => [
                    {
                      'contents' => [
                        {
                          'parent' => {},
                          'text' => 'i'
                        }
                      ],
                      'parent' => {},
                      'type' => 'brace_command_arg'
                    }
                  ],
                  'cmdname' => 'var',
                  'contents' => [],
                  'line_nr' => {
                    'file_name' => '',
                    'line_nr' => 1,
                    'macro' => ''
                  },
                  'parent' => {}
                },
                {
                  'parent' => {},
                  'text' => ' a g
'
                }
              ],
              'parent' => {},
              'type' => 'block_line_arg'
            }
          ],
          'extra' => {
            'def_args' => [
              [
                'category',
                {
                  'text' => 'fset'
                }
              ],
              [
                'spaces',
                {
                  'text' => ' ',
                  'type' => 'spaces'
                }
              ],
              [
                'name',
                {}
              ],
              [
                'spaces',
                {
                  'text' => ' ',
                  'type' => 'spaces'
                }
              ],
              [
                'arg',
                {
                  'text' => 'a'
                }
              ],
              [
                'spaces',
                {
                  'text' => ' ',
                  'type' => 'spaces'
                }
              ],
              [
                'arg',
                {
                  'text' => 'g'
                }
              ]
            ],
            'def_command' => 'deffn',
            'def_parsed_hash' => {
              'category' => {},
              'name' => {}
            },
            'index_entry' => {
              'command' => {},
              'content' => [
                {}
              ],
              'index_at_command' => 'deffn',
              'index_name' => 'fn',
              'index_prefix' => 'f',
              'number' => 1
            },
            'original_def_cmdname' => 'deffn'
          },
          'parent' => {},
          'type' => 'def_line'
        },
        {
          'args' => [
            {
              'parent' => {},
              'text' => ' comment
',
              'type' => 'misc_arg'
            }
          ],
          'cmdname' => 'c',
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
                  'contents' => [
                    {
                      'parent' => {},
                      'text' => 'truc'
                    }
                  ],
                  'parent' => {},
                  'type' => 'bracketed'
                },
                {
                  'parent' => {},
                  'text' => ' bidulr machin...
'
                }
              ],
              'parent' => {},
              'type' => 'misc_line_arg'
            }
          ],
          'cmdname' => 'deffnx',
          'extra' => {
            'def_args' => [
              [
                'category',
                {
                  'contents' => [],
                  'parent' => {},
                  'type' => 'bracketed_def_content'
                }
              ],
              [
                'spaces',
                {
                  'text' => ' ',
                  'type' => 'spaces'
                }
              ],
              [
                'name',
                {
                  'text' => 'bidulr'
                }
              ],
              [
                'spaces',
                {
                  'text' => ' ',
                  'type' => 'spaces'
                }
              ],
              [
                'arg',
                {
                  'text' => 'machin...'
                }
              ]
            ],
            'def_command' => 'deffn',
            'def_parsed_hash' => {
              'category' => {},
              'name' => {}
            },
            'index_entry' => {
              'command' => {},
              'content' => [
                {}
              ],
              'index_at_command' => 'deffn',
              'index_name' => 'fn',
              'index_prefix' => 'f',
              'number' => 2
            },
            'original_def_cmdname' => 'deffnx'
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 3,
            'macro' => ''
          },
          'parent' => {},
          'type' => 'def_line'
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
                  'text' => 'deffn'
                }
              ],
              'parent' => {},
              'type' => 'misc_line_arg'
            }
          ],
          'cmdname' => 'end',
          'extra' => {
            'command' => {},
            'command_argument' => 'deffn',
            'text_arg' => 'deffn'
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
        'end_command' => {}
      },
      'line_nr' => {},
      'parent' => {}
    }
  ],
  'type' => 'text_root'
};
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[3]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'def_args'}[2][1] = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'def_parsed_hash'}{'category'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'def_args'}[0][1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'def_parsed_hash'}{'name'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'index_entry'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'extra'}{'index_entry'}{'content'}[0] = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_args'}[0][1]{'contents'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'contents'};
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_args'}[0][1]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_parsed_hash'}{'category'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_args'}[0][1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_parsed_hash'}{'name'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_args'}[2][1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'index_entry'}{'content'}[0] = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'extra'}{'def_args'}[2][1];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[2]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'extra'}{'command'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3]{'parent'} = $result_trees{'defx_after_comment'}{'contents'}[0];
$result_trees{'defx_after_comment'}{'contents'}[0]{'extra'}{'end_command'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[3];
$result_trees{'defx_after_comment'}{'contents'}[0]{'line_nr'} = $result_trees{'defx_after_comment'}{'contents'}[0]{'contents'}[0]{'args'}[0]{'contents'}[2]{'line_nr'};
$result_trees{'defx_after_comment'}{'contents'}[0]{'parent'} = $result_trees{'defx_after_comment'};

$result_texis{'defx_after_comment'} = '@deffn fset @var{i} a g
@c comment
@deffnx {truc} bidulr machin...
@end deffn';


$result_texts{'defx_after_comment'} = 'fset: i a g
truc: bidulr machin...
';

$result_errors{'defx_after_comment'} = [
  {
    'error_line' => ':1: Entry for index `fn\' outside of any node
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => 'Entry for index `fn\' outside of any node',
    'type' => 'error'
  },
  {
    'error_line' => ':3: Entry for index `fn\' outside of any node
',
    'file_name' => '',
    'line_nr' => 3,
    'macro' => '',
    'text' => 'Entry for index `fn\' outside of any node',
    'type' => 'error'
  }
];



$result_converted{'plaintext'}->{'defx_after_comment'} = ' -- fset: I a g
 -- truc: bidulr machin...
';

1;

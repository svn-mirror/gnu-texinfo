use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'accents_in_var_enable_encoding'} = {
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
              'text' => 'utf-8'
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
      'cmdname' => 'documentencoding',
      'extra' => {
        'encoding_name' => 'utf-8',
        'perl_encoding' => 'utf-8-strict',
        'spaces_after_command' => {},
        'text_arg' => 'utf-8'
      },
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
                  'text' => 'AA'
                },
                {
                  'args' => [
                    {
                      'contents' => [
                        {
                          'parent' => {},
                          'text' => 'c'
                        }
                      ],
                      'parent' => {},
                      'type' => 'following_arg'
                    }
                  ],
                  'cmdname' => ',',
                  'parent' => {}
                },
                {
                  'parent' => {},
                  'text' => ' '
                },
                {
                  'args' => [
                    {
                      'contents' => [
                        {
                          'parent' => {},
                          'text' => 'r'
                        }
                      ],
                      'parent' => {},
                      'type' => 'brace_command_arg'
                    }
                  ],
                  'cmdname' => 'u',
                  'contents' => [],
                  'line_nr' => {
                    'file_name' => '',
                    'line_nr' => 3,
                    'macro' => ''
                  },
                  'parent' => {}
                },
                {
                  'parent' => {},
                  'text' => ' '
                },
                {
                  'args' => [
                    {
                      'contents' => [
                        {
                          'parent' => {},
                          'text' => 'e'
                        }
                      ],
                      'parent' => {},
                      'type' => 'following_arg'
                    }
                  ],
                  'cmdname' => '`',
                  'parent' => {}
                }
              ],
              'parent' => {},
              'type' => 'brace_command_arg'
            }
          ],
          'cmdname' => 'var',
          'contents' => [],
          'line_nr' => {},
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
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'extra'}{'spaces_after_command'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'args'}[0]{'contents'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'};
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[1]{'parent'} = $result_trees{'accents_in_var_enable_encoding'};
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[1]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[1];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[4]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[5]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[5]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[5]{'args'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[5];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[5]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'line_nr'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'args'}[0]{'contents'}[3]{'line_nr'};
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'contents'}[1]{'parent'} = $result_trees{'accents_in_var_enable_encoding'}{'contents'}[2];
$result_trees{'accents_in_var_enable_encoding'}{'contents'}[2]{'parent'} = $result_trees{'accents_in_var_enable_encoding'};

$result_texis{'accents_in_var_enable_encoding'} = '@documentencoding utf-8

@var{AA@,c @u{r} @`e}.
';


$result_texts{'accents_in_var_enable_encoding'} = '
AAc, r( e`.
';

$result_errors{'accents_in_var_enable_encoding'} = [];



$result_converted{'plaintext'}->{'accents_in_var_enable_encoding'} = 'AAÇ R̆ È.
';

1;

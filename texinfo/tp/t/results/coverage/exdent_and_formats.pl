use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors);

$result_trees{'exdent_and_formats'} = {
  'contents' => [
    {
      'cmdname' => 'example',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => ' Example   Hoho. '
            },
            {
              'args' => [
                {
                  'contents' => [],
                  'parent' => {},
                  'type' => 'brace_command_arg'
                }
              ],
              'cmdname' => 'TeX',
              'contents' => [],
              'parent' => {}
            },
            {
              'parent' => {},
              'text' => ' . '
            },
            {
              'cmdname' => '*',
              'parent' => {}
            },
            {
              'parent' => {},
              'text' => ' '
            },
            {
              'cmdname' => '@',
              'parent' => {}
            },
            {
              'parent' => {},
              'text' => '.
'
            },
            {
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line'
            }
          ],
          'parent' => {},
          'type' => 'preformatted'
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
                  'text' => 'Other line'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 4,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'not exdented
'
            }
          ],
          'parent' => {},
          'type' => 'preformatted'
        }
      ],
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
    },
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line'
    },
    {
      'cmdname' => 'example',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented  and dash --- in example'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 10,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Not exdented
'
            }
          ],
          'parent' => {},
          'type' => 'preformatted'
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
                  'text' => 'exdented'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 12,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Not exdented
'
            }
          ],
          'parent' => {},
          'type' => 'preformatted'
        }
      ],
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
    },
    {
      'contents' => [
        {
          'parent' => {},
          'text' => 'Para1.
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
      'cmdname' => 'quotation',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'qsddsqkdsqkkmljsqjsqodmmdsqdsmqj dqs sdq sqd sdq dsq sdq sqd sqd sdq sdq 
'
            },
            {
              'parent' => {},
              'text' => 'qsd dsq sdq dsq dssdq sdq sdq sdq dsq sdq dsq dsq sdq dsq sdqsd q
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        }
      ],
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
    },
    {
      'contents' => [
        {
          'parent' => {},
          'text' => 'Para2.
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
          'text' => 'Para3.
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
          'text' => 'Last para.
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
      'cmdname' => 'quotation',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'quotation1
'
            },
            {
              'parent' => {},
              'text' => 'quotation2
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'quotation para 1
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
              'text' => 'quotation para 2
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        }
      ],
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
    },
    {
      'cmdname' => 'example',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Example   Hoho.
'
            }
          ],
          'parent' => {},
          'type' => 'preformatted'
        },
        {
          'cmdname' => 'example',
          'contents' => [
            {
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line_after_command'
            },
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'Nested Other line
'
                }
              ],
              'parent' => {},
              'type' => 'preformatted'
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
                      'text' => 'exdented nested other line'
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
              'cmdname' => 'exdent',
              'extra' => {
                'misc_content' => [
                  {}
                ]
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 44,
                'macro' => ''
              },
              'parent' => {}
            }
          ],
          'parent' => {}
        },
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented quotation line   and dash --- in quotation'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 49,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Not exdented followed by exdented
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
                  'parent' => {},
                  'text' => '  ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented quotation line'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 54,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => '  ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented quotation line'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 58,
            'macro' => ''
          },
          'parent' => {}
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'Followed by not exdented 
'
            }
          ],
          'parent' => {},
          'type' => 'paragraph'
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 63,
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
                  'text' => 'azeaz az az az az'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 64,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 68,
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
                  'text' => 'az az az az'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 69,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line_after_command'
        },
        {
          'contents' => [
            {
              'parent' => {},
              'text' => 'quotation line oidfjslsd aez a aze azaz aeae za eaz az zelef  aaa
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
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'ezkfjklezf'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 74,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
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
    },
    {
      'cmdname' => 'quotation',
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
              'contents' => [
                {
                  'parent' => {},
                  'text' => ' ',
                  'type' => 'empty_spaces_after_command'
                },
                {
                  'parent' => {},
                  'text' => 'very loooooooooooooooooooooooooooooooooong exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 78,
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
                  'text' => 'az az az az'
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
          'cmdname' => 'exdent',
          'extra' => {
            'misc_content' => [
              {}
            ]
          },
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 79,
            'macro' => ''
          },
          'parent' => {}
        }
      ],
      'parent' => {}
    },
    {
      'parent' => {},
      'text' => '
',
      'type' => 'empty_line_after_command'
    }
  ],
  'type' => 'text_root'
};
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[4]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[5]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[6]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'contents'}[7]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[3];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[4]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'contents'}[4]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[4];
$result_trees{'exdent_and_formats'}{'contents'}[4]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[5]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[6]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[7]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[7];
$result_trees{'exdent_and_formats'}{'contents'}[7]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[8]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[9];
$result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[9]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[9];
$result_trees{'exdent_and_formats'}{'contents'}[9]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[10]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[11]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[12]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[12];
$result_trees{'exdent_and_formats'}{'contents'}[12]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[13]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[14]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[14];
$result_trees{'exdent_and_formats'}{'contents'}[14]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[15]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[16]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[16];
$result_trees{'exdent_and_formats'}{'contents'}[16]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[17]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[18];
$result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[18]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[18];
$result_trees{'exdent_and_formats'}{'contents'}[18]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[19]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[20]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[3]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[3];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[21];
$result_trees{'exdent_and_formats'}{'contents'}[21]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[22]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[23]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'contents'}[3]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[24];
$result_trees{'exdent_and_formats'}{'contents'}[24]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[25]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[26]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[27];
$result_trees{'exdent_and_formats'}{'contents'}[27]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[28]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[29]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[30];
$result_trees{'exdent_and_formats'}{'contents'}[30]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[31]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[32]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[33];
$result_trees{'exdent_and_formats'}{'contents'}[33]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[34]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[35]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[36];
$result_trees{'exdent_and_formats'}{'contents'}[36]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[37]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[38]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[39];
$result_trees{'exdent_and_formats'}{'contents'}[39]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[40]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[41]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[42];
$result_trees{'exdent_and_formats'}{'contents'}[42]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[43]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[44]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'extra'}{'misc_content'}[0] = $result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'args'}[0]{'contents'}[1];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'contents'}[2]{'parent'} = $result_trees{'exdent_and_formats'}{'contents'}[45];
$result_trees{'exdent_and_formats'}{'contents'}[45]{'parent'} = $result_trees{'exdent_and_formats'};
$result_trees{'exdent_and_formats'}{'contents'}[46]{'parent'} = $result_trees{'exdent_and_formats'};

$result_texis{'exdent_and_formats'} = '@example
 Example   Hoho. @TeX{} . @* @@.

@exdent Other line
not exdented
@end example


@example
@exdent exdented  and dash --- in example
Not exdented
@exdent exdented
Not exdented
@end example

Para1.

@quotation
qsddsqkdsqkkmljsqjsqodmmdsqdsmqj dqs sdq sqd sdq dsq sdq sqd sqd sdq sdq 
qsd dsq sdq dsq dssdq sdq sdq sdq dsq sdq dsq dsq sdq dsq sdqsd q
@end quotation

Para2.

Para3.

Last para.

@quotation
quotation1
quotation2
@end quotation

@quotation
quotation para 1

quotation para 2
@end quotation

@example
Example   Hoho.
@example
Nested Other line
@exdent exdented nested other line
@end example
@end example

@quotation
@exdent exdented quotation line   and dash --- in quotation
@end quotation

@quotation
Not exdented followed by exdented
@exdent  exdented quotation line
@end quotation

@quotation
@exdent  exdented quotation line
Followed by not exdented 
@end quotation

@quotation
@exdent exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az
@exdent azeaz az az az az
@end quotation

@quotation
@exdent exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
@exdent az az az az
@end quotation

@quotation
quotation line oidfjslsd aez a aze azaz aeae za eaz az zelef  aaa
@exdent ezkfjklezf 
@end quotation

@quotation
@exdent very loooooooooooooooooooooooooooooooooong exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
@exdent az az az az
@end quotation
';


$result_texts{'exdent_and_formats'} = ' Example   Hoho. TeX . 
 @.

Other line
not exdented


exdented  and dash --- in example
Not exdented
exdented
Not exdented

Para1.

qsddsqkdsqkkmljsqjsqodmmdsqdsmqj dqs sdq sqd sdq dsq sdq sqd sqd sdq sdq 
qsd dsq sdq dsq dssdq sdq sdq sdq dsq sdq dsq dsq sdq dsq sdqsd q

Para2.

Para3.

Last para.

quotation1
quotation2

quotation para 1

quotation para 2

Example   Hoho.
Nested Other line
exdented nested other line

exdented quotation line   and dash --- in quotation

Not exdented followed by exdented
exdented quotation line

exdented quotation line
Followed by not exdented 

exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az
azeaz az az az az

exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
az az az az

quotation line oidfjslsd aez a aze azaz aeae za eaz az zelef  aaa
ezkfjklezf

very loooooooooooooooooooooooooooooooooong exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
az az az az
';

$result_errors{'exdent_and_formats'} = [];



$result_converted{'plaintext'}->{'exdent_and_formats'} = '      Example   Hoho. TeX . 
      @.

Other line
     not exdented

exdented  and dash --- in example
     Not exdented
exdented
     Not exdented

   Para1.

     qsddsqkdsqkkmljsqjsqodmmdsqdsmqj dqs sdq sqd sdq dsq sdq sqd sqd
     sdq sdq qsd dsq sdq dsq dssdq sdq sdq sdq dsq sdq dsq dsq sdq dsq
     sdqsd q

   Para2.

   Para3.

   Last para.

     quotation1 quotation2

     quotation para 1

     quotation para 2

     Example   Hoho.
          Nested Other line
     exdented nested other line

exdented quotation line and dash -- in quotation

     Not exdented followed by exdented
exdented quotation line

exdented quotation line
     Followed by not exdented

exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az
azeaz az az az az

exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
az az az az

     quotation line oidfjslsd aez a aze azaz aeae za eaz az zelef aaa
ezkfjklezf

very loooooooooooooooooooooooooooooooooong exdented quotation line oidfjslsd aez a aze azaz aeae za eaz az azeaz end line
az az az az
';

1;

use vars qw(%result_texis %result_texts %result_trees %result_errors 
   %result_indices %result_sectioning %result_nodes %result_menus
   %result_floats %result_converted %result_converted_errors 
   %result_elements %result_directions_text);

use utf8;

$result_trees{'anchor_in_copying_in_footnote'} = {
  'contents' => [
    {
      'contents' => [
        {
          'cmdname' => 'copying',
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
              'parent' => {},
              'text' => '
',
              'type' => 'empty_line'
            },
            {
              'contents' => [
                {
                  'parent' => {},
                  'text' => 'Copying'
                },
                {
                  'args' => [
                    {
                      'contents' => [
                        {
                          'parent' => {},
                          'text' => '
',
                          'type' => 'empty_spaces_before_argument'
                        },
                        {
                          'contents' => [
                            {
                              'parent' => {},
                              'text' => 'In footnote.
'
                            },
                            {
                              'args' => [
                                {
                                  'contents' => [
                                    {
                                      'parent' => {},
                                      'text' => 'Copying footnote'
                                    }
                                  ],
                                  'extra' => {
                                    'region' => {}
                                  },
                                  'parent' => {},
                                  'type' => 'brace_command_arg'
                                }
                              ],
                              'cmdname' => 'anchor',
                              'contents' => [],
                              'extra' => {
                                'brace_command_contents' => [
                                  [
                                    {}
                                  ]
                                ],
                                'node_content' => [
                                  {}
                                ],
                                'normalized' => 'Copying-footnote'
                              },
                              'line_nr' => {
                                'file_name' => '',
                                'line_nr' => 5,
                                'macro' => ''
                              },
                              'parent' => {}
                            },
                            {
                              'text' => '
',
                              'type' => 'empty_spaces_after_close_brace'
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
                  'cmdname' => 'footnote',
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
                  'text' => '.
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
                      'text' => 'copying'
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
                'command_argument' => 'copying',
                'text_arg' => 'copying'
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
            'end_command' => {}
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
      'contents' => [
        {
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
        },
        {
          'cmdname' => 'insertcopying',
          'line_nr' => {
            'file_name' => '',
            'line_nr' => 12,
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
          'parent' => {},
          'text' => '
',
          'type' => 'empty_line'
        },
        {
          'cmdname' => 'insertcopying',
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
                      'text' => 'Copying footnote'
                    }
                  ],
                  'parent' => {},
                  'type' => 'brace_command_arg'
                }
              ],
              'cmdname' => 'xref',
              'contents' => [],
              'extra' => {
                'brace_command_contents' => [
                  [
                    {}
                  ]
                ],
                'label' => {},
                'node_argument' => {
                  'node_content' => [
                    {}
                  ],
                  'normalized' => 'Copying-footnote'
                }
              },
              'line_nr' => {
                'file_name' => '',
                'line_nr' => 16,
                'macro' => ''
              },
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
        'line_nr' => 10,
        'macro' => ''
      },
      'parent' => {}
    }
  ],
  'type' => 'document_root'
};
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'extra'}{'region'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'extra'}{'brace_command_contents'}[0][0] = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'extra'}{'node_content'}[0] = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'args'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[2]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[3]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'args'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'extra'}{'command'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'extra'}{'end_command'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[4];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'};
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'extra'}{'command'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'contents'}[2]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[2]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[3]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[4]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[5]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[6]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'args'}[0]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'args'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'args'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'extra'}{'brace_command_contents'}[0][0] = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'args'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'extra'}{'label'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[0]{'contents'}[0]{'contents'}[2]{'contents'}[1]{'args'}[0]{'contents'}[1]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'extra'}{'node_argument'}{'node_content'}[0] = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'args'}[0]{'contents'}[0];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[0]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[7]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'contents'}[8]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'extra'}{'node_content'}[0] = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'args'}[0]{'contents'}[1];
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'extra'}{'nodes_manuals'}[0]{'node_content'} = $result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'extra'}{'node_content'};
$result_trees{'anchor_in_copying_in_footnote'}{'contents'}[1]{'parent'} = $result_trees{'anchor_in_copying_in_footnote'};

$result_texis{'anchor_in_copying_in_footnote'} = '@copying

Copying@footnote{
In footnote.
@anchor{Copying footnote}
}.

@end copying

@node Top

@insertcopying

@insertcopying

@xref{Copying footnote}.

';


$result_texts{'anchor_in_copying_in_footnote'} = '





.

';

$result_sectioning{'anchor_in_copying_in_footnote'} = {};

$result_nodes{'anchor_in_copying_in_footnote'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  },
  'node_up' => {
    'extra' => {
      'manual_content' => [
        {
          'text' => 'dir'
        }
      ],
      'top_node_up' => {}
    },
    'type' => 'top_node_up'
  }
};
$result_nodes{'anchor_in_copying_in_footnote'}{'node_up'}{'extra'}{'top_node_up'} = $result_nodes{'anchor_in_copying_in_footnote'};

$result_menus{'anchor_in_copying_in_footnote'} = {
  'cmdname' => 'node',
  'extra' => {
    'normalized' => 'Top'
  }
};

$result_errors{'anchor_in_copying_in_footnote'} = [];



$result_converted{'info'}->{'anchor_in_copying_in_footnote'} = 'This is , produced by tp version from .

Copying(1).

   ---------- Footnotes ----------

   (1) In footnote.


File: ,  Node: Top,  Up: (dir)

Copying(1).

   Copying(2).

   *Note Copying footnote::.

   ---------- Footnotes ----------

   (1) In footnote.

   (2) In footnote.



Tag Table:
Node: Top111
Ref: Top-Footnote-1240
Ref: Copying footnote259
Ref: Top-Footnote-2261

End Tag Table
';

$result_converted_errors{'info'}->{'anchor_in_copying_in_footnote'} = [
  {
    'file_name' => '',
    'error_line' => ':5: @anchor `Copying footnote\' output more than once
',
    'text' => '@anchor `Copying footnote\' output more than once',
    'type' => 'error',
    'macro' => '',
    'line_nr' => 5
  }
];



$result_converted{'html'}->{'anchor_in_copying_in_footnote'} = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
Copying.
 -->
<!-- Created by texinfo, http://www.gnu.org/software/texinfo/ -->
<head>
<title>Untitled Document</title>

<meta name="description" content="Untitled Document">
<meta name="keywords" content="Untitled Document">
<meta name="resource-type" content="document">
<meta name="distribution" content="global">
<meta name="Generator" content="tp">
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
<h1 class="node-heading">Top</h1>


<p>Copying<a name="DOCF1" href="#FOOT1">(1)</a>.
</p>



<p>Copying<a name="DOCF1_2" href="#FOOT1_2">(2)</a>.
</p>


<p>See <a href="#Copying-footnote">Copying footnote</a>.
</p>
<div class="footnote">
<hr>
<h4 class="footnotes-heading">Footnotes</h4>

<h3><a name="FOOT1" href="#DOCF1">(1)</a></h3>
<p>In footnote.
<a name="Copying-footnote"></a></p>
<h3><a name="FOOT1_2" href="#DOCF1_2">(2)</a></h3>
<p>In footnote.
<a name="Copying-footnote"></a></p>
</div>
<hr>



</body>
</html>
';

$result_converted_errors{'html'}->{'anchor_in_copying_in_footnote'} = [
  {
    'error_line' => 'warning: Must specify a title with a title command or @top
',
    'text' => 'Must specify a title with a title command or @top',
    'type' => 'warning'
  }
];


1;

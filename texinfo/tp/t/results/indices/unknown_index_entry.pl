use vars qw(%result_texis %result_texts %result_trees %result_errors %results_indices);

$result_trees{'unknown_index_entry'} = {
  'contents' => [
    {
      'contents' => [
        {
          'parent' => {},
          'text' => ' someindex entry.
'
        }
      ],
      'parent' => {},
      'type' => 'paragraph'
    }
  ],
  'type' => 'text_root'
};
$result_trees{'unknown_index_entry'}{'contents'}[0]{'contents'}[0]{'parent'} = $result_trees{'unknown_index_entry'}{'contents'}[0];
$result_trees{'unknown_index_entry'}{'contents'}[0]{'parent'} = $result_trees{'unknown_index_entry'};

$result_texis{'unknown_index_entry'} = ' someindex entry.
';


$result_texts{'unknown_index_entry'} = ' someindex entry.
';

$result_errors{'unknown_index_entry'} = [
  {
    'error_line' => ':1: Unknown command `someindex\'
',
    'file_name' => '',
    'line_nr' => 1,
    'macro' => '',
    'text' => 'Unknown command `someindex\'',
    'type' => 'error'
  }
];


1;

package me::tag_cn;
use wraprg;
use strict;

sub doit {
  my $lc_cont;
  my $lc_src;
  my $lc_ret;
  my $lc_toc;
  my $lc_idnm;
  
  $lc_idnm = 0;
  
  $lc_src = $_[0];
  $lc_cont = '';
  $lc_toc = '';
  
  while ( $lc_src ne '' )
  {
    my $lc2_a;
    my $lc2_b;
    
    ($lc2_a,$lc2_b) = split(quotemeta('<cont>'),$lc_src,2);
    $lc_cont .= $lc2_a;
    $lc_src = '';
    if ( $lc2_b ne '' )
    {
      my @lc3_a;
      my @lc3_b;
      my $lc3_title;
      my $lc3_content;
      
      @lc3_a = split(quotemeta('</cont>'),$lc2_b,2);
      @lc3_b = split(quotemeta('<l/>'),$lc3_a[0]);
      $lc_src = $lc3_a[1];
      $lc3_title = $lc3_b[0];
      $lc3_content = $lc3_b[1];
      $lc_idnm = int($lc_idnm + 1.2);
      
      $lc_cont .= '<a name = "sect_' . $lc_idnm . 'x"/>';
      $lc_cont .= '<div class = "my_sect_full">';
      $lc_cont .= "\n" . '<div class = "my_sect_title">' . $lc3_title . '</div>' . "\n";
      $lc_cont .= '<div class = "my_sect_content">' . $lc3_content . '</div>' . "\n";
      $lc_cont .= '</div><!-- sect -->';
      
      $lc_toc .= '<div class = "my_toc_item">';
      $lc_toc .= '<a href = "#sect_' . $lc_idnm . 'x">';
      $lc_toc .= $lc3_title;
      $lc_toc .= '</a>';
      $lc_toc .= '</div>' . "\n";
      
    }
  }
  
  
  $lc_toc = '<div class = "my_table_of_contents">' . "\n" . $lc_toc . '</div>';
  $lc_ret = [ $lc_cont, $lc_toc ];
  return $lc_ret;
}

1;

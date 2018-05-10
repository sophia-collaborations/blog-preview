package me::tag_l;
use strict;
use me::tag_bibit;

sub doit {
  my $lc_src;
  my $lc_dst;
  my $lc_x1;
  my $lc_x2;
  my $lc_sga;
  my $lc_sgb;
  $lc_src = $_[0];
  
  
  
  
  # FIRST ROUND: The texted links
  ($lc_dst,$lc_x1) = split(quotemeta('<lnk>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</lnk>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      ($lc_sga,$lc_sgb) = split(quotemeta('<l/>'),$lc_x1);

      # This argument for cases where there
      # is no <l/> between <lnk> and </lnk>
      if ( $lc_sga eq $lc_x1 ) { $lc_sgb = $lc_sga; }

      $lc_dst .= '<a href = "' . $lc_sga . '" target = "_blank" rel = "noopener">';
      $lc_dst .= $lc_sgb . '</a>';
    }
    ($lc_x1,$lc_src) = split(quotemeta('<lnk>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  
  # RESET CLAUSE:
  $lc_src = $lc_dst;
  
  
  # FIRST ROUND: The nofollow texted links
  # https://skeptools.wordpress.com/2011/10/14/follow-up-nofollow-skeptics-hyperlinks-links-seo/
  ($lc_dst,$lc_x1) = split(quotemeta('<bad>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</bad>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      ($lc_sga,$lc_sgb) = split(quotemeta('<l/>'),$lc_x1);
      $lc_dst .= '<a href = "' . $lc_sga . '" target = "_blank" rel = "nofollow noopener">';
      $lc_dst .= $lc_sgb . '</a>';
    }
    ($lc_x1,$lc_src) = split(quotemeta('<bad>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  
  # RESET CLAUSE:
  $lc_src = $lc_dst;


  # ANOTHER ROUND: <bibr> tag:
  ($lc_dst,$lc_x1) = split(quotemeta('<bibr>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</bibr>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      #($lc_sga,$lc_sgb) = split(quotemeta('<l/>'),$lc_x1);
      #$lc_dst .= '<a href = "' . $lc_sga . '" target = "_blank" rel = "nofollow noopener">';
      #$lc_dst .= $lc_sgb . '</a>';
      $lc_dst .= '[<a href = "#bibref_' . $lc_x1 . '_x">*' . $lc_x1 . '</a>]';
    }
    ($lc_x1,$lc_src) = split(quotemeta('<bibr>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  
  # RESET CLAUSE:
  $lc_src = $lc_dst;


  # ANOTHER ROUND: <bibit> tag:
  ($lc_dst,$lc_x1) = split(quotemeta('<bibit>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</bibit>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      $lc_dst .= &me::tag_bibit::converto($lc_x1);
    }
    ($lc_x1,$lc_src) = split(quotemeta('<bibit>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  
  # RESET CLAUSE:
  $lc_src = $lc_dst;
  
  
  # THIRD ROUND: The file-download links
  # https://skeptools.wordpress.com/2011/10/14/follow-up-nofollow-skeptics-hyperlinks-links-seo/
  ($lc_dst,$lc_x1) = split(quotemeta('<fdload>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</fdload>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      ($lc_sga,$lc_sgb) = split(quotemeta('<l/>'),$lc_x1);
      $lc_dst .= '<a href = "' . $lc_sga . '" download>';
      $lc_dst .= $lc_sgb . '</a>';
    }
    ($lc_x1,$lc_src) = split(quotemeta('<fdload>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  
  # RESET CLAUSE:
  $lc_src = $lc_dst;
  
  
  # SECOND ROUND: The simple links
  ($lc_dst,$lc_x1) = split(quotemeta('<l>'),$lc_src,2);
  $lc_src = $lc_x1;
  
  while ( $lc_src ne '' )
  {
    ($lc_x1,$lc_x2) = split(quotemeta('</l>'),$lc_src,2);
    if ( $lc_x1 ne '' )
    {
      #$lc_dst .= '&#91;';
      $lc_dst .= '<a href = "' . $lc_x1 . '" target = "_blank">';
      $lc_dst .= $lc_x1 . '</a>';
      #$lc_dst .= '&#93;';
    }
    ($lc_x1,$lc_src) = split(quotemeta('<l>'),$lc_x2,2);
    $lc_dst .= $lc_x1;
  }
  
  # LET US RETURN:
  return $lc_dst;
}


1;

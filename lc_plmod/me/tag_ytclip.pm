package me::tag_ytclip;
use strict;

sub doit {
  my $lc_ret;
  my $lc_src;
  my $lc_pre;
  my $lc_pin;
  my $lc_in;
  my $lc_img;
  my $lc_cap;

  $lc_src = $_[0];
  $lc_ret = '';
  while ( $lc_src ne '' )
  {
    ($lc_pre,$lc_pin) = split(quotemeta('<ytclip>'),$lc_src,2);
    $lc_ret .= $lc_pre;

    if ( $lc_pre eq $lc_src )
    {
      $lc_src = '';
    } else {
      ($lc_in,$lc_src) = split(quotemeta('</ytclip>'),$lc_pin,2);

      ($lc_img,$lc_cap) = split(quotemeta('<capton/>'),$lc_in);
      if ( $lc_img eq $lc_in )
      {
        $lc_ret .= "<div class = \"my_ytclip_smp\">" . $lc_img . "</div>";
      } else {
        $lc_ret .= "<div class = \"my_ytclip_ful\">";
        $lc_ret .= "<div class = \"my_ytclip_img\">" . $lc_img;
        $lc_ret .= "</div><div class = \"my_ytclip_cap\">" . $lc_cap;
        $lc_ret .= "</div></div>";
      }
    }

  }
  return $lc_ret;
}

1;


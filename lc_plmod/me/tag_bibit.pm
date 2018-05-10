package me::tag_bibit;
use strict;

sub converto {
  my $lc_atrb;
  my @lc_segs;
  my $lc_eseg;
  my $lc_pre;
  my $lc_mid;
  my $lc_cont;
  my $lc_ret;
  $lc_atrb = {};
  @lc_segs = split(/\n/,$_[0]);
  foreach $lc_eseg (@lc_segs)
  {
    ($lc_pre,$lc_mid) = split(quotemeta(':'),(scalar reverse $lc_eseg),2);
    ($lc_pre,$lc_cont) = split(quotemeta(':'),(scalar reverse $lc_mid),2);
    if ( $lc_pre ne '' ) { $lc_atrb->{$lc_pre} = $lc_cont; }
  }

  if ( !(exists $lc_atrb->{'id'}) ) { return ''; }
  if ( !(exists $lc_atrb->{'title'}) ) { return ''; }
  $lc_ret = '';

  $lc_ret .= "\n<div class = \"my_bib_item\" id = \"bibref_";
  $lc_ret .= $lc_atrb->{'id'};
  $lc_ret .= "_x\">";

  if ( exists $lc_atrb->{'url'} )
  {
    $lc_ret .= '<a href = "' . $lc_atrb->{'url'} . '" target = "_blank" rel = "noopener">';
  }


  $lc_ret .= '<span class = "bib_id">' . $lc_atrb->{'id'} . "</span> ";
  $lc_ret .= '<span class = "bib_title">' . $lc_atrb->{'title'} . "</span>";

  if ( exists $lc_atrb->{'author'} )
  {
    $lc_ret .= ' <span class = "bib_author">' . $lc_atrb->{'author'} . "</span>";
  } 
  

  if ( exists $lc_atrb->{'url'} )
  {
    $lc_ret .= '</a>';
  }

  $lc_ret .= "</div>";

  return $lc_ret;
}

1;


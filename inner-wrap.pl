use strict;
use chobak_date;
use argola;
use wraprg;
use me::tag_l;
use me::tag_cn;
use dateelem;
#use chobinfodig;

my $zan;
my $file_set = 0;
my $file_at;
my $hme;
my $resdir;
my $cmdn;
my $cont;
my $txcont;
my $dsfile;
my $dstext;
my $clean_gunk = 0;
my @css_srcx = ();
my $show_intermedia = 0;
my $open_cont_folder = 0;
my $open_cont_file = 0;

sub opto__f__do {
  $file_at = &argola::getrg();
  $file_set = 10;
} &argola::setopt('-f',\&opto__f__do);

sub opto__dir__do {
  $open_cont_folder = 10;
} &argola::setopt('-dir',\&opto__dir__do);

sub opto__edt__do {
  $open_cont_file = 10;
} &argola::setopt('-edt',\&opto__edt__do);

sub opto__css__do {
  @css_srcx = (@css_srcx,&argola::getrg());
} &argola::setopt('-css',\&opto__css__do);

sub opto__cln__do {
} &argola::setopt('-cln',\&opto__cln__do);

sub opto__stx__do {
  #system("echo","Activating Intermedia");
  $show_intermedia = 10;
} &argola::setopt('-stx',\&opto__stx__do);

&argola::txt_help_opt('--help','help-file.txt');

&argola::runopts();


#system("echo",$zan->stamp());

$hme = $ENV{"HOME"};
$resdir = $hme . '/bin-res/blog-preview';
if ( $clean_gunk < 5 )
{
  system("rm","-rf",$resdir);
  if ( $file_set < 5 ) { exit(0); }
}
system("mkdir","-p",$resdir);

if ( $file_set < 5 )
{
  die "\nFATAL ERROR: No File Selected:\n"
  . "  Select file with this option:  -f [file]\n"
  . "\n";
}

if ( ! ( -f $file_at ) )
{
  die "\nFATAL ERROR: No Such File: " . $file_at . ":\n\n";
}




$cmdn = 'cat';
&wraprg::lst($cmdn,$file_at);
$cont = `$cmdn`;

&filaset;
while ( -f $dsfile )
{
  sleep(1); &filaset;
}

{
  my $lc_a;
  $lc_a = &me::tag_cn::doit($cont);
  $cont = $lc_a->[0];
  &swapo($cont,'<contents/>',$lc_a->[1]);
}
{
  # Now allow triple-parantheses in lieu of fish-tags
  &swapo($cont,'(((','<');
  while( &swapo($cont,'<(','(<') ) { }
  &swapo($cont,')))','>');
  while( &swapo($cont,')>','>)') ) { }
  
  # And only after that, filter out the '<x/>' tags:
  &swapo($cont,'<x/>','');
  
  # BEGIN PROCESSING SPECIAL TAGS FOR ARTICLE ELEMENTS:
  if ( $show_intermedia < 5 )
  {
    &swapo($cont,"\n<iframe","\n <iframe");
    &swapo($cont,"iframe>\n","iframe> \n");
  }
  &swapo($cont,'<title>',('<div class = "my_article_title">' . "\n\n"));
  &swapo($cont,'</title>',("\n\n" . '</div>'));
  &swapo($cont,'<fullcont>','<!-- start cpp --><div class = "my_fullcont">');
  &swapo($cont,'</fullcont>','</div><!-- stop cpp -->');
  &swapo($cont,'<precap>','<div class = "my_precap">');
  &swapo($cont,'</precap>','</div>');
  &swapo($cont,'<altlink>','<div class = "my_linktext">');
  &swapo($cont,'</altlink>','</div>');
  &swapo($cont,'<undivided>','<div class = "my_cont_undivided">');
  &swapo($cont,'</undivided>','</div>');
  &swapo($cont,'<divided>','<div class = "my_cont_divided">');
  &swapo($cont,'</divided>','</div>');
  
  # Every <sect_h/> section is supposed to be followed by a <sect_b/> section
  # and every <sect_b/> section is supposed to be preceded by a <sect_h/> section.
  # These represent the header-section and body-section of sub-sections of segmented
  # articles.
  &swapo($cont,'<sect_h>','<div class = "sect_a"><div class = "sect_h">');
  &swapo($cont,'</sect_h>','</div>');
  &swapo($cont,'<sect_b>','<div class = "sect_b">');
  &swapo($cont,'</sect_b>','</div></div>');
  
  &sdivtag($cont,'listhead','my_list_head');

  &sdivtag($cont,'stansa','my_verse_stan_1');
  &sdivtag($cont,'poeml','my_verse_line_1');
  
  &sdivtag($cont,'sect','my_sect_frame');
  &sdivtag($cont,'stitle','my_sect_title');
  &sdivtag($cont,'sbody','my_sect_body');
  &sdivtag($cont,'intro','my_msect_intro'); # Introduction to Multi-Section Articles
  &sdivtag($cont,'excr','excrp_frame'); # Excerpt (the frame thereof)
  &sdivtag($cont,'extx','excrp_main'); # Excerpt text
  &sdivtag($cont,'exat','excrp_attrib'); # Excerpt attribution
  &spantag($cont,'doctitle','dctitle'); # Title of a document or other such work
  &spantag($cont,'trm','my_spcl_term'); # A special term being emphasized
  &sdivtag($cont,'note','rt_note_box'); # A note embedded in the article about the article itself
  &sdivtag($cont,'beginning','my_cont_beginning'); # The beginning section of a segmented article


  # Added for accommodating the Psalms
  &sdivtag($cont,'psalm','psalm_text');
  &sdivtag($cont,'psalmbgn','psalm_bgn_text');
  &sdivtag($cont,'pstans1','stansa1');
  &sdivtag($cont,'pvra1','versea1');
  &sdivtag($cont,'pvrh1','verseh1');
  &sdivtag($cont,'pvra2','versea2');
  &sdivtag($cont,'pvrh2','verseh2');

  # And Now for the Credits
  &sdivtag($cont,'credits','sect_credits');
  &sdivtag($cont,'credit','each_credit');

  
  # And now the span-types
  &swapo($cont,'<key>','<span class = "my_keypoint">');
  &swapo($cont,'</key>','</span>');
  &swapo($cont,'<em>','<span class = "my_em_words">');
  &swapo($cont,'</em>','</span>');
}
if ( $show_intermedia < 5 )
{
  my @lc_a;
  
  @lc_a = split(quotemeta('<!-- start blog-preview -->'),$cont,2);
  if ( $lc_a[1] ne '' ) { $cont = $lc_a[1]; }
  
  @lc_a = split(quotemeta('<!-- stop blog-preview -->'),$cont);
  $cont = $lc_a[0];
  
  &downtags();
}
{
  &swapo($cont,'<tags>',('<div class = "my_blog_tags">' . "\n\n"));
  &swapo($cont,'</tags>',("\n\n" . '</div>'));
}

$txcont = &me::tag_l::doit($cont);
$cont = $txcont;

sub filaset {
  my $lc_src;
  #$zan = &chobak_date::new();
  #$dsfile = $resdir . '/by-' . $zan->stamp() . '.html';
  #$dstext = $resdir . '/by-' . $zan->stamp() . '.txt';

  # For some reason, the more portable implementation
  # stopped working -- so I'll have to revert (for now)
  # to the version of that line that is specific to
  # systems with full-featured versions of the 'date'
  # command.
  #$lc_src = &dateelem::asem([['lib','date_stamp_dshcode']]);
  $lc_src = `date +%Y-%m-%d-%H%M%S`; chomp($lc_src);

  $dsfile = $resdir . '/by-' . $lc_src . '.html';
  $dstext = $resdir . '/by-' . $lc_src . '.txt';
}

sub swapo {
  my $lc_a;
  my $lc_xa;
  my $lc_b;
  my $lc_c;
  
  $lc_a = $_[0];
  $lc_b = quotemeta($_[1]);
  $lc_c = $_[2];
  
  $lc_xa = $lc_a;
  $lc_a =~ s/$lc_b/$lc_c/g;
  $_[0] = $lc_a;
  return ($lc_a ne $lc_xa);
}


sub sdivtag {
  my $lc_cn = $_[0];
  
  &swapo($lc_cn,('<' . $_[1] . '>'),('<div class = "' . $_[2] . '">'));
  &swapo($lc_cn,('</' . $_[1] . '>'),('</div>'));
  
  $_[0] = $lc_cn;
}


sub spantag {
  my $lc_cn = $_[0];
  
  &swapo($lc_cn,('<' . $_[1] . '>'),('<span class = "' . $_[2] . '">'));
  &swapo($lc_cn,('</' . $_[1] . '>'),('</span>'));
  
  $_[0] = $lc_cn;
}




sub downtags {
  my $lc_x;
  $lc_x = [ \$cont, [] ];
  
  #system("echo",$cont); sleep(5);
  
  # First, we must buffer certain kinds of tags from
  # the up-coming carnage:
  &iswp($lc_x,"<lnk>","l<lnk>");
  &iswp($lc_x,"</lnk>","</lnk>l");
  &iswp($lc_x,"<bad>","l<bad>");
  &iswp($lc_x,"</bad>","</bad>l");
  &iswp($lc_x,"<fdload>","l<fdload>");
  &iswp($lc_x,"</fdload>","</fdload>l");
  &iswp($lc_x,"<span","l<span");
  &iswp($lc_x,"</span>","</span>l");
  
  while ( &swapo($cont,"\n\n<","\n<") ) { }
  while ( &swapo($cont,">\n\n",">\n") ) { }
  while ( &swapo($cont,"\n<"," <") ) { }
  while ( &swapo($cont,">\n","> ") ) { }
  
  # Now we remove the carnage-buffering:
  &rvswp($lc_x);
}

while ( &swapo($cont,"\n\n\n","\n\n") ) { }
&swapo($cont,"\n","<br/>\n");



if ( $show_intermedia < 5 )
{
  &swapo($cont,"\n <iframe","\n<iframe");
  &swapo($cont,"iframe> \n","iframe>\n");
}


# Now -- highlight the copy-paste sections:
&finalight($txcont);
&finalight($cont);
sub finalight {
  my $lc_cont;
  $lc_cont = $_[0];
  &swapo($lc_cont,'<!-- start cpp -->',("\n\n\n" . '<!-- START COPY/PASTE SECTION ON NEXT LINE -->' . "\n\n\n"));
  &swapo($lc_cont,'<!-- stop cpp -->',("\n\n\n" . '<!-- STOP COPY/PASTE SECTION ON PREVIOUS LINE -->' . "\n\n\n"));
  $_[0] = $lc_cont;
}


if ( $show_intermedia > 5 )
{
  $cmdn = "| cat >";
  &wraprg::lst($cmdn,$dstext);
  open TAK, $cmdn;
  print TAK $txcont;
  close TAK;
  system("wra",$dstext);
}

if ( $show_intermedia < 5 )
{
  $cmdn = "| cat >";
  &wraprg::lst($cmdn,$dsfile);
  open TAK, $cmdn;
  print TAK "<html><head>\n";
  print TAK '<meta charset="UTF-8">' . "\n";
  {
    my $lc_a;
    my $lc_b;
    my $lc_cm;
    foreach $lc_a (@css_srcx)
    {
      if ( -f $lc_a )
      {
        $lc_cm = "cat";
        &wraprg::lst($lc_cm,$lc_a);
        $lc_b = `$lc_cm`;
        print TAK "<style type = \"text/css\">\n";
        print TAK $lc_b;
        print TAK "</style>\n";
      }
    }
  }
  print TAK "</head><body>\n";
  print TAK "<div align = \"center\">\n";
  
  #print TAK "<table border = \"0\" width = \"700px\"><tr><td class = \"maino\">\n";
  print TAK "<table class = \"maino\"\"><tr><td class = \"maino\">\n";
  
  print TAK $cont;
  print TAK "</td></tr></table>\n";
  print TAK "</div>\n";
  print TAK "\n</body></html>\n";
  close TAK;
  
  #system("open",$dsfile);
  system("chobakwrap","-sub","browseropen",$dsfile);
  
  if ( $open_cont_folder > 5 ) { system("open",$resdir); }
  if ( $open_cont_file > 5 ) { system("edit",$dsfile); }
}



sub iswp {
  my $lc_contr;
  my $lc_conta;
  my $lc_trf;
  
  $lc_contr = $_[0]->[0];
  $lc_conta = $$lc_contr;
  $lc_trf = $_[0]->[1];
  &swapo($lc_conta,$_[1],$_[2]);
  @$lc_trf = (@$lc_trf, [ $_[2], $_[1] ]);
  $$lc_contr = $lc_conta;
}

sub rvswp {
  my $lc_contr;
  my $lc_conta;
  my $lc_trf;
  my $lc_lem;
  my $lc_count;
  
  $lc_contr = $_[0]->[0];
  $lc_conta = $$lc_contr;
  $lc_trf = $_[0]->[1];
  
  $lc_count = @$lc_trf;
  while ( $lc_count > 0.5 )
  {
    $lc_lem = pop(@$lc_trf);
    &swapo($lc_conta,$lc_lem->[0],$lc_lem->[1]);
    $lc_count = @$lc_trf;
  }
  
  $$lc_contr = $lc_conta;
}







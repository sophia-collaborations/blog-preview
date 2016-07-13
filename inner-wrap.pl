use strict;
use chobak_date;
use argola;
use wraprg;
use me::tag_l;
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

sub filaset {
 $zan = &chobak_date::new();
 $dsfile = $resdir . '/by-' . $zan->stamp() . '.html';
 $dstext = $resdir . '/by-' . $zan->stamp() . '.txt';
}
&filaset;
while ( -f $dsfile )
{
  sleep(1); &filaset;
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


$txcont = &me::tag_l::doit($cont);
$cont = $txcont;

while ( &swapo($cont,"\n\n<","\n<") ) { }
while ( &swapo($cont,">\n\n",">\n") ) { }
while ( &swapo($cont,"\n<"," <") ) { }
while ( &swapo($cont,">\n","> ") ) { }
while ( &swapo($cont,"\n\n\n","\n\n") ) { }
&swapo($cont,"\n","<br/>\n");


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
  
  system("open",$dsfile);
  if ( $open_cont_folder > 5 ) { system("open",$resdir); }
  if ( $open_cont_file > 5 ) { system("edit",$dsfile); }
}







use strict;
use chobak_date;
use argola;
use wraprg;
#use chobinfodig;

my $zan;
my $file_set = 0;
my $file_at;
my $hme;
my $resdir;
my $cmdn;
my $cont;
my $dsfile;
my $clean_gunk = 0;

sub opto__f__do {
  $file_at = &argola::getrg();
  $file_set = 10;
} &argola::setopt('-f',\&opto__f__do);

sub opto__cln__do {
} &argola::setopt('-cln',\&opto__cln__do);

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
}
&filaset;
while ( -f $dsfile )
{
  sleep(1); &filaset;
}

sub swapo {
  my $lc_a;
  my $lc_b;
  my $lc_c;
  
  $lc_a = $_[0];
  $lc_b = quotemeta($_[1]);
  $lc_c = $_[2];
  
  $lc_a =~ s/$lc_b/$lc_c/g;
  $_[0] = $lc_a;
  return $lc_a;
}

&swapo($cont,"\n","<br/>\n");


$cmdn = "| cat >";
&wraprg::lst($cmdn,$dsfile);
open TAK, $cmdn;
print TAK "<html><head>\n";
print TAK '<style type="text/css">
.maino {
	font-size: 30px;
}
</style>
';
print TAK "</head><body>\n";
print TAK "<div align = \"center\">\n";
print TAK "<table border = \"0\" width = \"700px\"><tr><td class = \"maino\">\n";
print TAK $cont;
print TAK "</td></tr></table>\n";
print TAK "</div>\n";
print TAK "\n</body></html>\n";
close TAK;

system("open",$dsfile);



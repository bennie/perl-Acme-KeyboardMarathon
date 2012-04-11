use ACME::KeyboardMarathon;
use Test;
use strict;

BEGIN { plan tests => 2 };

my $text = 'The ~`@#$, %^&*(, ={}|[], ?,./ fox jumps over the )-_+, \:";\'<>, dog.';
my $km = new ACME::KeyboardMarathon;
my $dist = $km->distance($text);

#print "\n $dist == 210.85 \n";
ok( $dist == 210.85 ); 

$text = " \t\n";
$km = new ACME::KeyboardMarathon;
$dist = $km->distance($text);

#print "\n $dist == 7.05 \n";
ok( $dist == 7.05 );

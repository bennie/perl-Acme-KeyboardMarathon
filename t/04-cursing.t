use Acme::KeyboardMarathon;
use Test::Simple tests => 2;
use strict;

my $text = 'The ~`@#$, %^&*(, ={}|[], ?,./ fox jumps over the )-_+, \:";\'<>, dog.';
my $km = new Acme::KeyboardMarathon;
my $dist = $km->distance($text);

ok( $dist == 210, "Should be 210: $dist" ); 

$text = " \t\n";
$km = new Acme::KeyboardMarathon;
$dist = $km->distance($text);

ok( $dist == 7, "Should be 7: $dist" );

use Acme::KeyboardMarathon;
use Test;
use strict;

BEGIN { plan tests => 2 };

my $text = 'The ~`@#$, %^&*(, ={}|[], ?,./ fox jumps over the )-_+, \:";\'<>, dog.';
my $km = new Acme::KeyboardMarathon;
my $dist = $km->distance($text);

print "# Should be: $dist == 210.85 \n" unless ( $dist == 210.85 );
ok( $dist == 210.85 ); 

$text = " \t\n";
$km = new Acme::KeyboardMarathon;
$dist = $km->distance($text);

print "# Should be: $dist == 7.05 \n" unless ( $dist == 7.05 );
ok( $dist == 7.05 );

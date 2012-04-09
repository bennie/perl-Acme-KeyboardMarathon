use ACME::KeyboardMarathon;
use Test;
use strict;

BEGIN { plan tests => 2 };

my $text = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG!";
my $km = new ACME::KeyboardMarathon;
my $dist = $km->distance($text);

ok( $dist == 144.5 ); 

$text = "The quick brown fox jumps over the lazy dog.";
$km = new ACME::KeyboardMarathon;
$dist = $km->distance($text);

ok( $dist == 76.8 ); 

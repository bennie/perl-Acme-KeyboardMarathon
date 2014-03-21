use Acme::KeyboardMarathon;
use Test::Simple tests => 2;
use strict;

my $text = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG!";
my $km = new Acme::KeyboardMarathon;
my $dist = $km->distance($text);

ok( $dist == 146, "Should be 146: $dist" ); 

$text = "The quick brown fox jumps over the lazy dog.";
$km = new Acme::KeyboardMarathon;
$dist = $km->distance($text);

ok( $dist == 74, "Should be 74: $dist" ); 

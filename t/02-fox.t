use ACME::KeyboardMarathon;
use Test;
use strict;

BEGIN { plan tests => 2 };

my $text = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG!";
my $km = new ACME::KeyboardMarathon;
my $dist = $km->distance($text);

#print "\n $dist == 146.5 \n";
ok( $dist == 146.5 ); 

$text = "The quick brown fox jumps over the lazy dog.";
$km = new ACME::KeyboardMarathon;
$dist = $km->distance($text);

#print "\n $dist == 74.5 \n";
ok( $dist == 74.5 ); 

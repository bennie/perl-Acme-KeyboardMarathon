use Acme::KeyboardMarathon;
use Test;
use strict;

BEGIN { plan tests => 2 };

my $text = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG!";
my $km = new Acme::KeyboardMarathon;
my $dist = $km->distance($text);

print "# Should be: $dist == 146.5 \n" unless ( $dist == 146.5 );
ok( $dist == 146.5 ); 

$text = "The quick brown fox jumps over the lazy dog.";
$km = new Acme::KeyboardMarathon;
$dist = $km->distance($text);

print "# Should be: $dist == 74.5 \n" unless ( $dist == 74.5 );
ok( $dist == 74.5 ); 

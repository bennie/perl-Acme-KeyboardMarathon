use Acme::KeyboardMarathon;
use File::Slurp;
use Test::Simple tests => 1;
use strict;

my $text = read_file('t/wild.txt');
my $km = new Acme::KeyboardMarathon;
my $dist = $km->distance($text);

ok( $dist == 334374, "Should be 334374, got $dist" );

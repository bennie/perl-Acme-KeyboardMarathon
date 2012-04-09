use Test;
use strict;

BEGIN { plan tests => 2 };

use ACME::KeyboardMarathon;
ok(1); 

my $km = new ACME::KeyboardMarathon;
ok( defined $km );

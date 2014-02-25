use Test;
use strict;

BEGIN { plan tests => 2 };

use Acme::KeyboardMarathon;
ok(1); 

my $km = new Acme::KeyboardMarathon;
ok( defined $km );

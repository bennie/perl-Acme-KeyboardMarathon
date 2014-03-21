#!/usr/bin/env perl -Ilib

use Acme::KeyboardMarathon;
use Data::Dumper;
use strict;

my $ak = new Acme::KeyboardMarathon;

for my $key ( sort keys %{$ak->{k}} ) {
  print sprintf("ok( \$ak->{'$key'} == %3s, '$key should be $ak->{k}->{$key}, but is '.\$ak->{'$key'} );\n",$ak->{k}->{$key});
}
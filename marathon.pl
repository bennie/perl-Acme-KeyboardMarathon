#!/usr/bin/perl -Ilib

use ACME::KeyboardMarathon;
use strict;

my $akm = new ACME::KeyboardMarathon;

our @ARGV;
my $total = 0;

for my $file ( @ARGV ) {
  print STDERR "Skipping [$file] as it is not a file\n" unless -f $file;
  open INFILE, '<', $file;
  while ( my $line = <INFILE> ) {
    $total += $akm->distance($line);
  }
  close INFILE;
}

if ( $total > 100000 ) {
  $total /= 100000;
  print sprintf('%0.2f',$total) . " km\n";
} elsif ( $total > 100 ) {
  $total /= 100;
  print sprintf('%0.2f',$total) . " m\n";
} else {
  print $total . " cm\n";
}
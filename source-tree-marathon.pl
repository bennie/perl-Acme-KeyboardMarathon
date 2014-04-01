#!/usr/bin/perl -Ilib

use Acme::KeyboardMarathon;
use Cwd;
use Data::Dumper;
use DB_File;
use File::Find;
use File::Slurp;
use Math::BigInt lib => 'GMP';
use strict;
use warnings;

### Conf

my $cwd    = getcwd();
my $dbfile = 'marathon.db';

my $base_dir;

if ( $ARGV[0] and -d $ARGV[0] ) {
  $base_dir = $ARGV[0];
  chomp $base_dir;
  chop $base_dir if $base_dir =~ /[\\\/]$/;
}

unless ( $base_dir ) {
  print STDERR "Usage: ./source-tree-marathon.pl /source/directory/to/crawl\n";
  exit 1;
}

### Constants

my $skip_file_extension_regex = qr{\.(binmode|bmp|docx|exe|gif|gz|ico|jar|jpe?g|o|obj|pdf|png|pptx|pyc|so|tar(\.xz)?|tiff?|tgz|ttf|vsd|zip)$};
my $skip_dirs_regex = qr/^(\.git|tpc|debian|linux-kernel)/;

### Bootstrap


my %data;

if ( -f $dbfile ) {
  print "Reusing file: $dbfile\n";
} else {
  print "Creating file: $dbfile\n";
}

my $ref = tie %data, 'DB_File', $dbfile;

my $akm = new Acme::KeyboardMarathon;
 
### Main

# Remove file stats for missing files
for my $file ( keys %data ) {
  next if -f $file;
  print "DEL: $file\n";
  delete $data{$file}
}

### Store stats

$| = 1; # autoflush

my $skip  = 0;
my $add   = 0;
my $cache = 0;

find( \&check_stats, $base_dir );

print "ADD: $add\nCACHE: $cache\nSKIP: $skip\n";


if ( $add ) {
  print "\nSyncing...\n";
  $ref->sync();
}

### Process stats

my %filecounts;
my %filedists;

my $grand_total = Math::BigInt->new();

for my $file ( keys %data ) {
  next unless $file =~ /\.([^\.\/]+)$/;

  my $type = $1;
  $filecounts{$type}++;

  my ($mtime,$size,$dist) = split ':', $data{$file}, 3;

  $filedists{$type} = Math::BigInt->new() unless defined $filedists{$type};
  $filedists{$type} += $dist;
  $grand_total += $dist;
}

print "\nGrand total: ", display($grand_total), "\n\nTop 10 distance:\n\n";

my $i = 1;
for my $type ( sort { $filedists{$b} <=> $filedists{$a}  } keys %filedists ) {
  printf "%20s : %4s files : %s\n", $type, $filecounts{$type}, display($filedists{$type});
  last if $i++ > 10;
}

print "\nDistances by file count:\n\n";

for my $type ( sort { $filecounts{$b} <=> $filecounts{$a} } keys %filecounts ) {
  printf "%20s : %4s files : %s\n", $type, $filecounts{$type}, display($filedists{$type});
}

### Subroutines

sub check_stats {
  if ( -d $_ ) {
    my $localdir = $File::Find::name;
    $localdir = $1 if $localdir =~ /^$base_dir\/(.+)$/;
    print "DIR: $localdir\n";
    return;
  }
  $skip++ and print "SKIP: $_ (regex)\n" and return if $_ =~ /$skip_file_extension_regex/i;

  my $localdir = $File::Find::dir;
  $localdir = $1 if $localdir =~ /^$base_dir\/(.+)$/;
  $skip++ and print "SKIP: $localdir (directory)\n" and return if $localdir =~ /$skip_dirs_regex/;

  $skip++ and print "SKIP: $_ (binary)\n" and return if -B $File::Find::name;
  $skip++ and print "SKIP: $_ (zero size)\n" and return if -z $File::Find::name;

  my @stat = stat($File::Find::name);
  my $mtime = $stat[9];
  my $size  = $stat[7];

  if ( defined $data{$File::Find::name} and $data{$File::Find::name} =~ /^$mtime\:$size\:/ ) {
    $cache++ and print "CACHE: $_\n";
    return;
  }

  $add++ and print "ADD: $_ ";

  my $text = read_file($File::Find::name);
  my $dist = $akm->distance($text);

  $data{$File::Find::name} = "$mtime:$size:$dist";

  print "(".display($dist).")\n";

  unless ( $add % 100 ) {
    print "syncing...\n";
    $ref->sync();
  }
  
  #exit if $add > 25;
}

sub display {
  my $total = "$_[0]"; # Convert to 
  if ( $total > 100000 ) {
    $total /= 100000;
    return sprintf('%0.2f',$total) . ' km';
  } elsif ( $total > 100 ) {
    $total /= 100;
    return sprintf('%0.2f',$total) . ' m';
  } else {
    return $total . ' cm';
  }
}

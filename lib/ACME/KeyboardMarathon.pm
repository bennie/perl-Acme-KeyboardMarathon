$ACME::KeyboardMarathon::VERSION='VERSIONTAG';

use strict;

package ACME::KeyboardMarathon;

sub new {
  my $class = shift @_;
  my $self = {};
  bless($self,$class);

  # all measures in cm
  my %keys;

  my $DEPRESS_CONSTANT = 0.25;
  my $SHIFT_DISTANCE = 2;

  my %basic_distances = ( # basic distance traveled horizontally for a key
       0   => 'AaSsDdFfJjKkLl;: ',
       2   => 'QqWwGgHhEeRrTtYyUuIiOoPpZzXxCcVvNnMm,<>./?\'"',
       4   => ']123478905Ii-_}!@#$%&*()' . "\n",
       4.5 => '=+',
       2.3 => '[{' . "\t",
       3.5 => 'Bb',
       5   => '6^`~',
       5.5 => '\\|',
  );

  my %shifted; # lookup hash to see if a key is shifted
  for my $key ( split '', /!@#$%^&*()_+<>?:"{}|~'/ . join('','A'..'Z') ) {
    $shifted{$key}++;
  }

  for my $hdist ( keys %basic_distances ) {
    for my $key ( split '', $basic_distances{$hdist} ) {
      $self->{k}->{$key} = $hdist + $DEPRESS_CONSTANT + ( $shifted{$key} ? $SHIFT_DISTANCE : 0 );
    }
  }

  return $self;
}

sub distance {
  my $self = shift @_;
  my $distance = 0;
  while ( my $chunk = shift @_ ) {
    die "FAR OUT! A REFRENCE: $chunk" if ref $chunk;
    for my $char ( split '', $chunk ) {
      die "WHOAH! I DON'T KNOW WHAT THIS IS: [$char]\n" unless defined $self->{k}->{$char};
      $distance += $self->{k}->{$char};
    }
  }
  return $distance;
}

1;

=head1 SYNOPSIS:

ACME::KeyboardMarathon will calculate the approximate distance travelled by
fingers to type a given string of text.

This is useful to see just how many meter/miles/marathons your fingers have
run for you for your latest piece of code or writing.

=head1 METHODOLOGOY:

In proper typing, for all but the "home row" letters, our fingers must travel
a short horizontal distance to reach the key. For all keys, there is also a
short distance to press the key downward. 

Measurements were take on a standard-layout IBM type-M keyboard to the nearest 
1/3rd of a centimeter for both horizontal and vertical (key depth) travel
by the finger.

Additionally, use of the shift key was tracked and its distance was included
for each calculation.

This produces an index of "distance travelled" for each possible keypress, 
which is then used to calculate the "total distance travelled" for a given
piece of text.

=head1 DEFICIENCIES:

* This module calculates the linear distance traversed by adding vertical 
and horizontal motion of the finger. The motion traversed is actually an 
arc, and while that calculation would be more accurate, this is an 
ACME module, afterall. Send me a patch with the right math if you're bored.

* A QWERTY keyboard is assume. DVORAK people are thus left out in the cold. 
As they should be. The freaks.

* I assume there are no gaps between your keys. This means all those stylish 
Mac keyboard folks are actually doing more work than they're credited for. 
But I'm ok with that.

* I assume you actually use standard homerow position. Just like Mavis Beacon 
told you to.

* I assume you return to home row after each stroke and don't take shortcuts to
the next key. Lazy typists!

* I assume that you never make mistakes and never use backspaces while typing.
We're all perfect, yes?

* I assume that you do not type via the use if copy and paste. Especially, not
using copy and paste from google. Right? RIGHT?!?!??

* I'VE NEVER HEARD OF CAPS LOCK. YOU PRESSED THAT SHIFT KEY AND RETURNED TO 
HOME ROW FOR EVERY CAPITAL LETTER!!1!!one!

* I am a horrible American barbarian and have only bothered with the keys that
show up on my American barbarian keyboard. I'll add the LATIN-1 things with 
diacritics later, so I can feel better while still ignoring UTF's existance.

=head1 USAGE:

  use ACME::KeyboardMarathon;    

  my $akm = new ACME::KeyboardMarathon;

  my $distance_in_cm = $akm->distance($bigtext);

=head1 AUTHORSHIP:

As much as I wish I could be fully blamed for this, I must admit that
Mr. Efrain Klein came up with the awesome idea, took the time to make the
measurements, and wrote the original code in Python. I just made sure it 
was less readable, in Perl.

  ACME::KeyboardMarathon vVERSIONTAG DATETAG
  
  (c) 2012, Efrain Klein <efrain.klein@gmail.com > & Phillip Pollard <bennie@cpan.org>
  Released under the Perl Artistic License
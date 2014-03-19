package Acme::KeyboardMarathon;
$Acme::KeyboardMarathon::VERSION = 'VERSIONTAG';

use Carp;
use Data::Dumper;
use Math::BigInt;

use warnings;
use strict;

sub new {
  my @args = @_;
  my $class = shift @args;
  my $self = {};
  bless($self,$class);

  # all measures in cm

  my $DEPRESS_CONSTANT = 0.25;
  my $SHIFT_DISTANCE = 2;

  my %basic_distances = ( # basic distance traveled horizontally for a key
       '0'   => q{AaSsDdFfJjKkLl;: },
       '2'   => q{QqWwGgHhEeRrTtYyUuIiOoPpZzXxCcVvNnMm,<>./?'"},
       '4'   => q{]123478905Ii-_!@#$%&*()} . '}' . "\n",
       '4.5' => q{=+},
       '2.3' => '[' . '{'. "\t",
       '3.5' => 'Bb',
       '5'   => '6^`~',
       '5.5' => '\\|',
  );

  my %shifted; # lookup hash to see if a key is shifted
  for my $key ( split '', '!@#$%^&*()_+<>?:"{}|~\'' . join('','A'..'Z') ) {
    $shifted{$key}++;
  }

  for my $hdist ( keys %basic_distances ) {
    for my $key ( split '', $basic_distances{$hdist} ) {
      $self->{k}->{$key} = 100 * # Storing in 100ths of a CM to avoid floats
        ( $hdist + $DEPRESS_CONSTANT + ( $shifted{$key} ? $SHIFT_DISTANCE : 0 ) );
    }
  }

  #print Dumper($self->{k});
  return $self;
}

sub distance {
  my @args = @_;
  my $self = shift @args;
  my $distance = Math::BigInt->bzero();
  while ( my $chunk = shift @args ) {
    croak "FAR OUT! A REFERENCE: $chunk" if ref $chunk;
    for my $char ( split '', $chunk ) {
      unless ( defined $self->{k}->{$char} ) {
        carp "WHOAH! I DON'T KNOW WHAT THIS IS: [$char] assigning it a 2.5 cm distance\n";
        $self->{k}->{$char} = 2.5 * 100; # 100ths of a CM
      }
      $distance += $self->{k}->{$char};
    }
  }
  return int( $distance->as_int() / 100 );
}

1;
__END__

=head1 NAME

Acme::KeyboardMarathon - How far have your fingers ran?

=head1 SYNOPSIS

  use Acme::KeyboardMarathon;    

  my $akm = new Acme::KeyboardMarathon;

  my $distance_in_cm = $akm->distance($bigtext);

NB: Included in this distribution is an example script (marathon.pl) that can
be used to calculate distance from files provided as arguments:

  $> ./marathon.pl foo.txt bar.txt baz.txt
  114.05 m

=head1 DESCRIPTION

Acme::KeyboardMarathon will calculate the approximate distance traveled by
your fingers to type a given string of text.

This is useful to see just how many meter/miles/marathons your fingers have
ran for you to type your latest piece of code or writing.

=head1 METHODOLOGY

In proper typing, for all but the "home row" letters, our fingers must travel
a short horizontal distance to reach the key. For all keys, there is also a
short distance to press the key downward. 

Measurements were take on a standard-layout IBM type-M keyboard to the nearest 
1/3rd of a centimeter for both horizontal and vertical (key depth) travel
by the finger.

Additionally, use of the shift key was tracked and its distance was included
for each calculation.

This produces an index of "distance traveled" for each possible key-press, 
which is then used to calculate the "total distance traveled" for a given
piece of text.

=head1 BUGS AND LIMITATIONS

* This module calculates the linear distance traversed by adding vertical 
and horizontal motion of the finger. The motion traversed is actually an 
arc, and while that calculation would be more accurate, this is an 
Acme module, after all. Send me a patch with the right math if you're bored.

* A QWERTY keyboard is assumed. DVORAK people are thus left out in the cold. 
As they should be. The freaks.

* I assume there are no gaps between your keys. This means all those stylish 
Mac keyboard folks are actually doing more work than they're credited for. 
But I'm ok with that.

* I assume you actually use standard home row position. Just like Mavis Beacon 
told you to.

* I assume you return to home row after each stroke and don't take shortcuts to
the next key. Lazy typists!

* I assume that you never make mistakes and never use backspaces while typing.
We're all perfect, yes?

* I assume that you do not type via the use of copy and paste. Especially not
using copy and paste from Google. Right? RIGHT?!?!??

* I'VE NEVER HEARD OF CAPS LOCK. YOU PRESSED THAT SHIFT KEY AND RETURNED TO 
HOME ROW FOR EVERY CAPITAL LETTER!!!!!!!

* I am a horrible American barbarian and have only bothered with the keys that
show up on my American barbarian keyboard. I'll add the LATIN-1 things with 
diacritics later, so I can feel better while still ignoring UTF's existence.

=head1 BUGS AND SOURCE

	Bug tracking for this module: https://rt.cpan.org/Dist/Display.html?Name=Acme-KeyboardMarathon

	Source hosting: http://www.github.com/bennie/perl-Acme-KeyboardMarathon

=head1 VERSION

	Acme::KeyboardMarathon vVERSIONTAG (DATETAG)

=head1 COPYRIGHT

	(c) 2012-YEARTAG, Efrain Klein <efrain.klein@gmail.com> & Phillip Pollard <bennie@cpan.org>

=head1 LICENSE

This source code is released under the "Perl Artistic License 2.0," the text of
which is included in the LICENSE file of this distribution. It may also be
reviewed here: http://opensource.org/licenses/artistic-license-2.0

=head1 AUTHORSHIP

Efrain Klein <efrain.klein@gmail.com> & Phillip Pollard <bennie@cpan.org>

As much as I wish I could be fully blamed for this, I must admit that
Mr. Efrain Klein came up with the awesome idea, took the time to make the
measurements, and wrote the original code in Python. I just made sure it 
was less readable, in Perl.

Additional patches from Mark A. Smith. <jprogrammer082@gmail.com>

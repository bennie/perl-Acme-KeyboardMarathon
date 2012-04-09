ACME::KeyboardMarathon::VERSION='VERSIONTAG';

use strict;

package ACME::KeyboardMarathon;

sub new {
  my $class = shift @_;
  my $self = {};
  bless($self,$class);
  
=head3
#all measures in cm
DEPRESS_CONSTANT = 0.25
SHIFT_DISTANCE = 2
SHIFTED_KEYS = '!@#$%^&*()_+<>?:"{}|~'
FINGER_DISTANCES = (
    (2, 'qwghertyuiopzxcvnm,<>./?\'"'),
    (4, ']123478905i-_\n}!@#$%&*()'),
    (0, 'asdfjkl;: '),
    (4.5, '=+'),
    (5, '6^`~'),
    (2.3, '[{\t'),
    (5.5, '\\|'),
    (3.5, 'b')
)
=cut

  return $self;
}

1;

=head1 SYNOPSIS:

Tkx::Login provides a simple login interface for Tkx applications. Given
a window value to extend, it opens a new window, queries for username and
password and returns the values.

=head1 USAGE:

  use Tkx::Login;
    
  my ($username,$password) = Tkx::Login::askpass($mainwindow,$message,$pre_user,$pre_password);

  Parameters:
  
  $mainwindow - Current MainWindow in your Tkx app. (required)
  $message - A text message to display in the login window. (optional)
  $pre_user - A value to pre-populate the username blank with. (optional)
  $pre_pass - A value to pre-populate the password blank with. This will be obscured with asterisks. (optional)

=head1 AUTHORSHIP:

  Tkx::Login vVERSIONTAG DATETAG

  (c) 2012-YEARTAG, Phillip Pollard <bennie@cpan.org>
  Released under the Perl Artistic License
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'ACME::KeyboardMarathon',
    'VERSION_FROM' => 'lib/ACME/KeyboardMarathon.pm',
    'PREREQ_PM'    => { },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/ACME/KeyboardMarathon.pm',
       AUTHOR     => 'Phillip Pollard <bennie@cpan.org>') : ()),
);

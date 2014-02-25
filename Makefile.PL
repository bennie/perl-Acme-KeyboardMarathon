use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Acme::KeyboardMarathon',
    'VERSION_FROM' => 'lib/Acme/KeyboardMarathon.pm',
    'PREREQ_PM'    => { },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Acme/KeyboardMarathon.pm',
       AUTHOR     => 'Phillip Pollard <bennie@cpan.org>') : ()),
);

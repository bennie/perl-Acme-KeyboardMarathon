use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Tkx::Login',
    'VERSION_FROM' => 'lib/Tkx/Login.pm',
    'PREREQ_PM'    => { Tkx => 1.00 },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/Tkx/Login.pm',
       AUTHOR     => 'Phillip Pollard <bennie@cpan.org>') : ()),
);

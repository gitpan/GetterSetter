use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'GetterSetter',
    'VERSION_FROM'	=> 'GetterSetter.pm', # finds $VERSION
    'PREREQ_PM'		=> {}, # e.g., Module::Name => 1.1
    'dist'		=> {COMPRESS => 'gzip', SUFFIX => '.gz'},
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'GetterSetter.pm', # retrieve abstract from module
       AUTHOR     => 'Eric Anderson <eric.anderson@cordata.net>') : ()),
);

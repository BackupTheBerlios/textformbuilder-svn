#use 5.008004;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Text::FormBuilder',
    VERSION_FROM      => 'lib/Text/FormBuilder.pm', # finds $VERSION
    EXE_FILES         => [ 'bin/fb.pl' ],
    PREREQ_PM         => { 
                            CGI::FormBuilder => 2.12,
                         }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Text/FormBuilder.pm', # retrieve abstract from module
       AUTHOR         => 'Peter Eichman <peichman@wam.umd.edu>') : ()),
);

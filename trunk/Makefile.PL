use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Text::FormBuilder',
    VERSION_FROM      => 'lib/Text/FormBuilder.pm', # finds $VERSION
    EXE_FILES         => [ 'bin/fb.pl' ],
    PREREQ_PM         => { 
                            CGI::FormBuilder => 3.0,
                            Parse::RecDescent => 1.94,
                            Text::Template => 1.44,
                            # requirement for Class::ParseText::Base
                            Class::Base => 0.03,
                         }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Text/FormBuilder.pm', # retrieve abstract from module
       AUTHOR         => 'Peter Eichman <peichman@cpan.org>') : ()),
);

use strict;
use warnings;

use Getopt::Long;
use Text::FormBuilder;

GetOptions(
    'o=s' => \my $outfile,
    'D=s' => \my %fb_options,
);
my $src_file = shift;

Text::FormBuilder->parse($src_file)->build(%fb_options)->write($outfile);

=head1 NAME

fb - Frontend script for Text::FormBuilder

=head1 SYNOPSIS

    $ fb my_form.txt -o form.html
    
    $ fb my_form.txt -o my_form.html -D action=/cgi-bin/my-script.pl

=head1 OPTIONS

=over

=item -D <parameter>=<value>

Define options that are passed to the CGI::FormBuilder object. For example,
to create a form on a static html page, and have it submitted to an external
CGI script, you would want to define the C<action> parameter:

    $ fb ... -D action=/cgi-bin/some_script.pl

=item -o <output file>

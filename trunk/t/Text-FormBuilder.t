# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Text-FormBuilder.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('Text::FormBuilder'); };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $p = Text::FormBuilder->new;
isa_ok($p, 'Text::FormBuilder', 'new parser');
isa_ok($p->parse_text('')->build->form, 'CGI::FormBuilder',  'generated CGI::FormBuilder object');

my $p2 = Text::FormBuilder->parse_text('');
isa_ok($p2, 'Text::FormBuilder', 'new parser (from parse_text as class method)');

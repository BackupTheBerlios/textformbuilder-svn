# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Text-FormBuilder.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More qw(no_plan); #tests => 6;
BEGIN { use_ok('Text::FormBuilder'); };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $p = Text::FormBuilder->new;
isa_ok($p, 'Text::FormBuilder', 'new parser');
isa_ok($p->parse_text('')->build->form, 'CGI::FormBuilder',  'generated CGI::FormBuilder object (build->form)');
isa_ok($p->parse_text('')->form,        'CGI::FormBuilder',  'generated CGI::FormBuilder object (form)');

$p = Text::FormBuilder->parse_text('');
isa_ok($p, 'Text::FormBuilder', 'new parser (from parse_text as class method)');

$p = Text::FormBuilder->parse(\'');
isa_ok($p, 'Text::FormBuilder', 'new parser (from parse as class method)');


my $simple = <<END;
name
email
phone
END

my $form = $p->parse(\$simple)->form;
# we should have three fields
is(keys %{ $form->fields }, 3, 'correct number of fields');

my $p2 = Text::FormBuilder->parse_array([qw(code title semester instructor)]);
is(keys %{ $p2->form->fields }, 4, 'correct number of fields from parse_array');
$p2->write;

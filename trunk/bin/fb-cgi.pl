use strict;
use warnings;

use Text::FormBuilder;
use CGI;

my $q = CGI->new;

my $src_file = get_src_file($q->param('form_id'));

my $parser = Text::FormBuilder->new;
my $form = $parser->parse($src_file)->build(method => 'POST', params => $q)->form;

if ($form->submitted && $form->validate) {
    # TODO:
    # call storage function
    my $plugin = 'DumpParams';
    eval "use $plugin;";
    
    if ($plugin->process($q)) {
        # show thank you page
        #print $q->header('text/plain');
        #print "Thank you for your input!\n"
    } else {
        # there was an error processing the results
    }
    
} else {
    print $q->header;
    print $form->render;
}

sub get_src_file {
    my $form_id = shift;
    return "$form_id.txt";
}

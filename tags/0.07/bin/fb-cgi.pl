use strict;
use warnings;

use Text::FormBuilder;
use CGI;

my $q = CGI->new;

my $form_id = $q->param('form_id');
my $src_file = get_src_file($form_id);

my $parser = Text::FormBuilder->new;
my $form = $parser->parse($src_file)->build(method => 'POST', params => $q)->form;

if (1 or $form->submitted && $form->validate) {

    # call storage function

    my $plugin = 'StoreSQLite';
    
    eval "use $plugin;";
    die "Can't use $plugin; $@" if $@;
    die "Plugin $plugin doesn't know how to process" unless $plugin->can('process');

    # plugin process method should return a true value
    if ($plugin->process($q, $form, $form_id)) {
        # show thank you page
    } else {
        # there was an error processing the results
        die "There was an error processing the submission: " . $plugin->error;
    }
    
} else {
    print $q->header;
    print $form->render;
}

sub get_src_file {
    my $form_id = shift;
    my $form_spec_path = 'F:/Projects/SurveyMaker/form_specs';
    return "$form_spec_path/$form_id.txt";
}

package Text::FormBuilder;

use strict;
use warnings;

our $VERSION = '0.03';

use Text::FormBuilder::Parser;
use CGI::FormBuilder;

sub new {
    my $invocant = shift;
    my $class = ref $invocant || $invocant;
    my $self = {
        parser => Text::FormBuilder::Parser->new,
    };
    return bless $self, $class;
}

sub parse {
    my ($self, $filename) = @_;
    
    # so it can be called as a class method
    $self = $self->new unless ref $self;
    
    local $/ = undef;
    open SRC, "< $filename";
    my $src = <SRC>;
    close SRC;
    
    return $self->parse_text($src);
}

sub parse_text {
    my ($self, $src) = @_;
    # so it can be called as a class method
    $self = $self->new unless ref $self;
    $self->{form_spec} = $self->{parser}->form_spec($src);
    return $self;
}

sub build {
    my ($self, %options) = @_;
    
    $self->{build_options} = { %options };
    
    # our custom %options:
    # form_only: use only the form part of the template
    my $form_only = $options{form_only};
    delete $options{form_only};
    
    # substitute in custom pattern definitions for field validation
    if (my %patterns = %{ $self->{form_spec}{patterns} }) {
        foreach (@{ $self->{form_spec}{fields} }) {
            if ($$_{validate} and exists $patterns{$$_{validate}}) {
                $$_{validate} = $patterns{$$_{validate}};
            }
        }
    }
    
    # remove extraneous undefined values
    for my $field (@{ $self->{form_spec}{fields} }) {
        defined $$field{$_} or delete $$field{$_} foreach keys %{ $field };
    }
    
    # so we don't get all fields required
    foreach (@{ $self->{form_spec}{fields} }) {
        delete $$_{validate} unless $$_{validate};
    }
    
    # substitute in list names
    if (my %lists = %{ $self->{form_spec}{lists} }) {
        foreach (@{ $self->{form_spec}{fields} }) {
            next unless $$_{list};
            
            $$_{list} =~ s/^\@//;   # strip leading @ from list var name
            
            # a hack so we don't get screwy reference errors
            if (exists $lists{$$_{list}}) {
                my @list;
                push @list, { %$_ } foreach @{ $lists{$$_{list}} };
                $$_{options} = \@list;
            }
        } continue {
            delete $$_{list};
        }
    }

##     #TODO: option switch for this
##     #TODO: goes with CGI::FormBuilder 2.13
##     foreach (@{ $self->{form_spec}{fields} }) {
##         $$_{ulist} = 1 if $$_{type} and $$_{type} =~ /checkbox|radio/ and @{ $$_{options} } >= 3;
##     }
    
    $self->{form} = CGI::FormBuilder->new(
        method => 'GET',
        javascript => 0,
        keepextras => 1,
        title => $self->{form_spec}{title},
        fields => [ map { $$_{name} } @{ $self->{form_spec}{fields} } ],
        template => {
            type => 'Text',
            engine => {
                TYPE       => 'STRING',
                SOURCE     => $form_only ? $self->_form_template : $self->_template,
                DELIMITERS => [ qw(<% %>) ],
            },
            data => {
                headings => $self->{form_spec}{headings},
                author   => $self->{form_spec}{author},
            },
        },
        %options,
    );
    $self->{form}->field(%{ $_ }) foreach @{ $self->{form_spec}{fields} };
    
    return $self;
}

sub write {
    my ($self, $outfile) = @_;
    if ($outfile) {
        open FORM, "> $outfile";
        print FORM $self->form->render;
        close FORM;
    } else {
        print $self->form->render;
    }
}

sub write_module {
    my ($self, $package) = @_;

    use Data::Dumper;
    # don't dump $VARn names
    $Data::Dumper::Terse = 1;
    
    my $title = $self->{form_spec}{title} || '';
    my $author = $self->{form_spec}{author} || '';
    my $headings = Data::Dumper->Dump([$self->{form_spec}{headings}],['headings']);
    my $fields = Data::Dumper->Dump([ [ map { $$_{name} } @{ $self->{form_spec}{fields} } ] ],['fields']);
    
    my $source = $self->{build_options}{form_only} ? $self->_form_template : $self->_template;
    
    my $options = keys %{ $self->{build_options} } > 0 ? Data::Dumper->Dump([$self->{build_options}],['*options']) : '';
    
    my $field_setup = join(
        "\n", 
        map { '$cgi_form->field' . Data::Dumper->Dump([$_],['*field']) . ';' } @{ $self->{form_spec}{fields} }
    );
    
    my $module = <<END;
package $package;
use strict;
use warnings;

use CGI::FormBuilder;

sub form {
    my \$cgi = shift;
    my \$cgi_form = CGI::FormBuilder->new(
        method => 'GET',
        params => \$cgi,
        javascript => 0,
        keepextras => 1,
        title => q[$title],
        fields => $fields,
        template => {
            type => 'Text',
            engine => {
                TYPE       => 'STRING',
                SOURCE     => q[$source],
                DELIMITERS => [ qw(<% %>) ],
            },
            data => {
                headings => $headings,
                author   => q[$author],
            },
        },
        $options
    );
    
    $field_setup
    
    return \$cgi_form;
}

# module return
1;
END
    my $outfile = (split(/::/, $package))[-1] . '.pm';
    
    if ($outfile) {
        open FORM, "> $outfile";
        print FORM $module;
        close FORM;
    } else {
        print $module;
    }
}

sub form { shift->{form} }

sub _form_template {
q[<p id="instructions">(Required fields are marked in <strong>bold</strong>.)</p>
<% $start %>
<table>
<% my $i; foreach(@fields) {
    $OUT .= qq[  <tr><th class="sectionhead" colspan="2"><h2>$headings[$i]</h2></th></tr>\n] if $headings[$i];
    $OUT .= qq[  <tr>];
    $OUT .= '<th class="label">' . ($$_{required} ? qq[<strong class="required">$$_{label}:</strong>] : "$$_{label}:") . '</th>';
    $OUT .= qq[<td>$$_{field} $$_{comment}</td></tr>\n];
    $i++;
} %>
  <tr><th></th><td style="padding-top: 1em;"><% $submit %></td></tr>
</table>
<% $end %>
];
}

sub _template {
    my $self = shift;
q[<html>
<head>
  <title><% $title %><% $author ? ' - ' . ucfirst $author : '' %></title>
  <style type="text/css">
    #author, #footer { font-style: italic; }
    th { text-align: left; }
    th h2 { padding: .125em .5em; background: #eee; }
    th.label { font-weight: normal; text-align: right; vertical-align: top; }
  </style>
</head>
<body>

<h1><% $title %></h1>
<% $author ? qq[<p id="author">Created by $author</p>] : '' %>
] . $self->_form_template . q[
<hr />
<div id="footer">
  <p id="creator">Made with <a href="http://formbuilder.org/">CGI::FormBuilder</a> version <% $CGI::FormBuilder::VERSION %>.</p>
</div>
</body>
</html>
];
}

sub dump { 
    eval "use YAML;";
    unless ($@) {
        print YAML::Dump(shift->{form_spec});
    } else {
        warn "Can't dump form spec structure: $@";
    }
}


# module return
1;

=head1 NAME

Text::FormBuilder - Parser for a minilanguage describing web forms

=head1 SYNOPSIS

    my $parser = Text::FormBuilder->new;
    $parser->parse($src_file);
    
    # returns a new CGI::FormBuilder object with the fields
    # from the input form spec
    my $form = $parser->form;

=head1 DESCRIPTION

=head2 new

=head2 parse

    $parser->parse($src_file);
    
    # or as a class method
    my $parser = Txt::FormBuilder->parse($src_file);

=head2 parse_text

=head2 build

    $parser->build(%options);

Builds the CGI::FormBuilder object. Options directly used by C<build> are:

=over

=item form_only

Only uses the form portion of the template, and omits the surrounding html,
title, author, and the standard footer.

=back

All other options given to C<build> are passed on verbatim to the
L<CGI::FormBuilder> constructor. Any options given here override the
defaults that this module uses.

=head2 form

    my $form = $parser->form;

Returns the L<CGI::FormBuilder> object.

=head2 write

    $parser->write($out_file);
    # or just print to STDOUT
    $parser->write;

Calls C<render> on the FormBuilder form, and either writes the resulting HTML
to a file, or to STDOUT if no filename is given.

=head2 write_module

    $parser->write_module($package);

Takes a package name, and writes out a new module that can be used by your
CGI script to render the form. This way, you only need CGI::FormBuilder on
your server, and you don't have to parse the form spec each time you want 
to display your form.

    #!/usr/bin/perl -w
    use strict;
    
    # your CGI script
    
    use CGI;
    use MyForm;
    
    my $q = CGI->new;
    my $form = MyForm::form($q);
    
    # do the standard CGI::FormBuilder stuff
    if ($form->submitted && $form->validate) {
        # process results
    } else {
        print $q->header;
        print $form->render;
    }
    

=head2 dump

Uses L<YAML> to print out a human-readable representaiton of the parsed
form spec.

=head1 LANGUAGE

    field_name[size]|descriptive label[hint]:type=default{option1[display string],option2[display string],...}//validate
    
    !title ...
    
    !author ...
    
    !pattern name /regular expression/
    !list name {
        option1[display string],
        option2[display string],
        ...
    }
    
    !list name &{ CODE }
    
    !head ...

=head2 Directives

=over

=item C<!pattern>

Defines a validation pattern.

=item C<!list>

Defines a list for use in a C<radio>, C<checkbox>, or C<select> field.

=item C<!title>

=item C<!author>

=item C<!head>

Inserts a heading between two fields. There can only be one heading between
any two fields; the parser will warn you if you try to put two headings right
next to each other.

=back

=head2 Fields

Form fields are each described on a single line.

If you have a list of options that is too long to fit comfortably on one line,
consider using the C<!list> directive.

=head2 Comments

    # comment ...

Any line beginning with a C<#> is considered a comment.

=head1 TODO

=head2 Langauge

Directive for a descriptive or explanatory paragraph about the form

=head1 SEE ALSO

L<CGI::FormBuilder>

=cut

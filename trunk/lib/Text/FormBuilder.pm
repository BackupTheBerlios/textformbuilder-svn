package Text::FormBuilder;

use strict;
use warnings;

use vars qw($VERSION);

$VERSION = '0.05';

use Carp;
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
    my ($self, $source) = @_;
    if (ref $source && ref $source eq 'SCALAR') {
        $self->parse_text($$source);
    } else {
        $self->parse_file($source);
    }
}

sub parse_file {
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
    
    # mark structures as not built (newly parsed text)
    $self->{built} = 0;
    
    return $self;
}

sub build {
    my ($self, %options) = @_;

    # save the build options so they can be used from write_module
    $self->{build_options} = { %options };
    
    # our custom %options:
    # form_only: use only the form part of the template
    my $form_only = $options{form_only};
    delete $options{form_only};
    
    # substitute in custom pattern definitions for field validation
    if (my %patterns = %{ $self->{form_spec}{patterns} || {} }) {
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
    if (my %lists = %{ $self->{form_spec}{lists} || {} }) {
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

    # TODO: configurable threshold for this
    foreach (@{ $self->{form_spec}{fields} }) {
        $$_{ulist} = 1 if defined $$_{options} and @{ $$_{options} } >= 3;
    }
    
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
                headings    => $self->{form_spec}{headings},
                author      => $self->{form_spec}{author},
                description => $self->{form_spec}{description},
            },
        },
        %options,
    );
    $self->{form}->field(%{ $_ }) foreach @{ $self->{form_spec}{fields} };
    
    # mark structures as built
    $self->{built} = 1;
    
    return $self;
}

sub write {
    my ($self, $outfile) = @_;
    
    # automatically call build if needed to
    # allow the new->parse->write shortcut
    $self->build unless $self->{built};
    
    if ($outfile) {
        open FORM, "> $outfile";
        print FORM $self->form->render;
        close FORM;
    } else {
        print $self->form->render;
    }
}

sub write_module {
    my ($self, $package, $use_tidy) = @_;

    croak 'Expecting a package name' unless $package;
    
    # automatically call build if needed to
    # allow the new->parse->write shortcut
    $self->build unless $self->{built};
    
    # conditionally use Data::Dumper
    eval 'use Data::Dumper;';
    die "Can't write module; need Data::Dumper. $@" if $@;
    
    # don't dump $VARn names
    $Data::Dumper::Terse = 1;
    
    my $title       = $self->{form_spec}{title} || '';
    my $author      = $self->{form_spec}{author} || '';
    my $description = $self->{form_spec}{description} || '';
    
    my $headings    = Data::Dumper->Dump([$self->{form_spec}{headings}],['headings']);
    my $fields      = Data::Dumper->Dump([ [ map { $$_{name} } @{ $self->{form_spec}{fields} } ] ],['fields']);
    
    my %options = %{ $self->{build_options} };
    my $source = $options{form_only} ? $self->_form_template : $self->_template;
    
    delete $options{fomr_only};
    
    my $form_options = keys %options > 0 ? Data::Dumper->Dump([$self->{build_options}],['*options']) : '';
    
    my $field_setup = join(
        "\n", 
        map { '$cgi_form->field' . Data::Dumper->Dump([$_],['*field']) . ';' } @{ $self->{form_spec}{fields} }
    );
    
    my $module = <<END;
package $package;
use strict;
use warnings;

use CGI::FormBuilder;

sub get_form {
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
                description => q[$description],
            },
        },
        $form_options
    );
    
    $field_setup
    
    return \$cgi_form;
}

# module return
1;
END
    
    my $outfile = (split(/::/, $package))[-1] . '.pm';
    
    if ($use_tidy) {
        # clean up the generated code, if asked
        eval 'use Perl::Tidy';
        die "Can't tidy the code: $@" if $@;
        Perl::Tidy::perltidy(source => \$module, destination => $outfile);
    } else {
        # otherwise, just print as is
        open FORM, "> $outfile";
        print FORM $module;
        close FORM;
    }
}

sub form {
    my $self = shift;
    
    # automatically call build if needed to
    # allow the new->parse->write shortcut
    $self->build unless $self->{built};

    return $self->{form};
}

sub _form_template {
q[<% $description ? qq[<p id="description">$description</p>] : '' %>
<% (grep { $_->{required} } @fields) ? qq[<p id="instructions">(Required fields are marked in <strong>bold</strong>.)</p>] : '' %>
<% $start %>
<table>
<% my $i; foreach(@fields) {
    $OUT .= qq[  <tr><th class="sectionhead" colspan="2"><h2>$headings[$i]</h2></th></tr>\n] if $headings[$i];
    $OUT .= $$_{invalid} ? qq[  <tr class="invalid">] : qq[  <tr>];
    $OUT .= '<th class="label">' . ($$_{required} ? qq[<strong class="required">$$_{label}:</strong>] : "$$_{label}:") . '</th>';
    if ($$_{invalid}) {
        $OUT .= qq[<td>$$_{field} $$_{comment} Missing or invalid value.</td></tr>\n];
    } else {
        $OUT .= qq[<td>$$_{field} $$_{comment}</td></tr>\n];
    }
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
    td ul { list-style: none; padding-left: 0; margin-left: 0; }
  </style>
</head>
<body>

<h1><% $title %></h1>
<% $author ? qq[<p id="author">Created by $author</p>] : '' %>
] . $self->_form_template . q[
<hr />
<div id="footer">
  <p id="creator">Made with <a href="http://formbuilder.org/">CGI::FormBuilder</a> version <% CGI::FormBuilder->VERSION %>.</p>
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

Text::FormBuilder - Parser for a minilanguage for generating web forms

=head1 SYNOPSIS

    use Text::FormBuilder;
    
    my $parser = Text::FormBuilder->new;
    $parser->parse($src_file);
    
    # returns a new CGI::FormBuilder object with
    # the fields from the input form spec
    my $form = $parser->form;
    
    # write a My::Form module to Form.pm
    $parser->write_module('My::Form');

=head1 DESCRIPTION

=head2 new

=head2 parse

    # parse a file
    $parser->parse($filename);
    
    # or pass a scalar ref for parse a literal string
    $parser->parse(\$string);

Parse the file or string. Returns the parser object.

=head2 parse_file

    $parser->parse_file($src_file);
    
    # or as a class method
    my $parser = Text::FormBuilder->parse($src_file);

=head2 parse_text

    $parser->parse_text($src);

Parse the given C<$src> text. Returns the parser object.

=head2 build

    $parser->build(%options);

Builds the CGI::FormBuilder object. Options directly used by C<build> are:

=over

=item C<form_only>

Only uses the form portion of the template, and omits the surrounding html,
title, author, and the standard footer. This does, however, include the
description as specified with the C<!description> directive.

=back

All other options given to C<build> are passed on verbatim to the
L<CGI::FormBuilder> constructor. Any options given here override the
defaults that this module uses.

The C<form>, C<write>, and C<write_module> methods will all call
C<build> with no options for you if you do not do so explicitly.
This allows you to say things like this:

    my $form = Text::FormBuilder->new->parse('formspec.txt')->form;

However, if you need to specify options to C<build>, you must call it
explictly after C<parse>.

=head2 form

    my $form = $parser->form;

Returns the L<CGI::FormBuilder> object. Remember that you can modify
this object directly, in order to (for example) dynamically populate
dropdown lists or change input types at runtime.

=head2 write

    $parser->write($out_file);
    # or just print to STDOUT
    $parser->write;

Calls C<render> on the FormBuilder form, and either writes the resulting HTML
to a file, or to STDOUT if no filename is given.

=head2 write_module

    $parser->write_module($package, $use_tidy);

Takes a package name, and writes out a new module that can be used by your
CGI script to render the form. This way, you only need CGI::FormBuilder on
your server, and you don't have to parse the form spec each time you want 
to display your form. The generated module has one function (not exported)
called C<get_form>, that takes a CGI object as its only argument, and returns
a CGI::FormBuilder object.

First, you parse the formspec and write the module, which you can do as a one-liner:

    $ perl -MText::FormBuilder -e"Text::FormBuilder->parse('formspec.txt')->write_module('My::Form')"

And then, in your CGI script, use the new module:

    #!/usr/bin/perl -w
    use strict;
    
    use CGI;
    use My::Form;
    
    my $q = CGI->new;
    my $form = My::Form::get_form($q);
    
    # do the standard CGI::FormBuilder stuff
    if ($form->submitted && $form->validate) {
        # process results
    } else {
        print $q->header;
        print $form->render;
    }

If you pass a true value as the second argument to C<write_module>, the parser
will run L<Perl::Tidy> on the generated code before writing the module file.

    # write tidier code
    $parser->write_module('My::Form', 1);

=head2 dump

Uses L<YAML> to print out a human-readable representation of the parsed
form spec.

=head1 LANGUAGE

    field_name[size]|descriptive label[hint]:type=default{option1[display string],...}//validate
    
    !title ...
    
    !author ...
    
    !description {
        ...
    }
    
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

=item C<!description>

A brief description of the form. Suitable for special instructions on how to
fill out the form.

=item C<!head>

Inserts a heading between two fields. There can only be one heading between
any two fields; the parser will warn you if you try to put two headings right
next to each other.

=back

=head2 Fields

Form fields are each described on a single line. The simplest field is just a
name:

    color

This yields a form with one text input field of the default size named `color'.
The label for this field as generated by CGI::FormBuilder would be ``Color''.
To add a longer or more descriptive label, use:

    color|Favorite color

Field names cannot contain whitespace, but the descriptive label can.

To use a different input type:

    color|Favorite color:select{red,blue,green}

Recognized input types are the same as those used by CGI::FormBuilder:

    text        # the default
    textarea
    select
    radio
    checkbox
    static

This example also shows how you can list multiple values for the input types
that take multiple values (C<select>, C<radio>, and C<checkbox>). Values are
in a comma-separated list inside curly braces. Whitespace between values is
irrelevant, although there cannot be any whitespace within a value.

To add more descriptive display text to a vlaue in a list, add a square-bracketed
``subscript,'' as in:

    ...:select{red[Scarlet],blue[Azure],green[Olive Drab]}

As you can see, spaces I<are> allowed within the display text for a value.

If you have a list of options that is too long to fit comfortably on one line,
consider using the C<!list> directive:

    !list MONTHS {
        1[January],
        2[February],
        3[March],
        # and so on...
    }
    
    month:select@MONTHS

There is another form of the C<!list> directive: the dynamic list:

    !list RANDOM &{ map { rand } (0..5) }

The code inside the C<&{ ... }> is C<eval>ed by C<build>, and the results
are stuffed into the list. The C<eval>ed code can either return a simple
list, as the example does, or the fancier C<( { value1 => 'Description 1'},
{ value2 => 'Description 2}, ...)> form.

B<NOTE:> This feature of the language may go away unless I find a compelling
reason for it in the next few versions. What I really wanted was lists that
were filled in at run-time (e.g. from a database), and that can be done easily
enough with the CGI::FormBuilder object directly.

You can also supply a default value to the field. To get a default value of
C<green> for the color field:

    color|Favorite color:select=green{red,blue,green}

To validate a field, include a validation type at the end of the field line:

    email|Email address//EMAIL

Valid validation types include any of the builtin defaults from CGI::FormBuilder,
or the name of a pattern that you define with the C<!pattern> directive elsewhere
in your form spec:

    !pattern DAY /^([1-3][0-9])|[1-9]$/
    
    last_day//DAY

If you just want a required value, use the builtin validation type C<VALUE>:

    title//VALUE

=head2 Comments

    # comment ...

Any line beginning with a C<#> is considered a comment.

=head1 TODO

C<!include> directive to include external formspec files

Field groups all on one line in the generated form

Better tests!

=head1 SEE ALSO

L<CGI::FormBuilder>

=head1 AUTHOR

Peter Eichman <peichman@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright E<copy>2004 by Peter Eichman.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

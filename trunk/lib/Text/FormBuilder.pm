package Text::FormBuilder;

use strict;
use warnings;

use vars qw($VERSION);

$VERSION = '0.06_03';

use Carp;
use Text::FormBuilder::Parser;
use CGI::FormBuilder;

# the static default options passed to CGI::FormBuilder->new
my %DEFAULT_OPTIONS = (
    method => 'GET',
    javascript => 0,
    keepextras => 1,
);

# the built in CSS for the template
my $DEFAULT_CSS = <<END;
table { padding: 1em; }
#author, #footer { font-style: italic; }
caption h2 { padding: .125em .5em; background: #ccc; text-align: left; }
th { text-align: left; }
th h3 { padding: .125em .5em; background: #eee; }
th.label { font-weight: normal; text-align: right; vertical-align: top; }
td ul { list-style: none; padding-left: 0; margin-left: 0; }
.sublabel { color: #999; }
.invalid { background: red; }
END

# default messages that can be localized
my %DEFAULT_MESSAGES = (
    text_author   => 'Created by %s',
    text_madewith => 'Made with %s version %s',
    text_required => '(Required fields are marked in <strong>bold</strong>.)',
    text_invalid  => 'Missing or invalid value.',
);

my $DEFAULT_CHARSET = 'iso-8859-1';

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
    open SRC, "< $filename" or croak "[Text::FormBuilder::parse_file] Can't open $filename: $!" and return;
    my $src = <SRC>;
    close SRC;
    
    return $self->parse_text($src);
}

sub parse_text {
    my ($self, $src) = @_;
    
    # so it can be called as a class method
    $self = $self->new unless ref $self;
    
    # append a newline so that it can be called on a single field easily
    $src .= "\n";
    
    $self->{form_spec} = $self->{parser}->form_spec($src);
    
    # mark structures as not built (newly parsed text)
    $self->{built} = 0;
    
    return $self;
}

# this is where a lot of the magic happens
sub build {
    my ($self, %options) = @_;
    
    # our custom %options:
    # form_only: use only the form part of the template
    my $form_only = $options{form_only};
    
    # css, extra_css: allow for custom inline stylesheets
    #   neat trick: extra_css => '@import(my_external_stylesheet.css);'
    #   will let you use an external stylesheet
    #   CSS Hint: to get multiple sections to all line up their fields,
    #   set a standard width for th.label
    my $css;
    $css = $options{css} || $DEFAULT_CSS;
    $css .= $options{extra_css} if $options{extra_css};
    
    # messages
    if ($options{messages}) {
        # if its a hashref, we'll just pass it on to CGI::FormBuilder
        
        if (my $ref = ref $options{messages}) {
            # hashref pass on to CGI::FormBuilder
            croak "[Text::FormBuilder] Argument to 'messages' option must be a filename or hashref" unless $ref eq 'HASH';
            while (my ($key,$value) = each %DEFAULT_MESSAGES) {
                $options{messages}{$key} ||= $DEFAULT_MESSAGES{$key};
            }
        } else {
            # filename, just *warn* on missing, and use defaults
            if (-f $options{messages} && -r _ && open(MESSAGES, "< $options{messages}")) {
                $options{messages} = { %DEFAULT_MESSAGES };
                while(<MESSAGES>) {
                    next if /^\s*#/ || /^\s*$/;
                    chomp;
                    my($key,$value) = split ' ', $_, 2;
                    ($options{messages}{$key} = $value) =~ s/\s+$//;
                }
                close MESSAGES;
            } else {
                carp "[Text::FormBuilder] Could not read messages file $options{messages}: $!";
            }
        }
    } else {
        $options{messages} = { %DEFAULT_MESSAGES };
    }
    
    my $charset = $options{charset};
    
    # save the build options so they can be used from write_module
    $self->{build_options} = { %options };
    
    # remove our custom options before we hand off to CGI::FormBuilder
    delete $options{$_} foreach qw(form_only css extra_css charset);
    
    # expand groups
    my %groups = %{ $self->{form_spec}{groups} || {} };
    for my $section (@{ $self->{form_spec}{sections} || [] }) {
        foreach (grep { $$_[0] eq 'group' } @{ $$section{lines} }) {
            $$_[1]{group} =~ s/^\%//;       # strip leading % from group var name
            
            if (exists $groups{$$_[1]{group}}) {
                my @fields; # fields in the group
                push @fields, { %$_ } foreach @{ $groups{$$_[1]{group}} };
                for my $field (@fields) {
                    $$field{label} ||= ucfirst $$field{name};
                    $$field{name} = "$$_[1]{name}_$$field{name}";                
                }
                $_ = [ 'group', { label => $$_[1]{label} || ucfirst(join(' ',split('_',$$_[1]{name}))), group => \@fields } ];
            }
        }
    }
    
    # the actual fields that are given to CGI::FormBuilder
    $self->{form_spec}{fields} = [];
    
    for my $section (@{ $self->{form_spec}{sections} || [] }) {
        for my $line (@{ $$section{lines} }) {
            if ($$line[0] eq 'group') {
                push @{ $self->{form_spec}{fields} }, $_ foreach @{ $$line[1]{group} };
            } elsif ($$line[0] eq 'field') {
                push @{ $self->{form_spec}{fields} }, $$line[1];
            }
        }
    }
    
    # substitute in custom pattern definitions for field validation
    if (my %patterns = %{ $self->{form_spec}{patterns} || {} }) {
        foreach (@{ $self->{form_spec}{fields} }) {
            if ($$_{validate} and exists $patterns{$$_{validate}}) {
                $$_{validate} = $patterns{$$_{validate}};
            }
        }
    }
    
    # substitute in list names
    my %lists = %{ $self->{form_spec}{lists} || {} };
    foreach (@{ $self->{form_spec}{fields} }) {
        next unless $$_{list};
        
        $$_{list} =~ s/^\@//;   # strip leading @ from list var name
        
        # a hack so we don't get screwy reference errors
        if (exists $lists{$$_{list}}) {
            my @list;
            push @list, { %$_ } foreach @{ $lists{$$_{list}} };
            $$_{options} = \@list;
        } else {
            # assume that the list name is a builtin 
            # and let it fall through to CGI::FormBuilder
            $$_{options} = $$_{list};
        }
    } continue {
        delete $$_{list};
    }
    
    # special case single-value checkboxes
    foreach (grep { $$_{type} && $$_{type} eq 'checkbox' } @{ $self->{form_spec}{fields} }) {
        unless ($$_{options}) {
            $$_{options} = [ { $$_{name} => $$_{label} || ucfirst join(' ',split(/_/,$$_{name})) } ];
        }
    }
    
    # TODO: configurable threshold for this
    foreach (@{ $self->{form_spec}{fields} }) {
        $$_{ulist} = 1 if ref $$_{options} and @{ $$_{options} } >= 3;
    }
    
    # remove extraneous undefined values
    for my $field (@{ $self->{form_spec}{fields} }) {
        defined $$field{$_} or delete $$field{$_} foreach keys %{ $field };
    }
    
    # remove false $$_{required} params because this messes up things at
    # the CGI::FormBuilder::field level; it seems to be marking required
    # based on the existance of a 'required' param, not whether it is
    # true or defined
    $$_{required} or delete $$_{required} foreach @{ $self->{form_spec}{fields} };

    $self->{form} = CGI::FormBuilder->new(
        %DEFAULT_OPTIONS,
        # need to explicity set the fields so that simple text fields get picked up
        fields   => [ map { $$_{name} } @{ $self->{form_spec}{fields} } ],
        required => [ map { $$_{name} } grep { $$_{required} } @{ $self->{form_spec}{fields} } ],
        title => $self->{form_spec}{title},
        text  => $self->{form_spec}{description},
        template => {
            type => 'Text',
            engine => {
                TYPE       => 'STRING',
                SOURCE     => $form_only ? $self->_form_template : $self->_template($css, $charset),
                DELIMITERS => [ qw(<% %>) ],
            },
            data => {
                sections    => $self->{form_spec}{sections},
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

    croak '[Text::FormBuilder::write_module] Expecting a package name' unless $package;
    
    # automatically call build if needed to
    # allow the new->parse->write shortcut
    $self->build unless $self->{built};
    
    # conditionally use Data::Dumper
    eval 'use Data::Dumper;';
    die "Can't write module; need Data::Dumper. $@" if $@;
    
    $Data::Dumper::Terse = 1;           # don't dump $VARn names
    $Data::Dumper::Quotekeys = 0;       # don't quote simple string keys
    
    my $css;
    $css = $self->{build_options}{css} || $DEFAULT_CSS;
    $css .= $self->{build_options}{extra_css} if $self->{build_options}{extra_css};
    
    my %options = (
        %DEFAULT_OPTIONS,
        title => $self->{form_spec}{title},
        text  => $self->{form_spec}{description},
        fields   => [ map { $$_{name} } @{ $self->{form_spec}{fields} } ],
        required => [ map { $$_{name} } grep { $$_{required} } @{ $self->{form_spec}{fields} } ],
        template => {
            type => 'Text',
            engine => {
                TYPE       => 'STRING',
                SOURCE     => $self->{build_options}{form_only} ? 
                                $self->_form_template : 
                                $self->_template($css, $self->{build_options}{charset}),
                DELIMITERS => [ qw(<% %>) ],
            },
            data => {
                sections    => $self->{form_spec}{sections},
                author      => $self->{form_spec}{author},
                description => $self->{form_spec}{description},
            },
        }, 
        %{ $self->{build_options} },
    );
    
    # remove our custom options
    delete $options{$_} foreach qw(form_only css extra_css);
    
    my $form_options = keys %options > 0 ? Data::Dumper->Dump([\%options],['*options']) : '';
    
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
        params => \$cgi,
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
        Perl::Tidy::perltidy(source => \$module, destination => $outfile, argv => '-nolq -ci=4');
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
    my $self = shift;
    my $msg_required = $self->{build_options}{messages}{text_required};
    my $msg_invalid = $self->{build_options}{messages}{text_invalid};
    return q{<% $description ? qq[<p id="description">$description</p>] : '' %>
<% (grep { $_->{required} } @fields) ? qq[<p id="instructions">} . $msg_required . q{</p>] : '' %>
<% $start %>
<%
    # drop in the hidden fields here
    $OUT = join("\n", map { $$_{field} } grep { $$_{type} eq 'hidden' } @fields);
%>} .
q[
<%
    SECTION: while (my $section = shift @sections) {
        $OUT .= qq[<table id="] . ($$section{id} || '_default') . qq[">\n];
        $OUT .= qq[  <caption><h2 class="sectionhead">$$section{head}</h2></caption>] if $$section{head};
        TABLE_LINE: for my $line (@{ $$section{lines} }) {
            if ($$line[0] eq 'head') {
                $OUT .= qq[  <tr><th class="subhead" colspan="2"><h3>$$line[1]</h3></th></tr>\n]
            } elsif ($$line[0] eq 'field') {
                #TODO: we only need the field names, not the full field spec in the lines strucutre
                local $_ = $field{$$line[1]{name}};
                
                # skip hidden fields in the table
                next TABLE_LINE if $$_{type} eq 'hidden';
                
                $OUT .= $$_{invalid} ? qq[  <tr class="invalid">] : qq[  <tr>];
                
                # special case single value checkboxes
                if ($$_{type} eq 'checkbox' && @{ $$_{options} } == 1) {
                    $OUT .= qq[<th></th>];
                } else {
                    $OUT .= '<th class="label">' . ($$_{required} ? qq[<strong class="required">$$_{label}:</strong>] : "$$_{label}:") . '</th>';
                }
                
                # mark invalid fields
                if ($$_{invalid}) {
                    $OUT .= "<td>$$_{field} $$_{comment} ] . $msg_invalid . q[</td>";
                } else {
                    $OUT .= qq[<td>$$_{field} $$_{comment}</td>];
                }
                
                $OUT .= qq[</tr>\n];
                
            } elsif ($$line[0] eq 'group') {
                my @field_names = map { $$_{name} } @{ $$line[1]{group} };
                my @group_fields = map { $field{$_} } @field_names;
                $OUT .= (grep { $$_{invalid} } @group_fields) ? qq[  <tr class="invalid">\n] : qq[  <tr>\n];
                
                $OUT .= '    <th class="label">';
                $OUT .= (grep { $$_{required} } @group_fields) ? qq[<strong class="required">$$line[1]{label}:</strong>] : "$$line[1]{label}:";
                $OUT .= qq[</th>\n];
                
                $OUT .= qq[    <td>];
                $OUT .= join(' ', map { qq[<small class="sublabel">$$_{label}</small> $$_{field} $$_{comment}] } @group_fields);
                $OUT .= qq[    </td>\n];
                $OUT .= qq[  </tr>\n];
            }   
        }
        # close the table if there are sections remaining
        # but leave the last one open for the submit button
        $OUT .= qq[</table>\n] if @sections;
    }
%>
  <tr><th></th><td style="padding-top: 1em;"><% $submit %></td></tr>
</table>
<% $end %>
];
}

# usage: $self->_pre_template($css, $charset)
sub _pre_template {
    my $self = shift;
    my $css = shift || $DEFAULT_CSS;
    my $charset = shift || $DEFAULT_CHARSET;
    my $msg_author = 'sprintf("' . quotemeta($self->{build_options}{messages}{text_author}) . '", $author)';
    return 
q[<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=] . $charset . q[" />
  <title><% $title %><% $author ? ' - ' . ucfirst $author : '' %></title>
  <style type="text/css">
] .
$css .
q[  </style>
  <% $jshead %>
</head>
<body>

<h1><% $title %></h1>
<% $author ? qq[<p id="author">] . ] . $msg_author . q{ . q[</p>] : '' %>
};
}

sub _post_template {
    my $self = shift;
    my $msg_madewith = 'sprintf("' . quotemeta($self->{build_options}{messages}{text_madewith}) .
        '", q[<a href="http://formbuilder.org/">CGI::FormBuilder</a>], CGI::FormBuilder->VERSION)';
    
    return qq[<hr />
<div id="footer">
  <p id="creator"><% $msg_madewith %></p>
</div>
</body>
</html>
];
}

sub _template {
    my $self = shift;
    return $self->_pre_template(@_) . $self->_form_template . $self->_post_template;
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

Text::FormBuilder - Create CGI::FormBuilder objects from simple text descriptions

=head1 SYNOPSIS

    use Text::FormBuilder;
    
    my $parser = Text::FormBuilder->new;
    $parser->parse($src_file);
    
    # returns a new CGI::FormBuilder object with
    # the fields from the input form spec
    my $form = $parser->form;
    
    # write a My::Form module to Form.pm
    $parser->write_module('My::Form');

=head1 REQUIRES

L<Parse::RecDescent>, L<CGI::FormBuilder>, L<Text::Template>

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

=item C<css>, C<extra_css>

These options allow you to tell Text::FormBuilder to use different
CSS styles for the built in template. A value given a C<css> will
replace the existing CSS, and a value given as C<extra_css> will be
appended to the CSS. If both options are given, then the CSS that is
used will be C<css> concatenated with C<extra_css>.

=item C<messages>

This works the same way as the C<messages> parameter to 
C<< CGI::FormBuilder->new >>; you can provide either a hashref of messages
or a filename.

The default messages used by Text::FormBuilder are:

    text_author       Created by %s
    text_madewith     Made with %s version %s
    text_required     (Required fields are marked in <strong>bold</strong>.)
    text_invalid      Missing or invalid value.

Any messages you set here get passed on to CGI::FormBuilder, which means
that you should be able to put all of your customization messages in one
big file.

=item C<charset>

Sets the character encoding for the generated page. The default is ISO-8859-1.

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

Calls C<render> on the FormBuilder form, and either writes the resulting
HTML to a file, or to STDOUT if no filename is given.

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

=head1 DEFAULTS

These are the default settings that are passed to C<< CGI::FormBuilder->new >>:

    method => 'GET'
    javascript => 0
    keepextras => 1

Any of these can be overriden by the C<build> method:

    # use POST instead
    $parser->build(method => 'POST')->write;

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
    
    !section id heading
    
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

=item C<!section>

Starts a new section. Each section has its own heading and id, which are
written by default into spearate tables.

=item C<!head>

Inserts a heading between two fields. There can only be one heading between
any two fields; the parser will warn you if you try to put two headings right
next to each other.

=back

=head2 Fields

First, a note about multiword strings in the fields. Anywhere where it says
that you may use a multiword string, this means that you can do one of two
things. For strings that consist solely of alphanumeric characters (i.e.
C<\w+>) and spaces, the string will be recognized as is:

    field_1|A longer label

If you want to include non-alphanumerics (e.g. punctuation), you must 
single-quote the string:

    field_2|'Dept./Org.'

To include a literal single-quote in a single-quoted string, escape it with
a backslash:

    field_3|'\'Official\' title'

Now, back to the beginning. Form fields are each described on a single line.
The simplest field is just a name (which cannot contain any whitespace):

    color

This yields a form with one text input field of the default size named `color'.
The generated label for this field would be ``Color''. To add a longer or more\
descriptive label, use:

    color|Favorite color

The descriptive label can be a multiword string, as described above. So if you
want punctuation in the label, you should single quote it:

    color|'Fav. color'

To use a different input type:

    color|Favorite color:select{red,blue,green}

Recognized input types are the same as those used by CGI::FormBuilder:

    text        # the default
    textarea
    password
    file
    checkbox
    radio
    select
    hidden
    static

To change the size of the input field, add a bracketed subscript after the
field name (but before the descriptive label):

    # for a single line field, sets size="40"
    title[40]:text
    
    # for a multiline field, sets rows="4" and cols="30"
    description[4,30]:textarea

For the input types that can have options (C<select>, C<radio>, and
C<checkbox>), here's how you do it:

    color|Favorite color:select{red,blue,green}

Values are in a comma-separated list of single words or multiword strings
inside curly braces. Whitespace between values is irrelevant.

To add more descriptive display text to a value in a list, add a square-bracketed
``subscript,'' as in:

    ...:select{red[Scarlet],blue[Azure],green[Olive Drab]}

If you have a list of options that is too long to fit comfortably on one line,
you should use the C<!list> directive:

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
list, as the example does, or the fancier C<< ( { value1 => 'Description 1'},
{ value2 => 'Description 2}, ... ) >> form.

I<B<NOTE:> This feature of the language may go away unless I find a compelling
reason for it in the next few versions. What I really wanted was lists that
were filled in at run-time (e.g. from a database), and that can be done easily
enough with the CGI::FormBuilder object directly.>

If you want to have a single checkbox (e.g. for a field that says ``I want to
recieve more information''), you can just specify the type as checkbox without
supplying any options:

    moreinfo|I want to recieve more information:checkbox

In this case, the label ``I want to recieve more information'' will be
printed to the right of the checkbox.

You can also supply a default value to the field. To get a default value of
C<green> for the color field:

    color|Favorite color:select=green{red,blue,green}

Default values can also be either single words or multiword strings.

To validate a field, include a validation type at the end of the field line:

    email|Email address//EMAIL

Valid validation types include any of the builtin defaults from L<CGI::FormBuilder>,
or the name of a pattern that you define with the C<!pattern> directive elsewhere
in your form spec:

    !pattern DAY /^([1-3][0-9])|[1-9]$/
    
    last_day//DAY

If you just want a required value, use the builtin validation type C<VALUE>:

    title//VALUE

By default, adding a validation type to a field makes that field required. To
change this, add a C<?> to the end of the validation type:

    contact//EMAIL?

In this case, you would get a C<contact> field that was optional, but if it
were filled in, would have to validate as an C<EMAIL>.

=head2 Comments

    # comment ...

Any line beginning with a C<#> is considered a comment.

=head1 TODO

Allow for custom wrappers around the C<form_template>

Maybe use HTML::Template instead of Text::Template for the built in template
(since CGI::FormBuilder users may be more likely to already have HTML::Template)

Better examples in the docs (maybe a standalone or two as well)

C<!include> directive to include external formspec files

Better tests!

=head1 BUGS

I'm sure they're in there, I just haven't tripped over any new ones lately. :-)

=head1 SEE ALSO

L<CGI::FormBuilder>

=head1 THANKS

Thanks to eszpee for pointing out some bugs in the default value parsing,
as well as some suggestions for i18n/l10n and splitting up long forms into
sections.

=head1 AUTHOR

Peter Eichman C<< <peichman@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright E<copy>2004 by Peter Eichman.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

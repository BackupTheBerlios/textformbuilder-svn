package Text::FormBuilder;

use strict;
use warnings;

use base qw(Exporter);
use vars qw($VERSION @EXPORT);

$VERSION = '0.07';
@EXPORT = qw(create_form);

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
.note { background: #eee; }
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

# options to clean up the code with Perl::Tidy
my $TIDY_OPTIONS = '-nolq -ci=4 -ce';

my $HTML_EXTS   = qr/\.html?$/;
my $MODULE_EXTS = qr/\.pm$/;
my $SCRIPT_EXTS = qr/\.(pl|cgi)$/;

# superautomagical exported function
sub create_form {
    my ($source, $options, $destination) = @_;
    my $parser = __PACKAGE__->parse($source);
    $parser->build(%{ $options || {} });
    if ($destination) {
        if (ref $destination) {
            croak "[Text::FormBuilder::create_form] Don't know what to do with a ref for $destination";
            #TODO: what do ref dests mean?
        } else {
            # write webpage, script, or module
            if ($destination =~ $MODULE_EXTS) {
                $parser->write_module($destination);
            } elsif ($destination =~ $SCRIPT_EXTS) {
                $parser->write_script($destination);
            } else {
                $parser->write($destination);
            }
        }
    } else {
        defined wantarray ? return $parser->form : $parser->write;
    }
}
    

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
    if (my $type = ref $source) {
        if ($type eq 'SCALAR') {
            $self->parse_text($$source);
        } elsif ($type eq 'ARRAY') {
            $self->parse_array(@$source);
        } else {
            croak "[Text::FormBuilder::parse] Unknown ref type $type passed as source";
        }
    } else {
        $self->parse_file($source);
    }
}

sub parse_array {
    my ($self, @lines) = @_;
    # so it can be called as a class method
    $self = $self->new unless ref $self;    
    $self->parse_text(join("\n", @lines));    
    return $self;
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
    #   neat trick: css => '@import(my_external_stylesheet.css);'
    #   will let you use an external stylesheet
    #   CSS Hint: to get multiple sections to all line up their fields,
    #   set a standard width for th.label
    my $css;
    $css = $options{css} || $DEFAULT_CSS;
    $css .= $options{extra_css} if $options{extra_css};
    
    # messages
    # code pulled (with modifications) from CGI::FormBuilder
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
    if (my %groups = %{ $self->{form_spec}{groups} || {} }) {
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
    }
    
    # the actual fields that are given to CGI::FormBuilder
    # make copies so that when we trim down the sections
    # we don't lose the form field information
    $self->{form_spec}{fields} = [];
    
    for my $section (@{ $self->{form_spec}{sections} || [] }) {
        for my $line (@{ $$section{lines} }) {
            if ($$line[0] eq 'group') {
                push @{ $self->{form_spec}{fields} }, { %{$_} } foreach @{ $$line[1]{group} };
            } elsif ($$line[0] eq 'field') {
                push @{ $self->{form_spec}{fields} }, { %{$$line[1]} };
            }
        }
    }
    
    # substitute in custom validation subs and pattern definitions for field validation
    my %patterns = %{ $self->{form_spec}{patterns} || {} };
    my %subs = %{ $self->{form_spec}{subs} || {} };
    
    foreach (@{ $self->{form_spec}{fields} }) {
        if ($$_{validate}) {
            if (exists $patterns{$$_{validate}}) {
                $$_{validate} = $patterns{$$_{validate}};
            # TODO: need the Data::Dumper code to work for this
            # for now, we just warn that it doesn't work
            } elsif (exists $subs{$$_{validate}}) {
                warn "[Text::FormBuilder] validate coderefs don't work yet";
                delete $$_{validate};
##                 $$_{validate} = $subs{$$_{validate}};
            }
        }
    }
    
    # get user-defined lists; can't make this conditional because
    # we need to be able to fall back to CGI::FormBuilder's lists
    # even if the user didn't define any
    my %lists = %{ $self->{form_spec}{lists} || {} };
    
    # substitute in list names
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
    
    # use the list for displaying checkbox groups
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

    foreach (@{ $self->{form_spec}{sections} }) {
        #for my $line (grep { $$_[0] eq 'field' } @{ $$_{lines} }) {
        for my $line (@{ $$_{lines} }) {
            if ($$line[0] eq 'field') {
                $$line[1] = $$line[1]{name};
##                 $_ eq 'name' or delete $$line[1]{$_} foreach keys %{ $$line[1] };
##             } elsif ($$line[0] eq 'group') {
##                 $$line[1] = [ map { $$_{name} } @{ $$line[1]{group} } ];
            }
        }
    }
    
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

# generates the core code to create the $form object
# the generated code assumes that you have a CGI.pm
# object named $q
sub _form_code {
    my $self = shift;
    
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
    
    my %module_subs;
    my $d = Data::Dumper->new([ \%options ], [ '*options' ]);
    
    use B::Deparse;
    my $deparse = B::Deparse->new;
##     
##     #TODO: need a workaround/better solution since Data::Dumper doesn't like dumping coderefs
##     foreach (@{ $self->{form_spec}{fields} }) {
##         if (ref $$_{validate} eq 'CODE') {
##             my $body = $deparse->coderef2text($$_{validate});
##             #$d->Seen({ "*_validate_$$_{name}" => $$_{validate} });
##             #$module_subs{$$_{name}} = "sub _validate_$$_{name} $$_{validate}";
##         }
##     }    
##     my $sub_code = join("\n", each %module_subs);
    
    my $form_options = keys %options > 0 ? $d->Dump : '';
    
    my $field_setup = join(
        "\n", 
        map { '$form->field' . Data::Dumper->Dump([$_],['*field']) . ';' } @{ $self->{form_spec}{fields} }
    );
    
    return <<END;
my \$form = CGI::FormBuilder->new(
    params => \$q,
    $form_options
);

$field_setup
END
}

sub write_module {
    my ($self, $package, $use_tidy) = @_;

    croak '[Text::FormBuilder::write_module] Expecting a package name' unless $package;
    
    my $form_code = $self->_form_code;
    
    my $module = <<END;
package $package;
use strict;
use warnings;

use CGI::FormBuilder;

sub get_form {
    my \$q = shift;

    $form_code
    
    return \$form;
}

# module return
1;
END

    _write_output_file($module, (split(/::/, $package))[-1] . '.pm', $use_tidy);
    return $self;
}

sub write_script {
    my ($self, $script_name, $use_tidy) = @_;

    croak '[Text::FormBuilder::write_script] Expecting a script name' unless $script_name;
    
    my $form_code = $self->_form_code;
    
    my $script = <<END;
#!/usr/bin/perl
use strict;
use warnings;

use CGI;
use CGI::FormBuilder;

my \$q = CGI->new;

$form_code
    
unless (\$form->submitted && \$form->validate) {
    print \$form->render;
} else {
    # do something with the entered data
}
END
    
    _write_output_file($script, $script_name, $use_tidy);   
    return $self;
}

sub _write_output_file {
    my ($source_code, $outfile, $use_tidy) = @_;
    if ($use_tidy) {
        # clean up the generated code, if asked
        eval 'use Perl::Tidy';
        die "Can't tidy the code: $@" if $@;
        Perl::Tidy::perltidy(source => \$source_code, destination => $outfile, argv => $TIDY_OPTIONS);
    } else {
        # otherwise, just print as is
        open OUT, "> $outfile" or die $!;
        print OUT $source_code;
        close OUT;
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
            } elsif ($$line[0] eq 'note') {
                $OUT .= qq[  <tr><td class="note" colspan="2">$$line[1]</td></tr>\n]
            } elsif ($$line[0] eq 'field') {
                local $_ = $field{$$line[1]};
                
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
                my @group_fields = map { $field{$_} } map { $$_{name} } @{ $$line[1]{group} };
                $OUT .= (grep { $$_{invalid} } @group_fields) ? qq[  <tr class="invalid">\n] : qq[  <tr>\n];
                
                $OUT .= '    <th class="label">';
                $OUT .= (grep { $$_{required} } @group_fields) ? qq[<strong class="required">$$line[1]{label}:</strong>] : "$$line[1]{label}:";
                $OUT .= qq[</th>\n];
                
                $OUT .= qq[    <td>];
                $OUT .= join(' ', map { qq[<small class="sublabel">$$_{label}</small> $$_{field} $$_{comment}] } @group_fields);
                $OUT .= " $msg_invalid" if $$_{invalid};

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
] . $css . q[  </style>
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

# usage: $self->_template($css, $charset)
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

This module is intended to extend the idea of making it easy to create
web forms by allowing you to describe them with a simple langauge. These
I<formspecs> are then passed through this module's parser and converted
into L<CGI::FormBuilder> objects that you can easily use in your CGI
scripts. In addition, this module can generate code for standalone modules
which allow you to separate your form design from your script code.

A simple formspec looks like this:

    name//VALUE
    email//EMAIL
    langauge:select{English,Spanish,French,German}
    moreinfo|Send me more information:checkbox
    interests:checkbox{Perl,karate,bass guitar}

This will produce a required C<name> test field, a required C<email> text
field that must look like an email address, an optional select dropdown
field C<langauge> with the choices English, Spanish, French, and German,
an optional C<moreinfo> checkbox labeled ``Send me more information'', and
finally a set of checkboxes named C<interests> with the choices Perl,
karate, and bass guitar.

=head1 METHODS

=head2 new

    my $parser = Text::FormBuilder->new;

=head2 parse

    # parse a file (regular scalar)
    $parser->parse($filename);
    
    # or pass a scalar ref for parse a literal string
    $parser->parse(\$string);
    
    # or an array ref to parse lines
    $parser->parse(\@lines);

Parse the file or string. Returns the parser object. This method,
along with all of its C<parse_*> siblings, may be called as a class
method to construct a new object.

=head2 parse_file

    $parser->parse_file($src_file);
    
    # or as a class method
    my $parser = Text::FormBuilder->parse($src_file);

=head2 parse_text

    $parser->parse_text($src);

Parse the given C<$src> text. Returns the parser object.

=head2 parse_array

    $parser->parse_array(@lines);

Concatenates and parses C<@lines>. Returns the parser object.

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

If you want to use an external stylesheet, a quick way to get this is
to set the C<css> parameter to import your file:

    css => '@import(my_external_stylesheet.css);'

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

=head2 write_script

    $parser->write_script($filename, $use_tidy);

If you don't need the reuseability of a separate module, you can have
Text::FormBuilder write the form object to a script for you, along with
the simplest framework for using it, to which you can add your actual
form processing code.

The generated script looks like this:

    #!/usr/bin/perl
    use strict;
    use warnings;
    
    use CGI;
    use CGI::FormBuilder;
    
    my $q = CGI->new;
    
    my $form = CGI::FormBuilder->new(
        params => $q,
        # ... lots of other stuff to set up the form ...
    );
    
    $form->field( name => 'month' );
    $form->field( name => 'day' );
    
    unless ( $form->submitted && $form->validate ) {
        print $form->render;
    } else {
        # do something with the entered data ...
        # this is where your form processing code should go
    }

Like C<write_module>, you can optionally pass a true value as the second
argument to have Perl::Tidy make the generated code look nicer.

=head2 dump

Uses L<YAML> to print out a human-readable representation of the parsed
form spec.

=head1 EXPORTS

There is one exported function, C<create_form>, that is intended to ``do the
right thing'' in simple cases.

=head2 create_form

    # get a CGI::FormBuilder object
    my $form = create_form($source, $options, $destination);
    
    # or just write the form immediately
    create_form($source, $options, $destination);

C<$source> accepts any of the types of arguments that C<parse> does. C<$options>
is a hashref of options that should be passed to C<build>. Finally, C<$destination>
is a simple scalar that determines where and what type of output C<create_form>
should generate.

    /\.pm$/             ->write_module($destination)
    /\.(cgi|pl)$/       ->write_script($destination)
    everything else     ->write($destination)

For anything more than simple, one-off cases, you are usually better off using the
object-oriented interface, since that gives you more control over things.

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
    
    !pattern NAME /regular expression/
    
    !list NAME {
        option1[display string],
        option2[display string],
        ...
    }
    
    !list NAME &{ CODE }
    
    !group NAME {
        field1
        field2
        ...
    }
    
    !section id heading
    
    !head ...
    
    !note {
        ...
    }

=head2 Directives

=over

=item C<!pattern>

Defines a validation pattern.

=item C<!list>

Defines a list for use in a C<radio>, C<checkbox>, or C<select> field.

=item C<!group>

Define a named group of fields that are displayed all on one line. Use with
the C<!field> directive.

=item C<!field>

Include a named instance of a group defined with C<!group>.

=item C<!title>

Title of the form.

=item C<!author>

Author of the form.

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

=item C<!note>

A text note that can be inserted as a row in the form. This is useful for
special instructions at specific points in a long form.

=back

B<Known BUG:> If you include an odd number of C<'> or C<"> characters in a
C<!description> or C<!note>, then that directive will mistakenly be skipped.
This is a bug casued by me taking a shortcut in the parser C<:-/>

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

=head2 Field Groups

You can define groups of fields using the C<!group> directive:

    !group DATE {
        month:select@MONTHS//INT
        day[2]//INT
        year[4]//INT
    }

You can then include instances of this group using the C<!field> directive:

    !field %DATE birthday

This will create a line in the form labeled ``Birthday'' which contains
a month dropdown, and day and year text entry fields. The actual input field
names are formed by concatenating the C<!field> name (e.g. C<birthday>) with
the name of the subfield defined in the group (e.g. C<month>, C<day>, C<year>).
Thus in this example, you would end up with the form fields C<birthday_month>,
C<birthday_day>, and C<birthday_year>.

=head2 Comments

    # comment ...

Any line beginning with a C<#> is considered a comment.

=head1 TODO

Allow renaming of the submit button; allow renaming and inclusion of a 
reset button

Allow for custom wrappers around the C<form_template>

Maybe use HTML::Template instead of Text::Template for the built in template
(since CGI::FormBuilder users may be more likely to already have HTML::Template)

C<!include> directive to include external formspec files

Better tests!

=head1 BUGS

Having a single C<'> or C<"> in a C<!description> or C<!note> directive causes that
directive to get skipped. This is an issue with the C<perl_codeblock> shortcut in
Parse::RecDescent.

Creating two $parsers in the same script causes the second one to get the data
from the first one.

I'm sure there are more in there, I just haven't tripped over any new ones lately. :-)

Suggestions on how to improve the (currently tiny) test suite would be appreciated.

=head1 SEE ALSO

L<http://textformbuilder.berlios.de>

L<CGI::FormBuilder>, L<http://formbuilder.org>

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

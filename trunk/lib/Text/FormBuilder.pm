package Text::FormBuilder;

use strict;
use warnings;

our $VERSION = '0.01';

use Text::FormBuilder::Parser;
use CGI::FormBuilder;
use YAML;

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
    
    # substitute in custom pattern definitions for field validation
    if (my %patterns = %{ $self->{form_spec}{patterns} }) {
        foreach (@{ $self->{form_spec}{fields} }) {
            if ($$_{validate} and exists $patterns{$$_{validate}}) {
                $$_{validate} = $patterns{$$_{validate}};
            }
        }
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
                SOURCE     => $self->_template,
                DELIMETERS => [ qw(<% %>) ],
            },
            data => {
                author => $self->{form_spec}{author},
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

sub form { shift->{form} }

sub _template {
q[
<html>
<head>
  <title><% $title %><% $author ? ' - ' . ucfirst $author : '' %></title>
  <style type="text/css">
    #author, #footer { font-style: italic; }
    th { font-weight: normal; text-align: right; vertical-align: top; }
  </style>
</head>
<body>

<h1><% $title %></h1>
<% $author ? qq[<p id="author">Created by $author</p>] : '' %>
<p id="instructions">(Required fields are marked in <strong>bold</strong>.)</p>
<% $start %>
<table>
<% foreach (@fields) {
    $OUT .= qq[  <tr>];
    $OUT .= '<th>' . ($$_{required} ? qq[<strong class="required">$$_{label}:</strong>] : "$$_{label}:") . '</th>';
    $OUT .= qq[<td>$$_{field} $$_{comment}</td></tr>\n]
} %>
  <tr><th></th><td style="padding-top: 1em;"><% $submit %></td></tr>
</table>
<% $end %>
<hr />
<div id="footer">
  <p id="creator">Made with <a href="http://formbuilder.org/">CGI::FormBuilder</a> version <% $CGI::FormBuilder::VERSION %>.</p>
</div>
</body>
</html>
];
}

sub _dump { print YAML::Dump(shift->{form_spec}); }


# module return
1;

=head1 NAME

Text::FormBuilder - Parser for a minilanguage describing web forms

=head1 SYNOPSIS

    my $parser = Text::FormBuilder->new;
    $parser->parse($src_file);
    
    # returns a new CGI::FormBuilder object with the fields
    # from the input form spec
    my $form = $parser->build_form;

=head1 DESCRIPTION

=head2 new

=head2 parse

=head2 build

=head2 write

=head1 LANGUAGE

    name[size]|descriptive label[hint]:type=default{option1(display string),option2(display string),...}//validate
    
    !title ...
    
    !pattern name /regular expression/
    !list name {
        option1(display string),
        option2(display string),
        ...
    }

=head2 Directives

=over

=item C<!pattern>

=item C<!list>

=item C<!title>

=back

=head2 Fields

Form fields are each described on a single line.

If you have a list of options that is too long to fit comfortably on one line,
consider using the C<!list> directive.

=head2 Comments

    # comment ...

Any line beginning with a C<#> is considered a comment.

=head1 SEE ALSO

L<CGI::FormBuilder>

=cut

package Text::FormBuilder::Parser;
use Parse::RecDescent;

{ my $ERRORS;


package Parse::RecDescent::Text::FormBuilder::Parser;
use strict;
use vars qw($skip $AUTOLOAD  );
$skip = '\s*';
 my ($title, $author, %lists, %patterns, @fields, $type, @options, $list_var, $size, $rows, $cols); ;


{
local $SIG{__WARN__} = sub {0};
# PRETEND TO BE IN Parse::RecDescent NAMESPACE
*Parse::RecDescent::Text::FormBuilder::Parser::AUTOLOAD	= sub
{
	no strict 'refs';
	$AUTOLOAD =~ s/^Parse::RecDescent::Text::FormBuilder::Parser/Parse::RecDescent/;
	goto &{$AUTOLOAD};
}
}

push @Parse::RecDescent::Text::FormBuilder::Parser::ISA, 'Parse::RecDescent';
# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::row_col
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"row_col"};
	
	Parse::RecDescent::_trace(q{Trying rule: [row_col]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{row_col},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/\\d+/ /,\\s*/ /\\d+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{row_col});
		%item = (__RULE__ => q{row_col});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/\\d+/]}, Parse::RecDescent::_tracefirst($text),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:\d+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/,\\s*/]}, Parse::RecDescent::_tracefirst($text),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/,\\s*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:,\s*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN2__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/\\d+/]}, Parse::RecDescent::_tracefirst($text),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/\\d+/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:\d+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN3__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $rows = $item[1]; $cols = $item[3] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/\\d+/ /,\\s*/ /\\d+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{row_col},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{row_col},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{row_col},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{row_col},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::options
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"options"};
	
	Parse::RecDescent::_trace(q{Trying rule: [options]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{options},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['\{' <leftop: option /,\\s*/ option> '\}']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{options});
		%item = (__RULE__ => q{options});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['\{']},
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\{//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying operator: [<leftop: option /,\\s*/ option>]},
				  Parse::RecDescent::_tracefirst($text),
				  q{options},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{<leftop: option /,\\s*/ option>})->at($text);

		$_tok = undef;
		OPLOOP: while (1)
		{
		  $repcount = 0;
		  my  @item;
		  
		  # MATCH LEFTARG
		  
		Parse::RecDescent::_trace(q{Trying subrule: [option]},
				  Parse::RecDescent::_tracefirst($text),
				  q{options},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{option})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::option($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [option]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{options},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [option]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{option}} = $_tok;
		push @item, $_tok;
		
		}


		  $repcount++;

		  my $savetext = $text;
		  my $backtrack;

		  # MATCH (OP RIGHTARG)(s)
		  while ($repcount < 100000000)
		  {
			$backtrack = 0;
			
		Parse::RecDescent::_trace(q{Trying terminal: [/,\\s*/]}, Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/,\\s*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:,\s*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

			pop @item;
			if (defined $1) {push @item, $item{'option(s)'}=$1; $backtrack=1;}
			
		Parse::RecDescent::_trace(q{Trying subrule: [option]},
				  Parse::RecDescent::_tracefirst($text),
				  q{options},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{option})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::option($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [option]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{options},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [option]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{option}} = $_tok;
		push @item, $_tok;
		
		}

			$savetext = $text;
			$repcount++;
		  }
		  $text = $savetext;
		  pop @item if $backtrack;

		  unless (@item) { undef $_tok; last }
		  $_tok = [ @item ];
		  last;
		} 

		unless ($repcount>=1)
		{
			Parse::RecDescent::_trace(q{<<Didn't match operator: [<leftop: option /,\\s*/ option>]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{options},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched operator: [<leftop: option /,\\s*/ option>]<< (return value: [}
					  . qq{@{$_tok||[]}} . q{]},
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;

		push @item, $item{'option(s)'}=$_tok||[];


		Parse::RecDescent::_trace(q{Trying terminal: ['\}']},
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{'\}'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\}//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING2__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['\{' <leftop: option /,\\s*/ option> '\}']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{options},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{options},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{options},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{options},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::list_def
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"list_def"};
	
	Parse::RecDescent::_trace(q{Trying rule: [list_def]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{list_def},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['!list' list_name static_list, or dynamic_list]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{list_def});
		%item = (__RULE__ => q{list_def});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['!list']},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\!list//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying subrule: [list_name]},
				  Parse::RecDescent::_tracefirst($text),
				  q{list_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{list_name})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::list_name($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [list_name]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{list_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [list_name]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{list_name}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying subrule: [_alternation_1_of_production_1_of_rule_list_def]},
				  Parse::RecDescent::_tracefirst($text),
				  q{list_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{static_list, or dynamic_list})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_list_def($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [_alternation_1_of_production_1_of_rule_list_def]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{list_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [_alternation_1_of_production_1_of_rule_list_def]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{_alternation_1_of_production_1_of_rule_list_def}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $lists{$item{list_name}} = [ @options ]; @options = () };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['!list' list_name static_list, or dynamic_list]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{list_def},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{list_def},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{list_def},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::field_size
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"field_size"};
	
	Parse::RecDescent::_trace(q{Trying rule: [field_size]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{field_size},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['[' row_col, or size ']']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{field_size});
		%item = (__RULE__ => q{field_size});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['[']},
					  Parse::RecDescent::_tracefirst($text),
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\[//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying subrule: [_alternation_1_of_production_1_of_rule_field_size]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field_size},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{row_col, or size})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_field_size($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [_alternation_1_of_production_1_of_rule_field_size]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field_size},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [_alternation_1_of_production_1_of_rule_field_size]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{_alternation_1_of_production_1_of_rule_field_size}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying terminal: [']']},
					  Parse::RecDescent::_tracefirst($text),
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{']'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\]//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING2__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['[' row_col, or size ']']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{field_size},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{field_size},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{field_size},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::author
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"author"};
	
	Parse::RecDescent::_trace(q{Trying rule: [author]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{author},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['!author' /.*/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{author});
		%item = (__RULE__ => q{author});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['!author']},
					  Parse::RecDescent::_tracefirst($text),
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\!author//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/.*/]}, Parse::RecDescent::_tracefirst($text),
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/.*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:.*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $author = $item[2] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['!author' /.*/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{author},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{author},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{author},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{author},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::list_name
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"list_name"};
	
	Parse::RecDescent::_trace(q{Trying rule: [list_name]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{list_name},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/[A-Z_]+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{list_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{list_name});
		%item = (__RULE__ => q{list_name});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/[A-Z_]+/]}, Parse::RecDescent::_tracefirst($text),
					  q{list_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[A-Z_]+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/[A-Z_]+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{list_name},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{list_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{list_name},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{list_name},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::size
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"size"};
	
	Parse::RecDescent::_trace(q{Trying rule: [size]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{size},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/\\d+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{size},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{size});
		%item = (__RULE__ => q{size});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/\\d+/]}, Parse::RecDescent::_tracefirst($text),
					  q{size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:\d+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{size},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $size = $item[1] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/\\d+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{size},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{size},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{size},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::identifier
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"identifier"};
	
	Parse::RecDescent::_trace(q{Trying rule: [identifier]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{identifier},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/\\w+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{identifier},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{identifier});
		%item = (__RULE__ => q{identifier});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/\\w+/]}, Parse::RecDescent::_tracefirst($text),
					  q{identifier},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:\w+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/\\w+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{identifier},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{identifier},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{identifier},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{identifier},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{identifier},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::blank
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"blank"};
	
	Parse::RecDescent::_trace(q{Trying rule: [blank]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{blank},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: []},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{blank},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{blank});
		%item = (__RULE__ => q{blank});
		my $repcount = 0;



		Parse::RecDescent::_trace(q{>>Matched production: []<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{blank},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{blank},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{blank},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{blank},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{blank},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::option
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"option"};
	
	Parse::RecDescent::_trace(q{Trying rule: [option]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{option},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [value display_text]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{option});
		%item = (__RULE__ => q{option});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [value]},
				  Parse::RecDescent::_tracefirst($text),
				  q{option},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::value($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [value]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{option},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [value]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{value}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying repeated subrule: [display_text]},
				  Parse::RecDescent::_tracefirst($text),
				  q{option},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{display_text})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::display_text, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [display_text]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{option},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [display_text]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{display_text(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { push @options, { $item{value} => $item{'display_text(?)'}[0] } };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [value display_text]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{option},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{option},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{option},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{option},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::pattern_name
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"pattern_name"};
	
	Parse::RecDescent::_trace(q{Trying rule: [pattern_name]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{pattern_name},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/[A-Z_]+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{pattern_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{pattern_name});
		%item = (__RULE__ => q{pattern_name});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/[A-Z_]+/]}, Parse::RecDescent::_tracefirst($text),
					  q{pattern_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[A-Z_]+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/[A-Z_]+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{pattern_name},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{pattern_name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{pattern_name},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{pattern_name},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::validate
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"validate"};
	
	Parse::RecDescent::_trace(q{Trying rule: [validate]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{validate},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['//' value]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{validate},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{validate});
		%item = (__RULE__ => q{validate});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['//']},
					  Parse::RecDescent::_tracefirst($text),
					  q{validate},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\/\///)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying subrule: [value]},
				  Parse::RecDescent::_tracefirst($text),
				  q{validate},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{value})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::value($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [value]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{validate},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [value]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{validate},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{value}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: ['//' value]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{validate},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{validate},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{validate},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{validate},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{validate},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::list_var
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"list_var"};
	
	Parse::RecDescent::_trace(q{Trying rule: [list_var]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{list_var},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/@[A-Z_]+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{list_var},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{list_var});
		%item = (__RULE__ => q{list_var});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/@[A-Z_]+/]}, Parse::RecDescent::_tracefirst($text),
					  q{list_var},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:@[A-Z_]+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_var},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $list_var = $item[1] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/@[A-Z_]+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{list_var},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{list_var},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{list_var},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{list_var},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{list_var},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::field
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"field"};
	
	Parse::RecDescent::_trace(q{Trying rule: [field]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [name field_size label hint type default option_list validate]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{field});
		%item = (__RULE__ => q{field});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [name]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::name($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [name]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [name]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{name}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying repeated subrule: [field_size]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{field_size})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::field_size, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [field_size]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [field_size]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{field_size(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [label]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{label})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::label, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [label]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [label]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{label(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [hint]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{hint})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::hint, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [hint]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [hint]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{hint(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [type]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{type})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::type, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [type]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [type]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{type(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [default]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{default})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::default, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [default]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [default]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{default(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [option_list]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{option_list})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::option_list, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [option_list]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [option_list]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{option_list(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying repeated subrule: [validate]},
				  Parse::RecDescent::_tracefirst($text),
				  q{field},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{validate})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::validate, 0, 1, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [validate]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{field},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [validate]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{validate(?)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do {
	my $field = {
	    name     => $item{name},
	    label    => $item{'label(?)'}[0],
	    comment  => $item{'hint(?)'}[0],
	    type     => $item{'type(?)'}[0],
	    value    => $item{'default(?)'}[0],
            list     => $list_var,
            validate => $item{'validate(?)'}[0],
	};
	
	$$field{options} = [ @options ] if @options;
	
	$$field{rows} = $rows if defined $rows;
	$$field{cols} = $cols if defined $cols;
	$$field{size} = $size if defined $size;
	
	push @fields, $field;
	
	$type = undef;
	$list_var = undef;
	$size = undef;
	$rows = undef;
	$cols = undef;
	@options = ();
        
    };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [name field_size label hint type default option_list validate]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{field},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{field},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{field},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{field},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_form_spec
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"_alternation_1_of_production_1_of_rule_form_spec"};
	
	Parse::RecDescent::_trace(q{Trying rule: [_alternation_1_of_production_1_of_rule_form_spec]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{_alternation_1_of_production_1_of_rule_form_spec},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [list_def]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_form_spec});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_form_spec});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [list_def]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_form_spec},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::list_def($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [list_def]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_form_spec},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [list_def]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{list_def}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [list_def]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [line]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[1];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_form_spec});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_form_spec});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [line]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_form_spec},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::line($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [line]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_form_spec},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [line]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{line}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [line]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{_alternation_1_of_production_1_of_rule_form_spec},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{_alternation_1_of_production_1_of_rule_form_spec},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::line
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"line"};
	
	Parse::RecDescent::_trace(q{Trying rule: [line]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{line},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		local $skip = defined($skip) ? $skip : $Parse::RecDescent::skip;
		Parse::RecDescent::_trace(q{Trying production: [<skip:'[ \t]*'> title, or author, or pattern_def, or field, or comment, or blank '\\n']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{line});
		%item = (__RULE__ => q{line});
		my $repcount = 0;


		

		Parse::RecDescent::_trace(q{Trying directive: [<skip:'[ \t]*'>]},
					Parse::RecDescent::_tracefirst($text),
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE; 
		$_tok = do { my $oldskip = $skip; $skip='[ \t]*'; $oldskip };
		if (defined($_tok))
		{
			Parse::RecDescent::_trace(q{>>Matched directive<< (return value: [}
						. $_tok . q{])},
						Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		}
		else
		{
			Parse::RecDescent::_trace(q{<<Didn't match directive>>},
						Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		}
		
		last unless defined $_tok;
		push @item, $item{__DIRECTIVE1__}=$_tok;
		

		Parse::RecDescent::_trace(q{Trying subrule: [_alternation_1_of_production_1_of_rule_line]},
				  Parse::RecDescent::_tracefirst($text),
				  q{line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{title, or author, or pattern_def, or field, or comment, or blank})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_line($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [_alternation_1_of_production_1_of_rule_line]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [_alternation_1_of_production_1_of_rule_line]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{_alternation_1_of_production_1_of_rule_line}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying terminal: ['\\n']},
					  Parse::RecDescent::_tracefirst($text),
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{'\\n'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "\n"; 1 } and
		     substr($text,0,length($_tok)) eq $_tok and
		     do { substr($text,0,length($_tok)) = ""; 1; }
		)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $_tok . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [<skip:'[ \t]*'> title, or author, or pattern_def, or field, or comment, or blank '\\n']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{line},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{line},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{line},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::option_list
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"option_list"};
	
	Parse::RecDescent::_trace(q{Trying rule: [option_list]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{option_list},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [options]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{option_list});
		%item = (__RULE__ => q{option_list});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [options]},
				  Parse::RecDescent::_tracefirst($text),
				  q{option_list},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::options($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [options]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{option_list},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [options]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{options}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [options]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [list_var]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[1];
		$text = $_[1];
		my $_savetext;
		@item = (q{option_list});
		%item = (__RULE__ => q{option_list});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [list_var]},
				  Parse::RecDescent::_tracefirst($text),
				  q{option_list},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::list_var($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [list_var]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{option_list},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [list_var]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{list_var}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [list_var]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{option_list},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{option_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{option_list},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{option_list},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_line
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"_alternation_1_of_production_1_of_rule_line"};
	
	Parse::RecDescent::_trace(q{Trying rule: [_alternation_1_of_production_1_of_rule_line]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [title]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [title]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::title($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [title]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [title]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{title}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [title]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [author]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[1];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [author]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::author($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [author]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [author]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{author}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [author]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [pattern_def]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[2];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [pattern_def]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::pattern_def($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [pattern_def]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [pattern_def]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{pattern_def}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [pattern_def]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [field]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[3];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [field]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::field($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [field]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [field]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{field}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [field]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [comment]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[4];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [comment]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::comment($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [comment]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [comment]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{comment}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [comment]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [blank]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[5];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_line});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_line});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [blank]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_line},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::blank($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [blank]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_line},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [blank]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{blank}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [blank]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{_alternation_1_of_production_1_of_rule_line},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{_alternation_1_of_production_1_of_rule_line},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::value
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"value"};
	
	Parse::RecDescent::_trace(q{Trying rule: [value]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{value},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [identifier]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{value},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{value});
		%item = (__RULE__ => q{value});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [identifier]},
				  Parse::RecDescent::_tracefirst($text),
				  q{value},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::identifier($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [identifier]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{value},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [identifier]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{value},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{identifier}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [identifier]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{value},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{value},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{value},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{value},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{value},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_field_size
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"_alternation_1_of_production_1_of_rule_field_size"};
	
	Parse::RecDescent::_trace(q{Trying rule: [_alternation_1_of_production_1_of_rule_field_size]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{_alternation_1_of_production_1_of_rule_field_size},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [row_col]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_field_size});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_field_size});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [row_col]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_field_size},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::row_col($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [row_col]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_field_size},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [row_col]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{row_col}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [row_col]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [size]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[1];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_field_size});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_field_size});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [size]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_field_size},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::size($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [size]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_field_size},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [size]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{size}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [size]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{_alternation_1_of_production_1_of_rule_field_size},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{_alternation_1_of_production_1_of_rule_field_size},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::name
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"name"};
	
	Parse::RecDescent::_trace(q{Trying rule: [name]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{name},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [identifier]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{name},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{name});
		%item = (__RULE__ => q{name});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [identifier]},
				  Parse::RecDescent::_tracefirst($text),
				  q{name},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::identifier($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [identifier]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{name},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [identifier]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{identifier}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [identifier]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{name},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{name},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{name},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{name},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::display_text
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"display_text"};
	
	Parse::RecDescent::_trace(q{Trying rule: [display_text]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{display_text},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['[' /[^\\]]+/i ']']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{display_text});
		%item = (__RULE__ => q{display_text});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['[']},
					  Parse::RecDescent::_tracefirst($text),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\[//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/[^\\]]+/i]}, Parse::RecDescent::_tracefirst($text),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/[^\\]]+/i})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[^\]]+)//i)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [']']},
					  Parse::RecDescent::_tracefirst($text),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{']'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\]//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING2__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $item[2] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['[' /[^\\]]+/i ']']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{display_text},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{display_text},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{display_text},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{display_text},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::default
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"default"};
	
	Parse::RecDescent::_trace(q{Trying rule: [default]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{default},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['=' /[^\\@\\\{\\s]+/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{default},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{default});
		%item = (__RULE__ => q{default});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['=']},
					  Parse::RecDescent::_tracefirst($text),
					  q{default},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\=//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/[^\\@\\\{\\s]+/]}, Parse::RecDescent::_tracefirst($text),
					  q{default},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/[^\\@\\\{\\s]+/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[^\@\{\s]+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['=' /[^\\@\\\{\\s]+/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{default},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{default},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{default},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{default},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{default},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_list_def
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"_alternation_1_of_production_1_of_rule_list_def"};
	
	Parse::RecDescent::_trace(q{Trying rule: [_alternation_1_of_production_1_of_rule_list_def]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{_alternation_1_of_production_1_of_rule_list_def},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [static_list]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_list_def});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_list_def});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [static_list]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_list_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::static_list($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [static_list]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_list_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [static_list]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{static_list}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [static_list]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [dynamic_list]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[1];
		$text = $_[1];
		my $_savetext;
		@item = (q{_alternation_1_of_production_1_of_rule_list_def});
		%item = (__RULE__ => q{_alternation_1_of_production_1_of_rule_list_def});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying subrule: [dynamic_list]},
				  Parse::RecDescent::_tracefirst($text),
				  q{_alternation_1_of_production_1_of_rule_list_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::dynamic_list($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [dynamic_list]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{_alternation_1_of_production_1_of_rule_list_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [dynamic_list]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{dynamic_list}} = $_tok;
		push @item, $_tok;
		
		}


		Parse::RecDescent::_trace(q{>>Matched production: [dynamic_list]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{_alternation_1_of_production_1_of_rule_list_def},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{_alternation_1_of_production_1_of_rule_list_def},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::form_spec
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"form_spec"};
	
	Parse::RecDescent::_trace(q{Trying rule: [form_spec]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{form_spec},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [list_def, or line]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{form_spec});
		%item = (__RULE__ => q{form_spec});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying repeated subrule: [list_def, or line]},
				  Parse::RecDescent::_tracefirst($text),
				  q{form_spec},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{})->at($text);
		
		unless (defined ($_tok = $thisparser->_parserepeat($text, \&Parse::RecDescent::Text::FormBuilder::Parser::_alternation_1_of_production_1_of_rule_form_spec, 1, 100000000, $_noactions,$expectation,undef))) 
		{
			Parse::RecDescent::_trace(q{<<Didn't match repeated subrule: [list_def, or line]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{form_spec},
						  $tracelevel)
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched repeated subrule: [_alternation_1_of_production_1_of_rule_form_spec]<< (}
					. @$_tok . q{ times)},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{_alternation_1_of_production_1_of_rule_form_spec(s)}} = $_tok;
		push @item, $_tok;
		


		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do {
	$return = {
	    title    => $title,
	    author   => $author,
	    lists    => \%lists, 
	    patterns => \%patterns, 
	    fields   => \@fields,
	}
    };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: [list_def, or line]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{form_spec},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{form_spec},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{form_spec},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{form_spec},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::pattern
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"pattern"};
	
	Parse::RecDescent::_trace(q{Trying rule: [pattern]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{pattern},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [/.*/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{pattern},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{pattern});
		%item = (__RULE__ => q{pattern});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [/.*/]}, Parse::RecDescent::_tracefirst($text),
					  q{pattern},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:.*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: [/.*/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{pattern},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{pattern},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{pattern},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{pattern},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::comment
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"comment"};
	
	Parse::RecDescent::_trace(q{Trying rule: [comment]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{comment},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['#' /.*/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{comment},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{comment});
		%item = (__RULE__ => q{comment});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['#']},
					  Parse::RecDescent::_tracefirst($text),
					  q{comment},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\#//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/.*/]}, Parse::RecDescent::_tracefirst($text),
					  q{comment},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/.*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:.*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['#' /.*/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{comment},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{comment},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{comment},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{comment},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{comment},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::hint
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"hint"};
	
	Parse::RecDescent::_trace(q{Trying rule: [hint]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{hint},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['[' /[^\\]]+/ ']']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{hint});
		%item = (__RULE__ => q{hint});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['[']},
					  Parse::RecDescent::_tracefirst($text),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\[//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/[^\\]]+/]}, Parse::RecDescent::_tracefirst($text),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/[^\\]]+/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[^\]]+)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [']']},
					  Parse::RecDescent::_tracefirst($text),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{']'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\]//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING2__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $item[2] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['[' /[^\\]]+/ ']']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{hint},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{hint},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{hint},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{hint},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::type
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"type"};
	
	Parse::RecDescent::_trace(q{Trying rule: [type]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{type},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: [':' /textarea|text|password|file|checkbox|radio|select|hidden|static/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{type},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{type});
		%item = (__RULE__ => q{type});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: [':']},
					  Parse::RecDescent::_tracefirst($text),
					  q{type},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\://)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/textarea|text|password|file|checkbox|radio|select|hidden|static/]}, Parse::RecDescent::_tracefirst($text),
					  q{type},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/textarea|text|password|file|checkbox|radio|select|hidden|static/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:textarea|text|password|file|checkbox|radio|select|hidden|static)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: [':' /textarea|text|password|file|checkbox|radio|select|hidden|static/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{type},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{type},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{type},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{type},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{type},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::label
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"label"};
	
	Parse::RecDescent::_trace(q{Trying rule: [label]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{label},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['|' /[^:\\[\\\{\\/]+/i]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{label},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{label});
		%item = (__RULE__ => q{label});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['|']},
					  Parse::RecDescent::_tracefirst($text),
					  q{label},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\|//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/[^:\\[\\\{\\/]+/i]}, Parse::RecDescent::_tracefirst($text),
					  q{label},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/[^:\\[\\\{\\/]+/i})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:[^:\[\{\/]+)//i)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['|' /[^:\\[\\\{\\/]+/i]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{label},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{label},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{label},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{label},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{label},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::title
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"title"};
	
	Parse::RecDescent::_trace(q{Trying rule: [title]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{title},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['!title' /.*/]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{title});
		%item = (__RULE__ => q{title});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['!title']},
					  Parse::RecDescent::_tracefirst($text),
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\!title//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: [/.*/]}, Parse::RecDescent::_tracefirst($text),
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/.*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:.*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { warn "[Text::Formbuilder] Title redefined at input text line $thisline\n" if defined $title;
    $title = $item[2] };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['!title' /.*/]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{title},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{title},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{title},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{title},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::pattern_def
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"pattern_def"};
	
	Parse::RecDescent::_trace(q{Trying rule: [pattern_def]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{pattern_def},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['!pattern' pattern_name pattern]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{pattern_def});
		%item = (__RULE__ => q{pattern_def});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['!pattern']},
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\!pattern//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying subrule: [pattern_name]},
				  Parse::RecDescent::_tracefirst($text),
				  q{pattern_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{pattern_name})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::pattern_name($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [pattern_name]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{pattern_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [pattern_name]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{pattern_name}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying subrule: [pattern]},
				  Parse::RecDescent::_tracefirst($text),
				  q{pattern_def},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{pattern})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::pattern($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [pattern]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{pattern_def},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [pattern]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{pattern}} = $_tok;
		push @item, $_tok;
		
		}

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do { $patterns{$item{pattern_name}} = $item{pattern} };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['!pattern' pattern_name pattern]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{pattern_def},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{pattern_def},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{pattern_def},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{pattern_def},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::dynamic_list
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"dynamic_list"};
	
	Parse::RecDescent::_trace(q{Trying rule: [dynamic_list]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{dynamic_list},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		local $skip = defined($skip) ? $skip : $Parse::RecDescent::skip;
		Parse::RecDescent::_trace(q{Trying production: ['&' <perl_codeblock>]},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{dynamic_list});
		%item = (__RULE__ => q{dynamic_list});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['&']},
					  Parse::RecDescent::_tracefirst($text),
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\&//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		

		Parse::RecDescent::_trace(q{Trying directive: [<perl_codeblock>]},
					Parse::RecDescent::_tracefirst($text),
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE; 
		$_tok = do { Text::Balanced::extract_codeblock($text,undef,$skip,'{}');
					 };
		if (defined($_tok))
		{
			Parse::RecDescent::_trace(q{>>Matched directive<< (return value: [}
						. $_tok . q{])},
						Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		}
		else
		{
			Parse::RecDescent::_trace(q{<<Didn't match directive>>},
						Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		}
		
		last unless defined $_tok;
		push @item, $item{__DIRECTIVE1__}=$_tok;
		

		Parse::RecDescent::_trace(q{Trying action},
					  Parse::RecDescent::_tracefirst($text),
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		

		$_tok = ($_noactions) ? 0 : do {
	my @results = (eval $item[2]);
	if (ref $results[0] eq 'HASH') {
	    @options = @results;
	} else {    
	    @options = map { { $_ => $_ } } @results;
	}
    };
		unless (defined $_tok)
		{
			Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
					if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
					  . $_tok . q{])},
					  Parse::RecDescent::_tracefirst($text))
						if defined $::RD_TRACE;
		push @item, $_tok;
		$item{__ACTION1__}=$_tok;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['&' <perl_codeblock>]<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{dynamic_list},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{dynamic_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{dynamic_list},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{dynamic_list},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args)
sub Parse::RecDescent::Text::FormBuilder::Parser::static_list
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
	my $thisrule = $thisparser->{"rules"}{"static_list"};
	
	Parse::RecDescent::_trace(q{Trying rule: [static_list]},
				  Parse::RecDescent::_tracefirst($_[1]),
				  q{static_list},
				  $tracelevel)
					if defined $::RD_TRACE;

	
	my $err_at = @{$thisparser->{errors}};

	my $score;
	my $score_return;
	my $_tok;
	my $return = undef;
	my $_matched=0;
	my $commit=0;
	my @item = ();
	my %item = ();
	my $repeating =  defined($_[2]) && $_[2];
	my $_noactions = defined($_[3]) && $_[3];
 	my @arg =        defined $_[4] ? @{ &{$_[4]} } : ();
	my %arg =        ($#arg & 01) ? @arg : (@arg, undef);
	my $text;
	my $lastsep="";
	my $expectation = new Parse::RecDescent::Expectation($thisrule->expected());
	$expectation->at($_[1]);
	
	my $thisline;
	tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

	

	while (!$_matched && !$commit)
	{
		
		Parse::RecDescent::_trace(q{Trying production: ['\{' <leftop: option /,\\s*/ option> /,?/ '\}']},
					  Parse::RecDescent::_tracefirst($_[1]),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		my $thisprod = $thisrule->{"prods"}[0];
		$text = $_[1];
		my $_savetext;
		@item = (q{static_list});
		%item = (__RULE__ => q{static_list});
		my $repcount = 0;


		Parse::RecDescent::_trace(q{Trying terminal: ['\{']},
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\{//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING1__}=$&;
		

		Parse::RecDescent::_trace(q{Trying operator: [<leftop: option /,\\s*/ option>]},
				  Parse::RecDescent::_tracefirst($text),
				  q{static_list},
				  $tracelevel)
					if defined $::RD_TRACE;
		$expectation->is(q{<leftop: option /,\\s*/ option>})->at($text);

		$_tok = undef;
		OPLOOP: while (1)
		{
		  $repcount = 0;
		  my  @item;
		  
		  # MATCH LEFTARG
		  
		Parse::RecDescent::_trace(q{Trying subrule: [option]},
				  Parse::RecDescent::_tracefirst($text),
				  q{static_list},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{option})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::option($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [option]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{static_list},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [option]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{option}} = $_tok;
		push @item, $_tok;
		
		}


		  $repcount++;

		  my $savetext = $text;
		  my $backtrack;

		  # MATCH (OP RIGHTARG)(s)
		  while ($repcount < 100000000)
		  {
			$backtrack = 0;
			
		Parse::RecDescent::_trace(q{Trying terminal: [/,\\s*/]}, Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/,\\s*/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:,\s*)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN1__}=$&;
		

			pop @item;
			if (defined $1) {push @item, $item{'option(s)'}=$1; $backtrack=1;}
			
		Parse::RecDescent::_trace(q{Trying subrule: [option]},
				  Parse::RecDescent::_tracefirst($text),
				  q{static_list},
				  $tracelevel)
					if defined $::RD_TRACE;
		if (1) { no strict qw{refs};
		$expectation->is(q{option})->at($text);
		unless (defined ($_tok = Parse::RecDescent::Text::FormBuilder::Parser::option($thisparser,$text,$repeating,$_noactions,sub { \@arg })))
		{
			
			Parse::RecDescent::_trace(q{<<Didn't match subrule: [option]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{static_list},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched subrule: [option]<< (return value: [}
					. $_tok . q{]},
					  
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$item{q{option}} = $_tok;
		push @item, $_tok;
		
		}

			$savetext = $text;
			$repcount++;
		  }
		  $text = $savetext;
		  pop @item if $backtrack;

		  unless (@item) { undef $_tok; last }
		  $_tok = [ @item ];
		  last;
		} 

		unless ($repcount>=1)
		{
			Parse::RecDescent::_trace(q{<<Didn't match operator: [<leftop: option /,\\s*/ option>]>>},
						  Parse::RecDescent::_tracefirst($text),
						  q{static_list},
						  $tracelevel)
							if defined $::RD_TRACE;
			$expectation->failed();
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched operator: [<leftop: option /,\\s*/ option>]<< (return value: [}
					  . qq{@{$_tok||[]}} . q{]},
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;

		push @item, $item{'option(s)'}=$_tok||[];


		Parse::RecDescent::_trace(q{Trying terminal: [/,?/]}, Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{/,?/})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A(?:,?)//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;

			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
					if defined $::RD_TRACE;
		push @item, $item{__PATTERN2__}=$&;
		

		Parse::RecDescent::_trace(q{Trying terminal: ['\}']},
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$lastsep = "";
		$expectation->is(q{'\}'})->at($text);
		

		unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ s/\A\}//)
		{
			
			$expectation->failed();
			Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
			last;
		}
		Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
						. $& . q{])},
						  Parse::RecDescent::_tracefirst($text))
							if defined $::RD_TRACE;
		push @item, $item{__STRING2__}=$&;
		


		Parse::RecDescent::_trace(q{>>Matched production: ['\{' <leftop: option /,\\s*/ option> /,?/ '\}']<<},
					  Parse::RecDescent::_tracefirst($text),
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$_matched = 1;
		last;
	}


        unless ( $_matched || defined($return) || defined($score) )
	{
		

		$_[1] = $text;	# NOT SURE THIS IS NEEDED
		Parse::RecDescent::_trace(q{<<Didn't match rule>>},
					 Parse::RecDescent::_tracefirst($_[1]),
					 q{static_list},
					 $tracelevel)
					if defined $::RD_TRACE;
		return undef;
	}
	if (!defined($return) && defined($score))
	{
		Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
					  q{static_list},
					  $tracelevel)
						if defined $::RD_TRACE;
		$return = $score_return;
	}
	splice @{$thisparser->{errors}}, $err_at;
	$return = $item[$#item] unless defined $return;
	if (defined $::RD_TRACE)
	{
		Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
					  $return . q{])}, "",
					  q{static_list},
					  $tracelevel);
		Parse::RecDescent::_trace(q{(consumed: [} .
					  Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])}, 
					  Parse::RecDescent::_tracefirst($text),
					  , q{static_list},
					  $tracelevel)
	}
	$_[1] = $text;
	return $return;
}
}
package Text::FormBuilder::Parser; sub new { my $self = bless( {
                 '_AUTOTREE' => undef,
                 'localvars' => '',
                 'startcode' => '',
                 '_check' => {
                               'thisoffset' => '',
                               'itempos' => '',
                               'prevoffset' => '',
                               'prevline' => '',
                               'prevcolumn' => '',
                               'thiscolumn' => ''
                             },
                 'namespace' => 'Parse::RecDescent::Text::FormBuilder::Parser',
                 '_AUTOACTION' => undef,
                 'rules' => {
                              'row_col' => bless( {
                                                    'impcount' => 0,
                                                    'calls' => [],
                                                    'changed' => 0,
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'number' => '0',
                                                                          'strcount' => 0,
                                                                          'dircount' => 0,
                                                                          'uncommit' => undef,
                                                                          'error' => undef,
                                                                          'patcount' => 3,
                                                                          'actcount' => 1,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'pattern' => '\\d+',
                                                                                                'hashname' => '__PATTERN1__',
                                                                                                'description' => '/\\\\d+/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 82,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' ),
                                                                                       bless( {
                                                                                                'pattern' => ',\\s*',
                                                                                                'hashname' => '__PATTERN2__',
                                                                                                'description' => '/,\\\\s*/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 82,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' ),
                                                                                       bless( {
                                                                                                'pattern' => '\\d+',
                                                                                                'hashname' => '__PATTERN3__',
                                                                                                'description' => '/\\\\d+/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 82,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' ),
                                                                                       bless( {
                                                                                                'hashname' => '__ACTION1__',
                                                                                                'lookahead' => 0,
                                                                                                'line' => 83,
                                                                                                'code' => '{ $rows = $item[1]; $cols = $item[3] }'
                                                                                              }, 'Parse::RecDescent::Action' )
                                                                                     ],
                                                                          'line' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'name' => 'row_col',
                                                    'vars' => '',
                                                    'line' => 82
                                                  }, 'Parse::RecDescent::Rule' ),
                              'options' => bless( {
                                                    'impcount' => 0,
                                                    'calls' => [
                                                                 'option'
                                                               ],
                                                    'changed' => 0,
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'number' => '0',
                                                                          'strcount' => 2,
                                                                          'dircount' => 1,
                                                                          'uncommit' => undef,
                                                                          'error' => undef,
                                                                          'patcount' => 1,
                                                                          'actcount' => 0,
                                                                          'op' => [],
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'pattern' => '{',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'description' => '\'\\{\'',
                                                                                                'lookahead' => 0,
                                                                                                'line' => 95
                                                                                              }, 'Parse::RecDescent::Literal' ),
                                                                                       bless( {
                                                                                                'expected' => '<leftop: option /,\\\\s*/ option>',
                                                                                                'min' => 1,
                                                                                                'name' => '\'option(s)\'',
                                                                                                'max' => 100000000,
                                                                                                'leftarg' => bless( {
                                                                                                                      'subrule' => 'option',
                                                                                                                      'matchrule' => 0,
                                                                                                                      'implicit' => undef,
                                                                                                                      'argcode' => undef,
                                                                                                                      'lookahead' => 0,
                                                                                                                      'line' => 95
                                                                                                                    }, 'Parse::RecDescent::Subrule' ),
                                                                                                'rightarg' => bless( {
                                                                                                                       'subrule' => 'option',
                                                                                                                       'matchrule' => 0,
                                                                                                                       'implicit' => undef,
                                                                                                                       'argcode' => undef,
                                                                                                                       'lookahead' => 0,
                                                                                                                       'line' => 95
                                                                                                                     }, 'Parse::RecDescent::Subrule' ),
                                                                                                'hashname' => '__DIRECTIVE1__',
                                                                                                'type' => 'leftop',
                                                                                                'op' => bless( {
                                                                                                                 'pattern' => ',\\s*',
                                                                                                                 'hashname' => '__PATTERN1__',
                                                                                                                 'description' => '/,\\\\s*/',
                                                                                                                 'lookahead' => 0,
                                                                                                                 'rdelim' => '/',
                                                                                                                 'line' => 95,
                                                                                                                 'mod' => '',
                                                                                                                 'ldelim' => '/'
                                                                                                               }, 'Parse::RecDescent::Token' )
                                                                                              }, 'Parse::RecDescent::Operator' ),
                                                                                       bless( {
                                                                                                'pattern' => '}',
                                                                                                'hashname' => '__STRING2__',
                                                                                                'description' => '\'\\}\'',
                                                                                                'lookahead' => 0,
                                                                                                'line' => 95
                                                                                              }, 'Parse::RecDescent::Literal' )
                                                                                     ],
                                                                          'line' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'name' => 'options',
                                                    'vars' => '',
                                                    'line' => 95
                                                  }, 'Parse::RecDescent::Rule' ),
                              'list_def' => bless( {
                                                     'impcount' => 1,
                                                     'calls' => [
                                                                  'list_name',
                                                                  '_alternation_1_of_production_1_of_rule_list_def'
                                                                ],
                                                     'changed' => 0,
                                                     'opcount' => 0,
                                                     'prods' => [
                                                                  bless( {
                                                                           'number' => '0',
                                                                           'strcount' => 1,
                                                                           'dircount' => 0,
                                                                           'uncommit' => undef,
                                                                           'error' => undef,
                                                                           'patcount' => 0,
                                                                           'actcount' => 1,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'pattern' => '!list',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'description' => '\'!list\'',
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 14
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'subrule' => 'list_name',
                                                                                                 'matchrule' => 0,
                                                                                                 'implicit' => undef,
                                                                                                 'argcode' => undef,
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 14
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'subrule' => '_alternation_1_of_production_1_of_rule_list_def',
                                                                                                 'matchrule' => 0,
                                                                                                 'implicit' => 'static_list, or dynamic_list',
                                                                                                 'argcode' => undef,
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 14
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 15,
                                                                                                 'code' => '{ $lists{$item{list_name}} = [ @options ]; @options = () }'
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => undef
                                                                         }, 'Parse::RecDescent::Production' )
                                                                ],
                                                     'name' => 'list_def',
                                                     'vars' => '',
                                                     'line' => 14
                                                   }, 'Parse::RecDescent::Rule' ),
                              'field_size' => bless( {
                                                       'impcount' => 1,
                                                       'calls' => [
                                                                    '_alternation_1_of_production_1_of_rule_field_size'
                                                                  ],
                                                       'changed' => 0,
                                                       'opcount' => 0,
                                                       'prods' => [
                                                                    bless( {
                                                                             'number' => '0',
                                                                             'strcount' => 2,
                                                                             'dircount' => 0,
                                                                             'uncommit' => undef,
                                                                             'error' => undef,
                                                                             'patcount' => 0,
                                                                             'actcount' => 0,
                                                                             'items' => [
                                                                                          bless( {
                                                                                                   'pattern' => '[',
                                                                                                   'hashname' => '__STRING1__',
                                                                                                   'description' => '\'[\'',
                                                                                                   'lookahead' => 0,
                                                                                                   'line' => 77
                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                          bless( {
                                                                                                   'subrule' => '_alternation_1_of_production_1_of_rule_field_size',
                                                                                                   'matchrule' => 0,
                                                                                                   'implicit' => 'row_col, or size',
                                                                                                   'argcode' => undef,
                                                                                                   'lookahead' => 0,
                                                                                                   'line' => 77
                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                          bless( {
                                                                                                   'pattern' => ']',
                                                                                                   'hashname' => '__STRING2__',
                                                                                                   'description' => '\']\'',
                                                                                                   'lookahead' => 0,
                                                                                                   'line' => 77
                                                                                                 }, 'Parse::RecDescent::Literal' )
                                                                                        ],
                                                                             'line' => undef
                                                                           }, 'Parse::RecDescent::Production' )
                                                                  ],
                                                       'name' => 'field_size',
                                                       'vars' => '',
                                                       'line' => 77
                                                     }, 'Parse::RecDescent::Rule' ),
                              'author' => bless( {
                                                   'impcount' => 0,
                                                   'calls' => [],
                                                   'changed' => 0,
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'number' => '0',
                                                                         'strcount' => 1,
                                                                         'dircount' => 0,
                                                                         'uncommit' => undef,
                                                                         'error' => undef,
                                                                         'patcount' => 1,
                                                                         'actcount' => 1,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'pattern' => '!author',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'description' => '\'!author\'',
                                                                                               'lookahead' => 0,
                                                                                               'line' => 37
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'pattern' => '.*',
                                                                                               'hashname' => '__PATTERN1__',
                                                                                               'description' => '/.*/',
                                                                                               'lookahead' => 0,
                                                                                               'rdelim' => '/',
                                                                                               'line' => 37,
                                                                                               'mod' => '',
                                                                                               'ldelim' => '/'
                                                                                             }, 'Parse::RecDescent::Token' ),
                                                                                      bless( {
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'lookahead' => 0,
                                                                                               'line' => 38,
                                                                                               'code' => '{ $author = $item[2] }'
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'name' => 'author',
                                                   'vars' => '',
                                                   'line' => 37
                                                 }, 'Parse::RecDescent::Rule' ),
                              'list_name' => bless( {
                                                      'impcount' => 0,
                                                      'calls' => [],
                                                      'changed' => 0,
                                                      'opcount' => 0,
                                                      'prods' => [
                                                                   bless( {
                                                                            'number' => '0',
                                                                            'strcount' => 0,
                                                                            'dircount' => 0,
                                                                            'uncommit' => undef,
                                                                            'error' => undef,
                                                                            'patcount' => 1,
                                                                            'actcount' => 0,
                                                                            'items' => [
                                                                                         bless( {
                                                                                                  'pattern' => '[A-Z_]+',
                                                                                                  'hashname' => '__PATTERN1__',
                                                                                                  'description' => '/[A-Z_]+/',
                                                                                                  'lookahead' => 0,
                                                                                                  'rdelim' => '/',
                                                                                                  'line' => 29,
                                                                                                  'mod' => '',
                                                                                                  'ldelim' => '/'
                                                                                                }, 'Parse::RecDescent::Token' )
                                                                                       ],
                                                                            'line' => undef
                                                                          }, 'Parse::RecDescent::Production' )
                                                                 ],
                                                      'name' => 'list_name',
                                                      'vars' => '',
                                                      'line' => 29
                                                    }, 'Parse::RecDescent::Rule' ),
                              'size' => bless( {
                                                 'impcount' => 0,
                                                 'calls' => [],
                                                 'changed' => 0,
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'number' => '0',
                                                                       'strcount' => 0,
                                                                       'dircount' => 0,
                                                                       'uncommit' => undef,
                                                                       'error' => undef,
                                                                       'patcount' => 1,
                                                                       'actcount' => 1,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'pattern' => '\\d+',
                                                                                             'hashname' => '__PATTERN1__',
                                                                                             'description' => '/\\\\d+/',
                                                                                             'lookahead' => 0,
                                                                                             'rdelim' => '/',
                                                                                             'line' => 79,
                                                                                             'mod' => '',
                                                                                             'ldelim' => '/'
                                                                                           }, 'Parse::RecDescent::Token' ),
                                                                                    bless( {
                                                                                             'hashname' => '__ACTION1__',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 80,
                                                                                             'code' => '{ $size = $item[1] }'
                                                                                           }, 'Parse::RecDescent::Action' )
                                                                                  ],
                                                                       'line' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'name' => 'size',
                                                 'vars' => '',
                                                 'line' => 79
                                               }, 'Parse::RecDescent::Rule' ),
                              'identifier' => bless( {
                                                       'impcount' => 0,
                                                       'calls' => [],
                                                       'changed' => 0,
                                                       'opcount' => 0,
                                                       'prods' => [
                                                                    bless( {
                                                                             'number' => '0',
                                                                             'strcount' => 0,
                                                                             'dircount' => 0,
                                                                             'uncommit' => undef,
                                                                             'error' => undef,
                                                                             'patcount' => 1,
                                                                             'actcount' => 0,
                                                                             'items' => [
                                                                                          bless( {
                                                                                                   'pattern' => '\\w+',
                                                                                                   'hashname' => '__PATTERN1__',
                                                                                                   'description' => '/\\\\w+/',
                                                                                                   'lookahead' => 0,
                                                                                                   'rdelim' => '/',
                                                                                                   'line' => 111,
                                                                                                   'mod' => '',
                                                                                                   'ldelim' => '/'
                                                                                                 }, 'Parse::RecDescent::Token' )
                                                                                        ],
                                                                             'line' => undef
                                                                           }, 'Parse::RecDescent::Production' )
                                                                  ],
                                                       'name' => 'identifier',
                                                       'vars' => '',
                                                       'line' => 111
                                                     }, 'Parse::RecDescent::Rule' ),
                              'blank' => bless( {
                                                  'impcount' => 0,
                                                  'calls' => [],
                                                  'changed' => 0,
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'number' => '0',
                                                                        'strcount' => 0,
                                                                        'dircount' => 0,
                                                                        'uncommit' => undef,
                                                                        'error' => undef,
                                                                        'patcount' => 0,
                                                                        'actcount' => 0,
                                                                        'items' => [],
                                                                        'line' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'name' => 'blank',
                                                  'vars' => '',
                                                  'line' => 109
                                                }, 'Parse::RecDescent::Rule' ),
                              'option' => bless( {
                                                   'impcount' => 0,
                                                   'calls' => [
                                                                'value',
                                                                'display_text'
                                                              ],
                                                   'changed' => 0,
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'number' => '0',
                                                                         'strcount' => 0,
                                                                         'dircount' => 0,
                                                                         'uncommit' => undef,
                                                                         'error' => undef,
                                                                         'patcount' => 0,
                                                                         'actcount' => 1,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'subrule' => 'value',
                                                                                               'matchrule' => 0,
                                                                                               'implicit' => undef,
                                                                                               'argcode' => undef,
                                                                                               'lookahead' => 0,
                                                                                               'line' => 99
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'subrule' => 'display_text',
                                                                                               'expected' => undef,
                                                                                               'min' => 0,
                                                                                               'argcode' => undef,
                                                                                               'max' => 1,
                                                                                               'matchrule' => 0,
                                                                                               'repspec' => '?',
                                                                                               'lookahead' => 0,
                                                                                               'line' => 99
                                                                                             }, 'Parse::RecDescent::Repetition' ),
                                                                                      bless( {
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'lookahead' => 0,
                                                                                               'line' => 100,
                                                                                               'code' => '{ push @options, { $item{value} => $item{\'display_text(?)\'}[0] } }'
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'name' => 'option',
                                                   'vars' => '',
                                                   'line' => 99
                                                 }, 'Parse::RecDescent::Rule' ),
                              'pattern_name' => bless( {
                                                         'impcount' => 0,
                                                         'calls' => [],
                                                         'changed' => 0,
                                                         'opcount' => 0,
                                                         'prods' => [
                                                                      bless( {
                                                                               'number' => '0',
                                                                               'strcount' => 0,
                                                                               'dircount' => 0,
                                                                               'uncommit' => undef,
                                                                               'error' => undef,
                                                                               'patcount' => 1,
                                                                               'actcount' => 0,
                                                                               'items' => [
                                                                                            bless( {
                                                                                                     'pattern' => '[A-Z_]+',
                                                                                                     'hashname' => '__PATTERN1__',
                                                                                                     'description' => '/[A-Z_]+/',
                                                                                                     'lookahead' => 0,
                                                                                                     'rdelim' => '/',
                                                                                                     'line' => 43,
                                                                                                     'mod' => '',
                                                                                                     'ldelim' => '/'
                                                                                                   }, 'Parse::RecDescent::Token' )
                                                                                          ],
                                                                               'line' => undef
                                                                             }, 'Parse::RecDescent::Production' )
                                                                    ],
                                                         'name' => 'pattern_name',
                                                         'vars' => '',
                                                         'line' => 43
                                                       }, 'Parse::RecDescent::Rule' ),
                              'validate' => bless( {
                                                     'impcount' => 0,
                                                     'calls' => [
                                                                  'value'
                                                                ],
                                                     'changed' => 0,
                                                     'opcount' => 0,
                                                     'prods' => [
                                                                  bless( {
                                                                           'number' => '0',
                                                                           'strcount' => 1,
                                                                           'dircount' => 0,
                                                                           'uncommit' => undef,
                                                                           'error' => undef,
                                                                           'patcount' => 0,
                                                                           'actcount' => 0,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'pattern' => '//',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'description' => '\'//\'',
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 106
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'subrule' => 'value',
                                                                                                 'matchrule' => 0,
                                                                                                 'implicit' => undef,
                                                                                                 'argcode' => undef,
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 106
                                                                                               }, 'Parse::RecDescent::Subrule' )
                                                                                      ],
                                                                           'line' => undef
                                                                         }, 'Parse::RecDescent::Production' )
                                                                ],
                                                     'name' => 'validate',
                                                     'vars' => '',
                                                     'line' => 106
                                                   }, 'Parse::RecDescent::Rule' ),
                              'list_var' => bless( {
                                                     'impcount' => 0,
                                                     'calls' => [],
                                                     'changed' => 0,
                                                     'opcount' => 0,
                                                     'prods' => [
                                                                  bless( {
                                                                           'number' => '0',
                                                                           'strcount' => 0,
                                                                           'dircount' => 0,
                                                                           'uncommit' => undef,
                                                                           'error' => undef,
                                                                           'patcount' => 1,
                                                                           'actcount' => 1,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'pattern' => '@[A-Z_]+',
                                                                                                 'hashname' => '__PATTERN1__',
                                                                                                 'description' => '/@[A-Z_]+/',
                                                                                                 'lookahead' => 0,
                                                                                                 'rdelim' => '/',
                                                                                                 'line' => 97,
                                                                                                 'mod' => '',
                                                                                                 'ldelim' => '/'
                                                                                               }, 'Parse::RecDescent::Token' ),
                                                                                        bless( {
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'lookahead' => 0,
                                                                                                 'line' => 97,
                                                                                                 'code' => '{ $list_var = $item[1] }'
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => undef
                                                                         }, 'Parse::RecDescent::Production' )
                                                                ],
                                                     'name' => 'list_var',
                                                     'vars' => '',
                                                     'line' => 97
                                                   }, 'Parse::RecDescent::Rule' ),
                              'field' => bless( {
                                                  'impcount' => 0,
                                                  'calls' => [
                                                               'name',
                                                               'field_size',
                                                               'label',
                                                               'hint',
                                                               'type',
                                                               'default',
                                                               'option_list',
                                                               'validate'
                                                             ],
                                                  'changed' => 0,
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'number' => '0',
                                                                        'strcount' => 0,
                                                                        'dircount' => 0,
                                                                        'uncommit' => undef,
                                                                        'error' => undef,
                                                                        'patcount' => 0,
                                                                        'actcount' => 1,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'subrule' => 'name',
                                                                                              'matchrule' => 0,
                                                                                              'implicit' => undef,
                                                                                              'argcode' => undef,
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Subrule' ),
                                                                                     bless( {
                                                                                              'subrule' => 'field_size',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'label',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'hint',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'type',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'default',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'option_list',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'subrule' => 'validate',
                                                                                              'expected' => undef,
                                                                                              'min' => 0,
                                                                                              'argcode' => undef,
                                                                                              'max' => 1,
                                                                                              'matchrule' => 0,
                                                                                              'repspec' => '?',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 46
                                                                                            }, 'Parse::RecDescent::Repetition' ),
                                                                                     bless( {
                                                                                              'hashname' => '__ACTION1__',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 47,
                                                                                              'code' => '{
	my $field = {
	    name     => $item{name},
	    label    => $item{\'label(?)\'}[0],
	    comment  => $item{\'hint(?)\'}[0],
	    type     => $item{\'type(?)\'}[0],
	    value    => $item{\'default(?)\'}[0],
            list     => $list_var,
            validate => $item{\'validate(?)\'}[0],
	};
	
	$$field{options} = [ @options ] if @options;
	
	$$field{rows} = $rows if defined $rows;
	$$field{cols} = $cols if defined $cols;
	$$field{size} = $size if defined $size;
	
	push @fields, $field;
	
	$type = undef;
	$list_var = undef;
	$size = undef;
	$rows = undef;
	$cols = undef;
	@options = ();
        
    }'
                                                                                            }, 'Parse::RecDescent::Action' )
                                                                                   ],
                                                                        'line' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'name' => 'field',
                                                  'vars' => '',
                                                  'line' => 46
                                                }, 'Parse::RecDescent::Rule' ),
                              '_alternation_1_of_production_1_of_rule_form_spec' => bless( {
                                                                                             'impcount' => 0,
                                                                                             'calls' => [
                                                                                                          'list_def',
                                                                                                          'line'
                                                                                                        ],
                                                                                             'changed' => 0,
                                                                                             'opcount' => 0,
                                                                                             'prods' => [
                                                                                                          bless( {
                                                                                                                   'number' => '0',
                                                                                                                   'strcount' => 0,
                                                                                                                   'dircount' => 0,
                                                                                                                   'uncommit' => undef,
                                                                                                                   'error' => undef,
                                                                                                                   'patcount' => 0,
                                                                                                                   'actcount' => 0,
                                                                                                                   'items' => [
                                                                                                                                bless( {
                                                                                                                                         'subrule' => 'list_def',
                                                                                                                                         'matchrule' => 0,
                                                                                                                                         'implicit' => undef,
                                                                                                                                         'argcode' => undef,
                                                                                                                                         'lookahead' => 0,
                                                                                                                                         'line' => 112
                                                                                                                                       }, 'Parse::RecDescent::Subrule' )
                                                                                                                              ],
                                                                                                                   'line' => undef
                                                                                                                 }, 'Parse::RecDescent::Production' ),
                                                                                                          bless( {
                                                                                                                   'number' => '1',
                                                                                                                   'strcount' => 0,
                                                                                                                   'dircount' => 0,
                                                                                                                   'uncommit' => undef,
                                                                                                                   'error' => undef,
                                                                                                                   'patcount' => 0,
                                                                                                                   'actcount' => 0,
                                                                                                                   'items' => [
                                                                                                                                bless( {
                                                                                                                                         'subrule' => 'line',
                                                                                                                                         'matchrule' => 0,
                                                                                                                                         'implicit' => undef,
                                                                                                                                         'argcode' => undef,
                                                                                                                                         'lookahead' => 0,
                                                                                                                                         'line' => 112
                                                                                                                                       }, 'Parse::RecDescent::Subrule' )
                                                                                                                              ],
                                                                                                                   'line' => 112
                                                                                                                 }, 'Parse::RecDescent::Production' )
                                                                                                        ],
                                                                                             'name' => '_alternation_1_of_production_1_of_rule_form_spec',
                                                                                             'vars' => '',
                                                                                             'line' => 112
                                                                                           }, 'Parse::RecDescent::Rule' ),
                              'line' => bless( {
                                                 'impcount' => 1,
                                                 'calls' => [
                                                              '_alternation_1_of_production_1_of_rule_line'
                                                            ],
                                                 'changed' => 0,
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'number' => '0',
                                                                       'strcount' => 1,
                                                                       'dircount' => 1,
                                                                       'uncommit' => undef,
                                                                       'error' => undef,
                                                                       'patcount' => 0,
                                                                       'actcount' => 0,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'hashname' => '__DIRECTIVE1__',
                                                                                             'name' => '<skip:\'[ \\t]*\'>',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 31,
                                                                                             'code' => 'my $oldskip = $skip; $skip=\'[ \\t]*\'; $oldskip'
                                                                                           }, 'Parse::RecDescent::Directive' ),
                                                                                    bless( {
                                                                                             'subrule' => '_alternation_1_of_production_1_of_rule_line',
                                                                                             'matchrule' => 0,
                                                                                             'implicit' => 'title, or author, or pattern_def, or field, or comment, or blank',
                                                                                             'argcode' => undef,
                                                                                             'lookahead' => 0,
                                                                                             'line' => 31
                                                                                           }, 'Parse::RecDescent::Subrule' ),
                                                                                    bless( {
                                                                                             'pattern' => '\\n',
                                                                                             'hashname' => '__STRING1__',
                                                                                             'description' => '\'\\\\n\'',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 31
                                                                                           }, 'Parse::RecDescent::InterpLit' )
                                                                                  ],
                                                                       'line' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'name' => 'line',
                                                 'vars' => '',
                                                 'line' => 31
                                               }, 'Parse::RecDescent::Rule' ),
                              'option_list' => bless( {
                                                        'impcount' => 0,
                                                        'calls' => [
                                                                     'options',
                                                                     'list_var'
                                                                   ],
                                                        'changed' => 0,
                                                        'opcount' => 0,
                                                        'prods' => [
                                                                     bless( {
                                                                              'number' => '0',
                                                                              'strcount' => 0,
                                                                              'dircount' => 0,
                                                                              'uncommit' => undef,
                                                                              'error' => undef,
                                                                              'patcount' => 0,
                                                                              'actcount' => 0,
                                                                              'items' => [
                                                                                           bless( {
                                                                                                    'subrule' => 'options',
                                                                                                    'matchrule' => 0,
                                                                                                    'implicit' => undef,
                                                                                                    'argcode' => undef,
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 93
                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                         ],
                                                                              'line' => undef
                                                                            }, 'Parse::RecDescent::Production' ),
                                                                     bless( {
                                                                              'number' => '1',
                                                                              'strcount' => 0,
                                                                              'dircount' => 0,
                                                                              'uncommit' => undef,
                                                                              'error' => undef,
                                                                              'patcount' => 0,
                                                                              'actcount' => 0,
                                                                              'items' => [
                                                                                           bless( {
                                                                                                    'subrule' => 'list_var',
                                                                                                    'matchrule' => 0,
                                                                                                    'implicit' => undef,
                                                                                                    'argcode' => undef,
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 93
                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                         ],
                                                                              'line' => 93
                                                                            }, 'Parse::RecDescent::Production' )
                                                                   ],
                                                        'name' => 'option_list',
                                                        'vars' => '',
                                                        'line' => 93
                                                      }, 'Parse::RecDescent::Rule' ),
                              '_alternation_1_of_production_1_of_rule_line' => bless( {
                                                                                        'impcount' => 0,
                                                                                        'calls' => [
                                                                                                     'title',
                                                                                                     'author',
                                                                                                     'pattern_def',
                                                                                                     'field',
                                                                                                     'comment',
                                                                                                     'blank'
                                                                                                   ],
                                                                                        'changed' => 0,
                                                                                        'opcount' => 0,
                                                                                        'prods' => [
                                                                                                     bless( {
                                                                                                              'number' => '0',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'title',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => undef
                                                                                                            }, 'Parse::RecDescent::Production' ),
                                                                                                     bless( {
                                                                                                              'number' => '1',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'author',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => 112
                                                                                                            }, 'Parse::RecDescent::Production' ),
                                                                                                     bless( {
                                                                                                              'number' => '2',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'pattern_def',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => 112
                                                                                                            }, 'Parse::RecDescent::Production' ),
                                                                                                     bless( {
                                                                                                              'number' => '3',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'field',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => 112
                                                                                                            }, 'Parse::RecDescent::Production' ),
                                                                                                     bless( {
                                                                                                              'number' => '4',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'comment',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => 112
                                                                                                            }, 'Parse::RecDescent::Production' ),
                                                                                                     bless( {
                                                                                                              'number' => '5',
                                                                                                              'strcount' => 0,
                                                                                                              'dircount' => 0,
                                                                                                              'uncommit' => undef,
                                                                                                              'error' => undef,
                                                                                                              'patcount' => 0,
                                                                                                              'actcount' => 0,
                                                                                                              'items' => [
                                                                                                                           bless( {
                                                                                                                                    'subrule' => 'blank',
                                                                                                                                    'matchrule' => 0,
                                                                                                                                    'implicit' => undef,
                                                                                                                                    'argcode' => undef,
                                                                                                                                    'lookahead' => 0,
                                                                                                                                    'line' => 112
                                                                                                                                  }, 'Parse::RecDescent::Subrule' )
                                                                                                                         ],
                                                                                                              'line' => 112
                                                                                                            }, 'Parse::RecDescent::Production' )
                                                                                                   ],
                                                                                        'name' => '_alternation_1_of_production_1_of_rule_line',
                                                                                        'vars' => '',
                                                                                        'line' => 112
                                                                                      }, 'Parse::RecDescent::Rule' ),
                              'value' => bless( {
                                                  'impcount' => 0,
                                                  'calls' => [
                                                               'identifier'
                                                             ],
                                                  'changed' => 0,
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'number' => '0',
                                                                        'strcount' => 0,
                                                                        'dircount' => 0,
                                                                        'uncommit' => undef,
                                                                        'error' => undef,
                                                                        'patcount' => 0,
                                                                        'actcount' => 0,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'subrule' => 'identifier',
                                                                                              'matchrule' => 0,
                                                                                              'implicit' => undef,
                                                                                              'argcode' => undef,
                                                                                              'lookahead' => 0,
                                                                                              'line' => 102
                                                                                            }, 'Parse::RecDescent::Subrule' )
                                                                                   ],
                                                                        'line' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'name' => 'value',
                                                  'vars' => '',
                                                  'line' => 102
                                                }, 'Parse::RecDescent::Rule' ),
                              '_alternation_1_of_production_1_of_rule_field_size' => bless( {
                                                                                              'impcount' => 0,
                                                                                              'calls' => [
                                                                                                           'row_col',
                                                                                                           'size'
                                                                                                         ],
                                                                                              'changed' => 0,
                                                                                              'opcount' => 0,
                                                                                              'prods' => [
                                                                                                           bless( {
                                                                                                                    'number' => '0',
                                                                                                                    'strcount' => 0,
                                                                                                                    'dircount' => 0,
                                                                                                                    'uncommit' => undef,
                                                                                                                    'error' => undef,
                                                                                                                    'patcount' => 0,
                                                                                                                    'actcount' => 0,
                                                                                                                    'items' => [
                                                                                                                                 bless( {
                                                                                                                                          'subrule' => 'row_col',
                                                                                                                                          'matchrule' => 0,
                                                                                                                                          'implicit' => undef,
                                                                                                                                          'argcode' => undef,
                                                                                                                                          'lookahead' => 0,
                                                                                                                                          'line' => 112
                                                                                                                                        }, 'Parse::RecDescent::Subrule' )
                                                                                                                               ],
                                                                                                                    'line' => undef
                                                                                                                  }, 'Parse::RecDescent::Production' ),
                                                                                                           bless( {
                                                                                                                    'number' => '1',
                                                                                                                    'strcount' => 0,
                                                                                                                    'dircount' => 0,
                                                                                                                    'uncommit' => undef,
                                                                                                                    'error' => undef,
                                                                                                                    'patcount' => 0,
                                                                                                                    'actcount' => 0,
                                                                                                                    'items' => [
                                                                                                                                 bless( {
                                                                                                                                          'subrule' => 'size',
                                                                                                                                          'matchrule' => 0,
                                                                                                                                          'implicit' => undef,
                                                                                                                                          'argcode' => undef,
                                                                                                                                          'lookahead' => 0,
                                                                                                                                          'line' => 112
                                                                                                                                        }, 'Parse::RecDescent::Subrule' )
                                                                                                                               ],
                                                                                                                    'line' => 112
                                                                                                                  }, 'Parse::RecDescent::Production' )
                                                                                                         ],
                                                                                              'name' => '_alternation_1_of_production_1_of_rule_field_size',
                                                                                              'vars' => '',
                                                                                              'line' => 112
                                                                                            }, 'Parse::RecDescent::Rule' ),
                              'name' => bless( {
                                                 'impcount' => 0,
                                                 'calls' => [
                                                              'identifier'
                                                            ],
                                                 'changed' => 0,
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'number' => '0',
                                                                       'strcount' => 0,
                                                                       'dircount' => 0,
                                                                       'uncommit' => undef,
                                                                       'error' => undef,
                                                                       'patcount' => 0,
                                                                       'actcount' => 0,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'subrule' => 'identifier',
                                                                                             'matchrule' => 0,
                                                                                             'implicit' => undef,
                                                                                             'argcode' => undef,
                                                                                             'lookahead' => 0,
                                                                                             'line' => 75
                                                                                           }, 'Parse::RecDescent::Subrule' )
                                                                                  ],
                                                                       'line' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'name' => 'name',
                                                 'vars' => '',
                                                 'line' => 75
                                               }, 'Parse::RecDescent::Rule' ),
                              'display_text' => bless( {
                                                         'impcount' => 0,
                                                         'calls' => [],
                                                         'changed' => 0,
                                                         'opcount' => 0,
                                                         'prods' => [
                                                                      bless( {
                                                                               'number' => '0',
                                                                               'strcount' => 2,
                                                                               'dircount' => 0,
                                                                               'uncommit' => undef,
                                                                               'error' => undef,
                                                                               'patcount' => 1,
                                                                               'actcount' => 1,
                                                                               'items' => [
                                                                                            bless( {
                                                                                                     'pattern' => '[',
                                                                                                     'hashname' => '__STRING1__',
                                                                                                     'description' => '\'[\'',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 104
                                                                                                   }, 'Parse::RecDescent::Literal' ),
                                                                                            bless( {
                                                                                                     'pattern' => '[^\\]]+',
                                                                                                     'hashname' => '__PATTERN1__',
                                                                                                     'description' => '/[^\\\\]]+/i',
                                                                                                     'lookahead' => 0,
                                                                                                     'rdelim' => '/',
                                                                                                     'line' => 104,
                                                                                                     'mod' => 'i',
                                                                                                     'ldelim' => '/'
                                                                                                   }, 'Parse::RecDescent::Token' ),
                                                                                            bless( {
                                                                                                     'pattern' => ']',
                                                                                                     'hashname' => '__STRING2__',
                                                                                                     'description' => '\']\'',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 104
                                                                                                   }, 'Parse::RecDescent::Literal' ),
                                                                                            bless( {
                                                                                                     'hashname' => '__ACTION1__',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 104,
                                                                                                     'code' => '{ $item[2] }'
                                                                                                   }, 'Parse::RecDescent::Action' )
                                                                                          ],
                                                                               'line' => undef
                                                                             }, 'Parse::RecDescent::Production' )
                                                                    ],
                                                         'name' => 'display_text',
                                                         'vars' => '',
                                                         'line' => 104
                                                       }, 'Parse::RecDescent::Rule' ),
                              'default' => bless( {
                                                    'impcount' => 0,
                                                    'calls' => [],
                                                    'changed' => 0,
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'number' => '0',
                                                                          'strcount' => 1,
                                                                          'dircount' => 0,
                                                                          'uncommit' => undef,
                                                                          'error' => undef,
                                                                          'patcount' => 1,
                                                                          'actcount' => 0,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'pattern' => '=',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'description' => '\'=\'',
                                                                                                'lookahead' => 0,
                                                                                                'line' => 91
                                                                                              }, 'Parse::RecDescent::Literal' ),
                                                                                       bless( {
                                                                                                'pattern' => '[^\\@\\{\\s]+',
                                                                                                'hashname' => '__PATTERN1__',
                                                                                                'description' => '/[^\\\\@\\\\\\{\\\\s]+/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 91,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' )
                                                                                     ],
                                                                          'line' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'name' => 'default',
                                                    'vars' => '',
                                                    'line' => 91
                                                  }, 'Parse::RecDescent::Rule' ),
                              '_alternation_1_of_production_1_of_rule_list_def' => bless( {
                                                                                            'impcount' => 0,
                                                                                            'calls' => [
                                                                                                         'static_list',
                                                                                                         'dynamic_list'
                                                                                                       ],
                                                                                            'changed' => 0,
                                                                                            'opcount' => 0,
                                                                                            'prods' => [
                                                                                                         bless( {
                                                                                                                  'number' => '0',
                                                                                                                  'strcount' => 0,
                                                                                                                  'dircount' => 0,
                                                                                                                  'uncommit' => undef,
                                                                                                                  'error' => undef,
                                                                                                                  'patcount' => 0,
                                                                                                                  'actcount' => 0,
                                                                                                                  'items' => [
                                                                                                                               bless( {
                                                                                                                                        'subrule' => 'static_list',
                                                                                                                                        'matchrule' => 0,
                                                                                                                                        'implicit' => undef,
                                                                                                                                        'argcode' => undef,
                                                                                                                                        'lookahead' => 0,
                                                                                                                                        'line' => 112
                                                                                                                                      }, 'Parse::RecDescent::Subrule' )
                                                                                                                             ],
                                                                                                                  'line' => undef
                                                                                                                }, 'Parse::RecDescent::Production' ),
                                                                                                         bless( {
                                                                                                                  'number' => '1',
                                                                                                                  'strcount' => 0,
                                                                                                                  'dircount' => 0,
                                                                                                                  'uncommit' => undef,
                                                                                                                  'error' => undef,
                                                                                                                  'patcount' => 0,
                                                                                                                  'actcount' => 0,
                                                                                                                  'items' => [
                                                                                                                               bless( {
                                                                                                                                        'subrule' => 'dynamic_list',
                                                                                                                                        'matchrule' => 0,
                                                                                                                                        'implicit' => undef,
                                                                                                                                        'argcode' => undef,
                                                                                                                                        'lookahead' => 0,
                                                                                                                                        'line' => 112
                                                                                                                                      }, 'Parse::RecDescent::Subrule' )
                                                                                                                             ],
                                                                                                                  'line' => 112
                                                                                                                }, 'Parse::RecDescent::Production' )
                                                                                                       ],
                                                                                            'name' => '_alternation_1_of_production_1_of_rule_list_def',
                                                                                            'vars' => '',
                                                                                            'line' => 112
                                                                                          }, 'Parse::RecDescent::Rule' ),
                              'form_spec' => bless( {
                                                      'impcount' => 1,
                                                      'calls' => [
                                                                   '_alternation_1_of_production_1_of_rule_form_spec'
                                                                 ],
                                                      'changed' => 0,
                                                      'opcount' => 0,
                                                      'prods' => [
                                                                   bless( {
                                                                            'number' => '0',
                                                                            'strcount' => 0,
                                                                            'dircount' => 0,
                                                                            'uncommit' => undef,
                                                                            'error' => undef,
                                                                            'patcount' => 0,
                                                                            'actcount' => 1,
                                                                            'items' => [
                                                                                         bless( {
                                                                                                  'subrule' => '_alternation_1_of_production_1_of_rule_form_spec',
                                                                                                  'expected' => 'list_def, or line',
                                                                                                  'min' => 1,
                                                                                                  'argcode' => undef,
                                                                                                  'max' => 100000000,
                                                                                                  'matchrule' => 0,
                                                                                                  'repspec' => 's',
                                                                                                  'lookahead' => 0,
                                                                                                  'line' => 3
                                                                                                }, 'Parse::RecDescent::Repetition' ),
                                                                                         bless( {
                                                                                                  'hashname' => '__ACTION1__',
                                                                                                  'lookahead' => 0,
                                                                                                  'line' => 4,
                                                                                                  'code' => '{
	$return = {
	    title    => $title,
	    author   => $author,
	    lists    => \\%lists, 
	    patterns => \\%patterns, 
	    fields   => \\@fields,
	}
    }'
                                                                                                }, 'Parse::RecDescent::Action' )
                                                                                       ],
                                                                            'line' => undef
                                                                          }, 'Parse::RecDescent::Production' )
                                                                 ],
                                                      'name' => 'form_spec',
                                                      'vars' => '',
                                                      'line' => 3
                                                    }, 'Parse::RecDescent::Rule' ),
                              'pattern' => bless( {
                                                    'impcount' => 0,
                                                    'calls' => [],
                                                    'changed' => 0,
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'number' => '0',
                                                                          'strcount' => 0,
                                                                          'dircount' => 0,
                                                                          'uncommit' => undef,
                                                                          'error' => undef,
                                                                          'patcount' => 1,
                                                                          'actcount' => 0,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'pattern' => '.*',
                                                                                                'hashname' => '__PATTERN1__',
                                                                                                'description' => '/.*/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 44,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' )
                                                                                     ],
                                                                          'line' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'name' => 'pattern',
                                                    'vars' => '',
                                                    'line' => 44
                                                  }, 'Parse::RecDescent::Rule' ),
                              'comment' => bless( {
                                                    'impcount' => 0,
                                                    'calls' => [],
                                                    'changed' => 0,
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'number' => '0',
                                                                          'strcount' => 1,
                                                                          'dircount' => 0,
                                                                          'uncommit' => undef,
                                                                          'error' => undef,
                                                                          'patcount' => 1,
                                                                          'actcount' => 0,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'pattern' => '#',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'description' => '\'#\'',
                                                                                                'lookahead' => 0,
                                                                                                'line' => 108
                                                                                              }, 'Parse::RecDescent::Literal' ),
                                                                                       bless( {
                                                                                                'pattern' => '.*',
                                                                                                'hashname' => '__PATTERN1__',
                                                                                                'description' => '/.*/',
                                                                                                'lookahead' => 0,
                                                                                                'rdelim' => '/',
                                                                                                'line' => 108,
                                                                                                'mod' => '',
                                                                                                'ldelim' => '/'
                                                                                              }, 'Parse::RecDescent::Token' )
                                                                                     ],
                                                                          'line' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'name' => 'comment',
                                                    'vars' => '',
                                                    'line' => 108
                                                  }, 'Parse::RecDescent::Rule' ),
                              'hint' => bless( {
                                                 'impcount' => 0,
                                                 'calls' => [],
                                                 'changed' => 0,
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'number' => '0',
                                                                       'strcount' => 2,
                                                                       'dircount' => 0,
                                                                       'uncommit' => undef,
                                                                       'error' => undef,
                                                                       'patcount' => 1,
                                                                       'actcount' => 1,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'pattern' => '[',
                                                                                             'hashname' => '__STRING1__',
                                                                                             'description' => '\'[\'',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 87
                                                                                           }, 'Parse::RecDescent::Literal' ),
                                                                                    bless( {
                                                                                             'pattern' => '[^\\]]+',
                                                                                             'hashname' => '__PATTERN1__',
                                                                                             'description' => '/[^\\\\]]+/',
                                                                                             'lookahead' => 0,
                                                                                             'rdelim' => '/',
                                                                                             'line' => 87,
                                                                                             'mod' => '',
                                                                                             'ldelim' => '/'
                                                                                           }, 'Parse::RecDescent::Token' ),
                                                                                    bless( {
                                                                                             'pattern' => ']',
                                                                                             'hashname' => '__STRING2__',
                                                                                             'description' => '\']\'',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 87
                                                                                           }, 'Parse::RecDescent::Literal' ),
                                                                                    bless( {
                                                                                             'hashname' => '__ACTION1__',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 87,
                                                                                             'code' => '{ $item[2] }'
                                                                                           }, 'Parse::RecDescent::Action' )
                                                                                  ],
                                                                       'line' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'name' => 'hint',
                                                 'vars' => '',
                                                 'line' => 87
                                               }, 'Parse::RecDescent::Rule' ),
                              'type' => bless( {
                                                 'impcount' => 0,
                                                 'calls' => [],
                                                 'changed' => 0,
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'number' => '0',
                                                                       'strcount' => 1,
                                                                       'dircount' => 0,
                                                                       'uncommit' => undef,
                                                                       'error' => undef,
                                                                       'patcount' => 1,
                                                                       'actcount' => 0,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'pattern' => ':',
                                                                                             'hashname' => '__STRING1__',
                                                                                             'description' => '\':\'',
                                                                                             'lookahead' => 0,
                                                                                             'line' => 89
                                                                                           }, 'Parse::RecDescent::Literal' ),
                                                                                    bless( {
                                                                                             'pattern' => 'textarea|text|password|file|checkbox|radio|select|hidden|static',
                                                                                             'hashname' => '__PATTERN1__',
                                                                                             'description' => '/textarea|text|password|file|checkbox|radio|select|hidden|static/',
                                                                                             'lookahead' => 0,
                                                                                             'rdelim' => '/',
                                                                                             'line' => 89,
                                                                                             'mod' => '',
                                                                                             'ldelim' => '/'
                                                                                           }, 'Parse::RecDescent::Token' )
                                                                                  ],
                                                                       'line' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'name' => 'type',
                                                 'vars' => '',
                                                 'line' => 89
                                               }, 'Parse::RecDescent::Rule' ),
                              'label' => bless( {
                                                  'impcount' => 0,
                                                  'calls' => [],
                                                  'changed' => 0,
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'number' => '0',
                                                                        'strcount' => 1,
                                                                        'dircount' => 0,
                                                                        'uncommit' => undef,
                                                                        'error' => undef,
                                                                        'patcount' => 1,
                                                                        'actcount' => 0,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'pattern' => '|',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'description' => '\'|\'',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 85
                                                                                            }, 'Parse::RecDescent::Literal' ),
                                                                                     bless( {
                                                                                              'pattern' => '[^:\\[\\{\\/]+',
                                                                                              'hashname' => '__PATTERN1__',
                                                                                              'description' => '/[^:\\\\[\\\\\\{\\\\/]+/i',
                                                                                              'lookahead' => 0,
                                                                                              'rdelim' => '/',
                                                                                              'line' => 85,
                                                                                              'mod' => 'i',
                                                                                              'ldelim' => '/'
                                                                                            }, 'Parse::RecDescent::Token' )
                                                                                   ],
                                                                        'line' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'name' => 'label',
                                                  'vars' => '',
                                                  'line' => 85
                                                }, 'Parse::RecDescent::Rule' ),
                              'title' => bless( {
                                                  'impcount' => 0,
                                                  'calls' => [],
                                                  'changed' => 0,
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'number' => '0',
                                                                        'strcount' => 1,
                                                                        'dircount' => 0,
                                                                        'uncommit' => undef,
                                                                        'error' => undef,
                                                                        'patcount' => 1,
                                                                        'actcount' => 1,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'pattern' => '!title',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'description' => '\'!title\'',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 33
                                                                                            }, 'Parse::RecDescent::Literal' ),
                                                                                     bless( {
                                                                                              'pattern' => '.*',
                                                                                              'hashname' => '__PATTERN1__',
                                                                                              'description' => '/.*/',
                                                                                              'lookahead' => 0,
                                                                                              'rdelim' => '/',
                                                                                              'line' => 33,
                                                                                              'mod' => '',
                                                                                              'ldelim' => '/'
                                                                                            }, 'Parse::RecDescent::Token' ),
                                                                                     bless( {
                                                                                              'hashname' => '__ACTION1__',
                                                                                              'lookahead' => 0,
                                                                                              'line' => 34,
                                                                                              'code' => '{ warn "[Text::Formbuilder] Title redefined at input text line $thisline\\n" if defined $title;
    $title = $item[2] }'
                                                                                            }, 'Parse::RecDescent::Action' )
                                                                                   ],
                                                                        'line' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'name' => 'title',
                                                  'vars' => '',
                                                  'line' => 33
                                                }, 'Parse::RecDescent::Rule' ),
                              'pattern_def' => bless( {
                                                        'impcount' => 0,
                                                        'calls' => [
                                                                     'pattern_name',
                                                                     'pattern'
                                                                   ],
                                                        'changed' => 0,
                                                        'opcount' => 0,
                                                        'prods' => [
                                                                     bless( {
                                                                              'number' => '0',
                                                                              'strcount' => 1,
                                                                              'dircount' => 0,
                                                                              'uncommit' => undef,
                                                                              'error' => undef,
                                                                              'patcount' => 0,
                                                                              'actcount' => 1,
                                                                              'items' => [
                                                                                           bless( {
                                                                                                    'pattern' => '!pattern',
                                                                                                    'hashname' => '__STRING1__',
                                                                                                    'description' => '\'!pattern\'',
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 40
                                                                                                  }, 'Parse::RecDescent::Literal' ),
                                                                                           bless( {
                                                                                                    'subrule' => 'pattern_name',
                                                                                                    'matchrule' => 0,
                                                                                                    'implicit' => undef,
                                                                                                    'argcode' => undef,
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 40
                                                                                                  }, 'Parse::RecDescent::Subrule' ),
                                                                                           bless( {
                                                                                                    'subrule' => 'pattern',
                                                                                                    'matchrule' => 0,
                                                                                                    'implicit' => undef,
                                                                                                    'argcode' => undef,
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 40
                                                                                                  }, 'Parse::RecDescent::Subrule' ),
                                                                                           bless( {
                                                                                                    'hashname' => '__ACTION1__',
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 41,
                                                                                                    'code' => '{ $patterns{$item{pattern_name}} = $item{pattern} }'
                                                                                                  }, 'Parse::RecDescent::Action' )
                                                                                         ],
                                                                              'line' => undef
                                                                            }, 'Parse::RecDescent::Production' )
                                                                   ],
                                                        'name' => 'pattern_def',
                                                        'vars' => '',
                                                        'line' => 40
                                                      }, 'Parse::RecDescent::Rule' ),
                              'dynamic_list' => bless( {
                                                         'impcount' => 0,
                                                         'calls' => [],
                                                         'changed' => 0,
                                                         'opcount' => 0,
                                                         'prods' => [
                                                                      bless( {
                                                                               'number' => '0',
                                                                               'strcount' => 1,
                                                                               'dircount' => 1,
                                                                               'uncommit' => undef,
                                                                               'error' => undef,
                                                                               'patcount' => 0,
                                                                               'actcount' => 1,
                                                                               'items' => [
                                                                                            bless( {
                                                                                                     'pattern' => '&',
                                                                                                     'hashname' => '__STRING1__',
                                                                                                     'description' => '\'&\'',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 19
                                                                                                   }, 'Parse::RecDescent::Literal' ),
                                                                                            bless( {
                                                                                                     'hashname' => '__DIRECTIVE1__',
                                                                                                     'name' => '<perl_codeblock>',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 19,
                                                                                                     'code' => 'Text::Balanced::extract_codeblock($text,undef,$skip,\'{}\');
					'
                                                                                                   }, 'Parse::RecDescent::Directive' ),
                                                                                            bless( {
                                                                                                     'hashname' => '__ACTION1__',
                                                                                                     'lookahead' => 0,
                                                                                                     'line' => 20,
                                                                                                     'code' => '{
	my @results = (eval $item[2]);
	if (ref $results[0] eq \'HASH\') {
	    @options = @results;
	} else {    
	    @options = map { { $_ => $_ } } @results;
	}
    }'
                                                                                                   }, 'Parse::RecDescent::Action' )
                                                                                          ],
                                                                               'line' => undef
                                                                             }, 'Parse::RecDescent::Production' )
                                                                    ],
                                                         'name' => 'dynamic_list',
                                                         'vars' => '',
                                                         'line' => 19
                                                       }, 'Parse::RecDescent::Rule' ),
                              'static_list' => bless( {
                                                        'impcount' => 0,
                                                        'calls' => [
                                                                     'option'
                                                                   ],
                                                        'changed' => 0,
                                                        'opcount' => 0,
                                                        'prods' => [
                                                                     bless( {
                                                                              'number' => '0',
                                                                              'strcount' => 2,
                                                                              'dircount' => 1,
                                                                              'uncommit' => undef,
                                                                              'error' => undef,
                                                                              'patcount' => 2,
                                                                              'actcount' => 0,
                                                                              'op' => [],
                                                                              'items' => [
                                                                                           bless( {
                                                                                                    'pattern' => '{',
                                                                                                    'hashname' => '__STRING1__',
                                                                                                    'description' => '\'\\{\'',
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 17
                                                                                                  }, 'Parse::RecDescent::Literal' ),
                                                                                           bless( {
                                                                                                    'expected' => '<leftop: option /,\\\\s*/ option>',
                                                                                                    'min' => 1,
                                                                                                    'name' => '\'option(s)\'',
                                                                                                    'max' => 100000000,
                                                                                                    'leftarg' => bless( {
                                                                                                                          'subrule' => 'option',
                                                                                                                          'matchrule' => 0,
                                                                                                                          'implicit' => undef,
                                                                                                                          'argcode' => undef,
                                                                                                                          'lookahead' => 0,
                                                                                                                          'line' => 17
                                                                                                                        }, 'Parse::RecDescent::Subrule' ),
                                                                                                    'rightarg' => bless( {
                                                                                                                           'subrule' => 'option',
                                                                                                                           'matchrule' => 0,
                                                                                                                           'implicit' => undef,
                                                                                                                           'argcode' => undef,
                                                                                                                           'lookahead' => 0,
                                                                                                                           'line' => 17
                                                                                                                         }, 'Parse::RecDescent::Subrule' ),
                                                                                                    'hashname' => '__DIRECTIVE1__',
                                                                                                    'type' => 'leftop',
                                                                                                    'op' => bless( {
                                                                                                                     'pattern' => ',\\s*',
                                                                                                                     'hashname' => '__PATTERN1__',
                                                                                                                     'description' => '/,\\\\s*/',
                                                                                                                     'lookahead' => 0,
                                                                                                                     'rdelim' => '/',
                                                                                                                     'line' => 17,
                                                                                                                     'mod' => '',
                                                                                                                     'ldelim' => '/'
                                                                                                                   }, 'Parse::RecDescent::Token' )
                                                                                                  }, 'Parse::RecDescent::Operator' ),
                                                                                           bless( {
                                                                                                    'pattern' => ',?',
                                                                                                    'hashname' => '__PATTERN2__',
                                                                                                    'description' => '/,?/',
                                                                                                    'lookahead' => 0,
                                                                                                    'rdelim' => '/',
                                                                                                    'line' => 17,
                                                                                                    'mod' => '',
                                                                                                    'ldelim' => '/'
                                                                                                  }, 'Parse::RecDescent::Token' ),
                                                                                           bless( {
                                                                                                    'pattern' => '}',
                                                                                                    'hashname' => '__STRING2__',
                                                                                                    'description' => '\'\\}\'',
                                                                                                    'lookahead' => 0,
                                                                                                    'line' => 17
                                                                                                  }, 'Parse::RecDescent::Literal' )
                                                                                         ],
                                                                              'line' => undef
                                                                            }, 'Parse::RecDescent::Production' )
                                                                   ],
                                                        'name' => 'static_list',
                                                        'vars' => '',
                                                        'line' => 17
                                                      }, 'Parse::RecDescent::Rule' )
                            }
               }, 'Parse::RecDescent' );
}
#!/usr/bin/perl -w

use strict;
use warnings qw(FATAL all);
use lib 'lib';
use Test::More tests => 19;

use Data::Alias;

{
	my %x;
	alias my @y = map $_, map $x{ $_ }, map $_, qw( foo bar );
	ok exists $x{foo};
	ok exists $x{bar};
	is 0+keys %x, 2;
	is 0+@y, 2;
	is \$x{foo}, \$y[0];
	is \$x{bar}, \$y[1];

	alias my @z = map $_, @y;
	isnt \@z, \@y;
	is 0+@z, 2;
	is \$x{foo}, \$z[0];
	is \$x{bar}, \$z[1];
}

{
	my %x;
	alias my @z = map { $_ ? ($_->{foo}, $_->{bar}) : () } undef, \%x, undef;
	ok exists $x{foo};
	ok exists $x{bar};
	is 0+keys %x, 2;
	is 0+@z, 2;
	is \$x{foo}, \$z[0];
	is \$x{bar}, \$z[1];
}

{
	alias my @x = map { $_, $_ } "${\''}", "${\''}";
	is 0+@x, 4;
	SKIP: {
		skip "perl issue #78194", 1  if $] < 5.0190003;
		is \$x[0], \$x[1];
	}
	is \$x[2], \$x[3];
}

# TODO tests involving 'my $_' on perl versions that support it?
# Relevant:
#	https://github.com/Perl/perl5/commit/7cc47870397e

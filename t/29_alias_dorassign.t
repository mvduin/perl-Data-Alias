#!/usr/bin/perl -w

use strict;
use warnings qw( FATAL all NONFATAL void );
use lib 'lib';
use Test::More;

BEGIN {
	if (eval 'my $x //= 42') {
		plan tests => 12;
	} else {
		plan skip_all => "//= not supported in this perl version";
	}
}

use Data::Alias;

our $U;
our $E = "";
our $Z = 0;

our $x;
our $rx = \$x;

is \alias($x //= $U), \$U;
is \$x, \$U;

is \alias($x //= $E), \$E;
is \$x, \$E;

is \alias($x //= $Z), \$E;
is \$x, \$E;

is \alias($x = $$rx), $rx;
is \$x, $rx;

is \alias($x //= $Z), \$Z;
is \$x, \$Z;

is \alias($x //= $E), \$Z;
is \$x, \$Z;

# vim: ft=perl

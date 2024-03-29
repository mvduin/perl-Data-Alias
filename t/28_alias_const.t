#!/usr/bin/perl -w

use strict;
use warnings qw( FATAL all NONFATAL void );
use lib 'lib';
use Test::More tests => 5;

use Data::Alias;

alias our $foo = "foo";
alias our $bar = $foo;

is \$foo, \$bar;

eval { $foo = 42 };
is $foo, "foo";

my @x;
for (0, 1) {
	alias $x[$_] = $_ + 1;
}

is $x[0], 1;
is $x[1], 2;

eval { $x[1] = 42 };
is $x[1], 2;

# vim: ft=perl

#!/usr/bin/env perl

use strict;
use warnings;

use Test::Tester;
use Test::Most;
#use Data::Dumper;

plan qw/no_plan/;

use JavaScript::V8x::TestMoreish;

my ($premature, @results);

($premature, @results) = run_tests sub { test_js( <<'_END_' ) };
diag( "Hello, World." );
areEqual( 1, 1 );
areEqual( 1, 2 );
like( "Hello, World.", /o, World/ )
like( "Hello, World.", /Alice/ )
_END_


is( scalar @results, 4 );
ok( $results[0]->{ok} );

ok( ! $results[1]->{ok} );
like( $results[1]->{diag}, qr/Value is not equal/ );

ok( $results[2]->{ok} );

ok( ! $results[3]->{ok} );

#warn Dumper \@results;

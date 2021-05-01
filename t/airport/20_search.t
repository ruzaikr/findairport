#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Airport::Data;
use feature 'say';
use Data::Dump 'pp';
use_ok('Airport::Search'); # This should be the module you're testing

my $rah_airports = Airport::Data::parse_airports("t/data/airports1.csv");

my @tests = (
    {
        string => 'Air',
        is_word => 0,
        num_expected => 5,
    },
    {
        string => 'Air',
        is_word => 1,
        num_expected => 0,
    },
    {
        string => 'Airport',
        is_word => 1,
        num_expected => 5,
    },
    {
        string => 'Sydney',
        is_word => 0,
        num_expected => 1,
    },
    {
        string => 'Sydney',
        is_word => 1,
        num_expected => 1,
    },
);

foreach my $rh_test (@tests) {
    my $rah_search_res = Airport::Search::get_name_matching_airports(
        airports => $rah_airports,
        matching_string => $rh_test->{string},
        word => $rh_test->{is_word},
    );
    
    if ($rh_test->{string} eq "Air" && $rh_test->{is_word}) {
        say pp($rah_search_res);
    }

    is(ref($rah_search_res), 'ARRAY', "response is an arrayref");

    my $string_word = "string";
    if ($rh_test->{is_word}) {
        $string_word = "word";
    }

    ok(scalar(@$rah_search_res) == $rh_test->{num_expected},
        qq/a $string_word matching $rh_test->{string} gets an arrayref of $rh_test->{num_expected} elements/);
}

done_testing;


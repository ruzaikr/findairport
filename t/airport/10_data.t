#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use feature 'say';
use Data::Dump 'pp';
use Data::Types 'is_float';
use_ok('Airport::Data'); # This should be the module you're testing

my $rah_airports = Airport::Data::parse_airports("t/data/airports1.csv");

is(ref $rah_airports, 'ARRAY', 'parse_airports returns the correct type');
is(scalar(@$rah_airports), 5, 'the arrayref which is returned has the correct number of elements');

map {
    is(ref $_, 'HASH', 'element of the array is a hash reference');
    
    #each hash reference has keys for id, name, latitude_deg, longitude_deg, iata_code with values as nonempty strings.
    
    ok(exists $_->{id}, 'hash reference has key for id');
    ok(exists $_->{name}, 'hash reference has key for name');
    ok(exists $_->{latitude_deg}, 'hash reference has key for latitude_deg');
    ok(exists $_->{longitude_deg}, 'hash reference has key for longitude_deg');
    ok(exists $_->{iata_code}, 'hash reference has key for iata_code');
    
    isnt($_->{id}, '', 'has a id');
    isnt($_->{name}, '', 'has a name');
    isnt($_->{latitude_deg}, '', 'has a latitude_deg');
    isnt($_->{longitude_deg}, '', 'has a longitude_deg');
    isnt($_->{iata_code}, '', 'has a iata_code');
    
    ok(is_float($_->{latitude_deg}), ' latitude_deg is floating point');
    ok(is_float($_->{longitude_deg}), ' longitude_deg is floating point');
    
    
    } @$rah_airports;




done_testing;

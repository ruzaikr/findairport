#!/usr/bin/perl

use strict;
use warnings;
use Text::CSV;

sub parse_airports {
    my $fh_in;
    my $infile = shift;
    open ($fh_in, "<:encoding(utf8)", $infile) or die "Error opening input file: $!";
    my $csv = Text::CSV->new( { binary => 1, eol => $/ } );
    my $ra_colnames = $csv->getline($fh_in);
    $csv->column_names(@$ra_colnames);
    my @airports;
    while (my $rh_line = $csv->getline_hr($fh_in) ) {
        push(@airports, $rh_line);
    }
    return \@airports;
}

sub get_name_matching_airports {
    my %params = @_;

    my @matching_airports;
    foreach my $airport (@{$params{airports}}) {
        if ($params{word}) {
            if ($airport->{name} =~ m/\w$params{matching_string}\W/i) {
                push(@matching_airports, $airport);
                say pp($airport);
            }
        }else {
            if ($airport->{name} =~ m/$params{matching_string}/i) {
                push(@matching_airports, $airport);
                say pp($airport);
            }
        }
    }

    return \@matching_airports;
}

1;
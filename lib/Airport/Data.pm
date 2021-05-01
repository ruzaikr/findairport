#!/usr/bin/perl
package Airport::Data;

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

1;
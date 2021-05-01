package Airport::Search;
use strict;
use warnings;

sub get_name_matching_airports {
    my %params = @_;

    my @matching_airports;
    foreach my $airport (@{$params{airports}}) {
        if ($params{word}) {
            if ($airport->{name} =~ m/\W$params{matching_string}\W/i) {
                push(@matching_airports, $airport);
            }
        }else {
            if ($airport->{name} =~ m/$params{matching_string}/i) {
                push(@matching_airports, $airport);
            }
        }
    }

    return \@matching_airports;
}

1;

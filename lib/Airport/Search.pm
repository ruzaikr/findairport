package Airport::Search;
use strict;
use warnings;
use List::Util 'min';

sub get_name_matching_airports {
    my %params = @_;

    my @matching_airports;
    foreach my $airport (@{$params{airports}}) {
        if ($params{word}) {
            if ($airport->{name} =~ m/\b$params{matching_string}\b/i) {
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

sub getDistance {
    my ($lat1, $long1, $lat2, $long2) = @_;
    # Very rough distance in degrees
    my $dist = sqrt(abs($lat1 - $lat2)**2 + (min(abs($long1 - $long2), abs(360 - abs($long1 - $long2))))**2);
    return $dist;
}

sub get_latlong_matching_airports {
    my %params = @_;

    my @airports = @{$params{airports}};
    my $lat = $params{lat};
    my $long = $params{long};
    my $max = $params{max};

    my @matching_airports;
    foreach my $airport (@{$params{airports}}) {
        my $distance_from_airport = getDistance($lat, $long, $airport->{latitude_deg}, $airport->{longitude_deg});
        if ($distance_from_airport < $max) {
            push(@matching_airports, $airport);
        }
    }

    return \@matching_airports;
}

1;

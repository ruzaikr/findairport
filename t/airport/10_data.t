#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use_ok('Airport::Data');
# Essentially the same as:
#     use Airport::Data;
# but outputting:
#     ok 1 - use Airport::Data;
# to indicate that the module loaded successfully.


ok(1, 'non zero is good ');
#ok(0, 'zero is bad');

done_testing();
# Note, without done_testing at the end
# it will suspect the test script died part way through.
#!/usr/bin/env perl
#vim:ft=perl

use 5.006;
use strict;
use Test::More;
use Geo::Privacy qw( is_eea_state is_gdpr_state is_eu_state has_data_retention_regulations );

# Implementation here

my %tests = (
    US => { eu => 0, gdpr => 0, eea => 0, privacy => 0 },
    ca => { eu => 0, gdpr => 0, eea => 0, privacy => 1 },
    cH => { eu => 0, gdpr => 0, eea => 1, privacy => 1 },
    Es => { eu => 1, gdpr => 1, eea => 1, privacy => 1 },
);

foreach my $cc ( sort keys %tests ) {
    ok ( !( $tests{$cc}{eu} xor is_eu_state($cc)), "$cc: eu_state?" );
    ok ( !( $tests{$cc}{gdpr} xor is_gdpr_state($cc)), "$cc: gdpr_state?" );
    ok ( !( $tests{$cc}{eea} xor is_eea_state($cc)), "$cc: eea_state?" );
    ok ( !( $tests{$cc}{privacy} xor has_data_retention_regulations($cc)), "$cc: data_retention?" );
}

done_testing;


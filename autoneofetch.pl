#!/usr/bin/env perl
# spectrevert@github.com
#
# Display neofetch only if no other term is open
#

our $DEFAULT_TERM = "bash";


sub check {

    my $term = shift;
    my @lines = split (/\n/, `ps -e | grep $term`);
    my $count = 0;

    for my $line (@lines) {
        if ($line =~ /[0-9]+.$term$/) {
            $count += 1;
        }
    }

    if ($count <= 2) {
        system ("neofetch");
    }
}

sub main {
    
    my $term = $DEFAULT_TERM;

    if (scalar @ARGV == 1 and $ARGV[0] eq "-h") {
        print "Usage:\t./$0 [term]\nterm:\t\tspecify terminal to be used [default: bash]";
    } elsif (scalar @ARGV == 1) {
        $term = $ARGV[0];
    }

    return check $term;
}

exit &main;

#!/usr/bin/env perl
# spectrevert@github.com
#
# Display neofetch only if no other term is open
#

our $DEFAULT_TERM = "bash";


sub check {

    my $shell = shift;
    my @lines = split (/\n/, `ps -e | grep $shell`);
    my $count = 0;

    for my $line (@lines) {
        if ($line =~ /[0-9]+.$shell$/) {
            $count += 1;
        }
    }

    if ($count <= 2) {
        system ("neofetch");
    }
}

sub usage {
    print STDERR << 'EOF';
USAGE:
    ./autoneofetch.pl [shell]

OPTION:
    shell   name of shell to use. Default: 'bash'
EOF
    return 0;
}

sub main {
    
    my $term = $DEFAULT_TERM;

    if (scalar @ARGV == 1
    and ($ARGV[0] eq "-h" or $ARGV[0] == "--help")) {
        print usage and exit 0;
    } elsif (scalar @ARGV == 1) {
        $term = $ARGV[0];
    }

    return check $term;
}

exit &main;

#!/usr/bin/env perl
# spectrevert@github.com
#
# Display neofetch only if no other term is open
#

our $DEFAULT_SHELL= "bash";

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
    
    my $shell = $DEFAULT_SHELL;

    if (scalar @ARGV == 1
    and ($ARGV[0] eq "-h" or $ARGV[0] == "--help")) {
        print usage and exit 0;
    } elsif (scalar @ARGV == 1) {
        $shell = $ARGV[0];
    }

    return check $shell;
}

exit &main;

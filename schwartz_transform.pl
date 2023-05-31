## This is a Perl script to reverse sort edgeR DE output according to natural number values ##
## Makes use of the Schwartzian transformation ##

use lib '/home/iasonas/perl5/lib/perl5/';
use strict;
use warnings;
use Sort::Versions;

open ( IN, $ARGV[0] );

my @lines = ();
my @up = ();
my @down = ();

while ( my $line = <IN> ) {
    chomp $line;

    if ( $. == 1 ) { print "$line\n"; next; }
    
    my @f = split (/\t/,$line);

    if ( $f[3] > 0 ) { 
        push (@up, $line);
    }

    if ( $f[3] < 0 ) { 
        push (@down, $line);
    }
}

print "Upregulated\n";
foreach ( schwartz(@up) ) {
    print "$_\n";
}

print "Downregulated\n";

foreach ( schwartz(@down) ) {
    print "$_\n";
}


sub schwartz {
    my @unsorted = @_;

    return my @sorted = map { $_->[0] }
                        sort { versioncmp ($b->[1],$a->[1]) }
                        map { my @f = split(/\t/,$_); [$_,$f[3]] } @unsorted;
}

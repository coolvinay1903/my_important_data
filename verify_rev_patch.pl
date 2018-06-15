#!/usr/bin/perl -w
my $filename = "";
if (defined $ARGV[0]) {
    $filename = $ARGV[0];
} else {
    $filename = "rtlcommit.diff";
}
print "## Run patch -R -p0 -i $filename to reverse the patch\n";
open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
my $file="";
my $rev="";
while (my $row = <$fh>) {
    #Index: CmdLine/src/cmdLine.cc
    #retrieving revision 1.121.2.64.2.68.2.385.2.26
    if ($row =~/Index:\s+(\S+)/) {
        $file = $1;
    } elsif ($row =~/retrieving revision\s+(\S+)/) {
        $rev = $1;
    }
    if ( $rev ne "") {
        print "cvs -q diff -u -r $rev $file\n";
        $file="";
        $rev="";
    }
}

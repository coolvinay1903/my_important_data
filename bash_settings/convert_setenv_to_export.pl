#!/usr/bin/perl -w
my $filename = $ARGV[0];
my $ofilename = "$filename.sh";
print "file = $filename\n";
print "Out file = $ofilename\n";
open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
open(my $ofh, '>', $ofilename) or die "Could not open file '$ofilename' $!";
my $from_alias=0;
while (my $row = <$fh>) {
    chomp $row;
    my @split_args = split ('\s+', $row);
    my $rep_str = "";
    my $inside_if=0;
    my $inside_if_cond=0;
    my $inside_set=0;
    my $path_count=0;
    my $trying_to_set_path=0;
    my $skip_space=0;
    for (my $i =0; $i <= $#split_args; $i++) {
        #print "arg = $split_args[$i]\n";
        my $curr_arg = $split_args[$i];
        #print "current_arg = $curr_arg\n";
        if ( $curr_arg eq "#!/bin/csh" ) {
            $curr_arg = "#!/bin/bash";
            $rep_str="${rep_str} $curr_arg";
        } elsif ( $curr_arg eq "set") {
            $inside_set=1;
            $skip_space=1;
            $curr_arg="";
            $rep_str="${rep_str}$curr_arg";
       } elsif ( $inside_set && $curr_arg eq "path") {
            $trying_to_set_path=1;
            $path_count=0;
            $curr_arg = "export PATH";
            $rep_str="${rep_str}$curr_arg";
        } elsif ( $inside_set && $skip_space) {
            if ( $curr_arg eq "=" ) {
                $skip_space = 0;
            }
            $rep_str="${rep_str}$curr_arg";
        } elsif ( $trying_to_set_path) {
            if ( $curr_arg eq "(" || $curr_arg eq ")") {
                $curr_arg = "";
                $path_count=0;
            } elsif ( $curr_arg eq "\$path") {
                if ( $path_count != 0) {
                #Assume that this is the last entry
                    $curr_arg = ":\$PATH";
                } else {
                    $curr_arg = "\$PATH:";
                }
                $path_count++;
            } else {
                if ( $path_count == 0 ) {
                    $curr_arg = "$curr_arg";
                } else {
                    $curr_arg = "$curr_arg:";
                }
                $path_count++;
            }
            print "current_arg = $curr_arg\n";
            $rep_str="${rep_str}$curr_arg";
        }
        elsif ( $curr_arg eq "if" ) {
            $inside_if++;;
            $rep_str="${rep_str} $curr_arg";
        } elsif ( $curr_arg eq "endif" ) {
            $inside_if--;
            $rep_str="${rep_str} fi";
        } elsif ( $curr_arg eq "endsw" ) {
            $rep_str="${rep_str} esac";
        } elsif ( $inside_if && $curr_arg =~/\(/ ) {
            $inside_if_cond = 1;
            $curr_arg=~s/\(/ \[[ / ;
            $curr_arg=~s/\)/ \]] / ;
            $rep_str="${rep_str} $curr_arg";
        } elsif  ( $inside_if && $inside_if_cond && $curr_arg =~/\)/ ) {
            $curr_arg=~s/\)/ \]] /;
            $rep_str="${rep_str} $curr_arg";
        } elsif ( $inside_if && $inside_if_cond && $curr_arg eq "then" ) {
            $inside_if_cond = 0;
            $curr_arg="; then";
            $rep_str="${rep_str} $curr_arg";
        } elsif ( $curr_arg eq "alias" ) {
            if ( $i+1 <= $#split_args) {
                $rep_str = "$rep_str alias $split_args[($i+1)]=";
                $i++;
                $from_alias=1;
            } else {
                $rep_str = "$rep_str $curr_arg";
            }
        } elsif ( $curr_arg eq "unsetenv" ) {
            $rep_str = "${rep_str}unset"
        } elsif ( $curr_arg eq "'setenv" ) {
            $rep_str = "${rep_str}'export $split_args[($i+1)]=$split_args[($i+2)]";
            $i = $i+2;
        } elsif  ( $curr_arg eq "setenv" ) {
            $rep_str = "$rep_str export $split_args[($i+1)]=$split_args[($i+2)]";
            $i = $i+2;
        } else {
            if ($from_alias) {
                $rep_str="${rep_str}$curr_arg";
                $from_alias=0;
            } elsif ( $i == 0) {
                $rep_str="${rep_str}$curr_arg";
            } else {
                $rep_str="${rep_str} $curr_arg";
            }
        }
    }
    print $ofh "$rep_str\n";
}


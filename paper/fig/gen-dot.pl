#!/usr/bin/perl -w

use strict ;

my $prolog = "digraph Neural{\n" ;
my $epilog = "}\n" ;

print $prolog ;
my $curnode = -1 ;
my $curmode = "NULL" ;
while(<STDIN>){
	if ( /^Sigmoid Node (\d+)/ ){
		$curnode = "n$1" ;	
		next ;
	} elsif ( /^    Inputs    Weight/ ){
		#nothing	
	} elsif ( /^    Threshold    (.+)$/) {
		print "$curnode [label=\"$curnode:T=$1\"]\n" ;
	#} elsif ( /^    Node (\d+)    (.+)$/) {
	} elsif ( /^    Node (\d+)(.*)$/) {
		print "n$1 -> $curnode [label=\"$2\"]\n" ;	
	} elsif ( /^Class (\d+)/ ){
		$curnode = "c$1" ;
	} elsif ( /^    Attrib (.+)    (.+)/ ){
		print "$1 -> $curnode [label=\"$2\"]\n" ;	
	}
}	
print $epilog ;

exit 0 ;

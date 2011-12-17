#!/usr/bin/perl -w 
#hupili
#20111217

#draw the roc curve for single features. 

use strict ;
use List::Util "sum" ;

my $usage = "$0 {fn_node} {fn_feature}" ;
#fn_node is the 'node' file in raw data, 
#or compliant format
#
#fn_feature is the temporary feature file outputed 
#by all proximity-xxxx series, in the format:
#<NodeID> '\t' <Proximity>

#the ROC curve here is constructed by 
#varying the proximity threshold

my $ARGC = @ARGV ;
($ARGC == 2) or die("usage:$usage\n") ;
my ($fn_node, $fn_feature) = @ARGV ;

my $count = 0 ;
my $count_t = 0 ;
my $count_f = 0 ;
my %h_node = () ;
my @a_node = `cat $fn_node` ;
for my $line(@a_node){
	chomp($line) ;
	my @a_line = split "\t", $line;
	$h_node{$a_line[0]}->{"label"} = $a_line[1] ;
	$h_node{$a_line[0]}->{"feature"} = -1 ;
	$count ++ ;
	if ( $a_line[1] == 1 ){
		$count_t ++ ;
	} else {
		$count_f ++ ;
	}
}

my @a_feature = `cat $fn_feature` ;
for my $line(@a_feature){
	chomp($line) ;
	my @a_line = split "\t", $line;
	if ( defined ($h_node{$a_line[0]}) ){
		$h_node{$a_line[0]}->{"feature"} = $a_line[1] ;
	}
}

my @a_keys = sort {
	$h_node{$a}->{"feature"} <=> 
	$h_node{$b}->{"feature"}
} keys %h_node ;

my $t = -2 ;
my $tp = $count_t ;
my $fp = 0 ;

for (my $i = 0 ; $i < $count ; $i ++){
	if ( $t < $h_node{$a_keys[$i]}->{"feature"} ){			
		print join("\t", $t, $tp / $count_t, $fp / $count_f), "\n" ;
	}
	$t = $h_node{$a_keys[$i]}->{"feature"} ;
	if ( $h_node{$a_keys[$i]}->{"label"} == 1 ){
		$tp -- ;	
	} else {
		$fp ++ ;	
	}
}
print join("\t", $t, $tp / $count_t, $fp / $count_f), "\n" ;

exit 0 ;

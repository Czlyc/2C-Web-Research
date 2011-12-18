#!/usr/bin/perl -w 
#hupili
#20111217

#draw the roc curve for single features. 

use strict ;
use List::Util "sum" ;
use Data::Dumper ;

my $usage = "$0 {dir_raw} {fn_feature}" ;
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
my ($dir_raw, $fn_feature) = @ARGV ;

my $count = 0 ;
my $count_t = 0 ;
my $count_f = 0 ;
my %h_node = () ;
my @a_node = `cat $dir_raw/training $dir_raw/testing` ;
for my $line(@a_node){
	chomp($line) ;
	my @a_line = split "\t", $line;
	if ( scalar @a_line == 2 ){
		$h_node{$a_line[0]}->{"label"} = $a_line[1] ;
		$h_node{$a_line[0]}->{"feature"} = -1 ;
	} else {
		print STDERR "node information column error\n" ;
		exit -1 ;	
	}
}

my @a_feature = `cat $fn_feature` ;
for my $line(@a_feature){
	chomp($line) ;
	my @a_line = split "\t", $line;
	if ( scalar @a_line == 2 ){
		if ( defined ($h_node{$a_line[0]}) ){
			$h_node{$a_line[0]}->{"feature"} = $a_line[1] ;
		}
	} else {
		print STDERR "feature length error\n" ;
		exit -1 ;
	}
}

my @a_keys = sort {
	$h_node{$a}->{"feature"} <=> 
	$h_node{$b}->{"feature"}
} keys %h_node ;

#print Dumper(@h_node{@a_keys}) ;
#exit 0 ;

for my $key(@a_keys){
	$count ++ ;
	my $label = $h_node{$key}->{"label"} ;
	if ( $label == 1 ){
		$count_t ++ ;
	} else {
		$count_f ++ ;
	}
}

print STDERR "count_t:$count_t; count_f:$count_f\n" ;

my $t = -2 ;
my $tp = $count_t ;
my $fp = $count_f ;

my $id = 0 ;

for (my $i = 0 ; $i < $count ; $i ++){
	if ( $t < $h_node{$a_keys[$i]}->{"feature"} ){			
		print join("\t", $id, $t, $tp / $count_t, $fp / $count_f), "\n" ;
	}
	$t = $h_node{$a_keys[$i]}->{"feature"} ;
	if ( ! defined($t) ){
		print STDERR "t, undefined value..\n" ;
		exit -1 ;
	}
	if ( $h_node{$a_keys[$i]}->{"label"} == 1 ){
		$tp -- ;	
	} else {
		$fp -- ;	
	}
	$id ++ ;
}
print join("\t", $id, $t, $tp / $count_t, $fp / $count_f), "\n" ;

exit 0 ;

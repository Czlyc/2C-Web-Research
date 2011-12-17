#!/usr/bin/perl -w
#hupili
#20111217

use strict ;
use Data::Dumper ;

#merge features and generate weka's artf format file

my $usage = "$0 {dir_raw} [fn_feature1 fn_feature2 ...]" ;

my $ARGC = @ARGV ;
($ARGC >= 1) or die("usage:$usage\n") ;

my ($dir_raw, @fn_features) = @ARGV ;

if ( ! -e $dir_raw ) {
	print STDERR "can not find feature file:$dir_raw\n" ;
}

my %h_attr = () ;
my @a_attr_name = () ;

my @a_input = `cat $dir_raw/node` ;
for my $line(@a_input){
	chomp($line) ;
	my @a_line = split "\t", $line ;
	$h_attr{$a_line[0]}->{"institute"} = $a_line[1] ;
}

for my $fn(@fn_features){
	#the attribute name used in artf file 
	my $name = $fn ;
	$name =~ s/tmp\///g ;
	$name =~ s/\./_/g ;
	push @a_attr_name, $name ;

	if ( ! -e $fn ) {
		print STDERR "can not find feature file:$fn\n" ;
	}
	my @a_input = `cat $fn` ;
	for my $line(@a_input){
		chomp($line) ;
		my @a_line = split "\t", $line ;
		if ( defined($h_attr{$a_line[0]}) ){
			$h_attr{$a_line[0]}->{$name} = $a_line[1] ;
		}
	}
}

my $header = "" ;

$header .= '@relation data' . "\n" ;
$header .= "\n" ;
for my $n(@a_attr_name){
	$header .= "\@attribute $n numeric\n" ;
}
$header .= "\@attribute class {1,0}\n" ;
$header .= "\n" ;
$header .= '@data' . "\n" ;
$header .= "\n" ;

#push label 
push @a_attr_name, "class" ;


#print "@a_attr_name\n" ;
#print "$header\n" ;
#print Dumper(\%h_attr) ;
#exit 0 ;

for my $set("training", "testing"){
	my @a_input = `cat $dir_raw/$set` ;
	open f_order, "> $dir_raw/$set.order" ;
	open f_set, "> $dir_raw/$set.arff" ;
	print f_set $header ;
	for my $line(@a_input){
		chomp($line) ;
		my @a_line = split "\t", $line ;
		if ( defined($h_attr{$a_line[0]}) ){
			$h_attr{$a_line[0]}->{"class"} = $a_line[1] ;
			my %tmp_attr = %{$h_attr{$a_line[0]}} ;
			#print "@a_attr_name\n" ;
			#print Dumper(\%tmp_attr) ;
			print f_set join(",", (@tmp_attr{@a_attr_name})), "\n" ;
			print f_order $a_line[0], "\n" ;
		}
	}
	close f_set ;
	close f_order ;
	#for my $node (keys %h_attr){
	#	my $ref_attr = $h_attr{$node} ;
	#	print f_set join(",", $ref_attr->{@a_attr_name}), "\n" ;
	#}
}

exit 0 ;

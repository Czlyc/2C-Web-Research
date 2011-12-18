#!/usr/bin/perl -w
#hupili
#20111217

#filter node according to a dict
#only nodes in the dict are kept in output directory

use strict ;
use Data::Dumper ;

my $usage = "$0 {dir_raw} {dir_output} {fn_dict}" ;

my $ARGC = @ARGV ;
($ARGC == 3) or die("usage:$usage\n") ;
my ($dir_raw, $dir_output, $fn_dict) = @ARGV ;

if ( ! -d $dir_raw ){
	print STDERR "raw dir not exists: $dir_raw\n" ;
	exit -1 ;
}

#if ( -e $dir_output ){
#	print STDERR "output dir already exists: $dir_output\n" ;
#	exit -1 ;
#}

if ( ! -e $fn_dict ){
	print STDERR "dict not exists: $fn_dict\n" ;
	exit -1 ;
}

my %h_dict = () ;
my @a_dict = `cat $fn_dict` ;
for my $line(@a_dict){
	chomp($line) ;
	$h_dict{$line} = 1 ;
}

#print Dumper \%h_dict ;

`mkdir -p $dir_output` ;
for my $file(`ls -1 $dir_raw | grep .arff`){
	chomp($file) ;
	my $arff = "$dir_raw/$file" ;	
	my $order = $arff ;
	$order =~ s/arff/order/g ;
	open f_in, "<$arff" ;
	open f_out, ">$dir_output/$file" ;
	#get order
	my @a_order = `cat $order` ;
	#header
	while ( my $line = <f_in> ){
		print f_out $line ;
		chomp($line) ;
		if ( $line =~ /\@data/ ){
			#print STDERR "filtering head finish\n" ;
			last ;	
		}
	}
	my $line = <f_in> ;
	print f_out $line ;
	#data body 
	my $index = 0 ;
	while ( my $line = <f_in> ){
		my $node = $a_order[$index] ;
		chomp($node) ;
		if ( defined($h_dict{$node}) ){
			#print $node, "\n" ;
			print f_out $line ;	
		}	
		$index ++ ;
	}
	close f_out ;
	close f_in ;
}

exit 0 ;

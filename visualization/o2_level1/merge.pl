#!/usr/bin/perl 


my @a_node = `cat node` ;
my %h_node = () ;
for my $line(@a_node){
	chomp($line) ;
	my @a_line = split "\t", $line ;
	$h_node{$a_line[0]} = $a_line[1] ;
}

my @a_dict = `cat dict` ;
my %h_dict = () ;
for my $line(@a_dict){
	chomp($line) ;
	$h_dict{$line} = 1 ;
}

my @a_link = `cat link` ;
for my $line(@a_link){
	chomp($line) ;
	my @a_line = split "\t", $line ;
	if ( exists($h_dict{$a_line[0]})
		&& exists($h_dict{$a_line[1]}) ){
		print join("\t",
			$a_line[0], 
			$h_node{$a_line[0]}, 
			$a_line[1], 
			$h_node{$a_line[1]}), "\n" ;
	}
}

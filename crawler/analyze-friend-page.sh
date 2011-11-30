#!/bin/bash

if [[ $# == 1 ]] ; then
	input=$1
else 
	echo "$0 {input_file}"
	exit 255
fi

perl -e 'while(<>){if(m/\(第(\d+)\/(\d+)页\)/){print $2;}}' $input

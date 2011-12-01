#!/bin/bash

. ./conf.sh

if [[ $# == 1 ]] ; then
	input=$1
else 
	echo "$0 {input_file}"
	exit 255
fi

sed 's/div class="list">/\n/g' $input | tail -n1 | sed 's/<div class="l">/\n/g' | head -n1 | sed -e 's/<\//\n/g' -e 's/</\n/g' > $tmp/raw

grep 'span class="gray">' $tmp/raw | sed 's/span class="gray">//g' > $tmp/university
perl -e 'while(<>){if($_=~/a href=.*?&amp;id=(\d+).*?>(.+)$/){print "$1\t$2\n";}}' $tmp/raw  > $tmp/id_name
paste tmp/id_name tmp/university


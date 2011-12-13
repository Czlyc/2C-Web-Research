#!/bin/bash
#hupili
#20111213

#generate escape vector

#a all one version

mkdir -p tmp

if [[ $# == 1 ]] ; then 
	dir_raw=$1
else
	echo "$0 {raw_dir}"
	exit 255
fi

link="$dir_raw/link"
cut -f1 $link > tmp/link.f1
cut -f2 $link > tmp/link.f2
cat tmp/link.f* | sort -u > tmp/node.sortu
awk 'BEGIN{OFS="\t"}{print $1, 1}' tmp/node.sortu 

exit 0 

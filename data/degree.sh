#!/bin/bash


mkdir -p tmp/

for i in `ls -1 raw`
do
	echo $i 
	dir="raw/$i"
	awk '{d[$1]++;d[$2]++}END{OFS="\t";for(i in d){print i, d[i]}}' $dir/link > $dir/degree
	#break
done

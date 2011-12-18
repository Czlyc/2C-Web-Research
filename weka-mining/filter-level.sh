#!/bin/bash

#filter node according to level 1 or level 2

#only level 1 nodes are kept

dir_output_base="filtered.level"
rm -rf $dir_output_base
mkdir -p $dir_output_base

dir_raw_all="../data/raw"
for raw in `ls -1 $dir_raw_all`
do
	dir_raw="$dir_raw_all/$raw"
	dir_output="$dir_output_base/$raw"
	mkdir -p $dir_output
	#awk -F"\t" '{if($2>2){print $1}}' $dir_raw/degree > $dir_output/dict
	rootid=`echo -n \`cat $dir_raw/rootid\``
	grep "^$rootid" $dir_raw/link | cut -f2 > $dir_output/dict
	./filter-node.pl $dir_raw $dir_output $dir_output/dict
done

exit 0

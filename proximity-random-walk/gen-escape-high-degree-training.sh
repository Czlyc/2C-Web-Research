#!/bin/bash
#hupili
#20111213

#generate escape vector

#set the x highest degree nodes in training set to 1
#together with the root node. 
#other nodes are 0

x=5
#important, or there may be some problem when sorting
export LC_ALL="C"

mkdir -p tmp

if [[ $# == 1 ]] ; then 
	dir_raw=$1
else
	echo "$0 {raw_dir}"
	exit 255
fi

rootid=`echo -n \`cat $dir_raw/rootid\``
echo "$rootid	1"

link="$dir_raw/link"

sort -k1 $dir_raw/degree > tmp/degree.sortid
sort -k1 $dir_raw/training > tmp/training.sortid
join tmp/degree.sortid tmp/training.sortid > tmp/node_degree_label
awk '{if($3==1){OFS="\t";print $1,$2}}' tmp/node_degree_label > tmp/node_degree.positive
sort -k2 -n tmp/node_degree.positive | tail -n $x > tmp/top
awk -F"\t" '{OFS="\t";print $1,1}' tmp/top


exit 0 

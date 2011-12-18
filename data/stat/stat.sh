#!/bin/bash

#collect statistics. 

if [[ $# == 1 ]] ; then
	dir_raw=$1
else
	echo "$0 {raw_dir}"
	exit 255
fi

rootid=`echo -n \`cat $dir_raw/rootid \``
num_all_node=`echo -n \`wc -l $dir_raw/node | awk '{print $1}'\``
num_l1_node=`echo -n \`grep "^$rootid" $dir_raw/link | cut -f2 | sort -u | wc -l | awk '{print $1}'\``
num_link=`echo -n \`wc -l $dir_raw/link | awk '{print $1}'\``
observer=`echo $dir_raw | grep -o -P '\d\/?$'`

echo "$observer	$num_all_node	$num_l1_node	$num_link"


exit 0 

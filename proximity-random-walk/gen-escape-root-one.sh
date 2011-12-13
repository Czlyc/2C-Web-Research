#!/bin/bash
#hupili
#20111213

#generate escape vector

#only root node(observer) is set to 1

mkdir -p tmp

if [[ $# == 1 ]] ; then 
	dir_raw=$1
else
	echo "$0 {raw_dir}"
	exit 255
fi

rootid=`echo -n \`cat $dir_raw/rootid\``
echo "$rootid	1"

exit 0 

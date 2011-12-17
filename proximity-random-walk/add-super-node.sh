#!/bin/bash
#hupili
#20111213

#add super node, x
#add edge x --> i, for all node i and vice versa

mkdir -p tmp

if [[ $# == 1 ]] ; then 
	dir_raw=$1
else
	echo "$0 {raw_dir}"
	exit 255
fi

link="$dir_raw/link"

#cat $link > tmp/link
#cut -f1 tmp/link > tmp/link.f1
#cut -f2 tmp/link > tmp/link.f2
#cat tmp/link.f* | sort -u > tmp/node.sortu
#node_num=`echo -n \`wc -l tmp/node.sortu | awk '{print $1}'\``

node_num=`echo -n \`wc -l $dir_raw/node | awk '{print $1}'\``

#original edges
cat $link
#super node edges
awk -F"\t" "BEGIN{OFS=\"\t\"}{print \$1, $node_num; print $node_num, \$1}" $dir_raw/node

exit 0 

#!/bin/bash
#hupili
#20111213

#divide nodes into two sets, training set and testing set

mkdir -p tmp/

for i in `ls -1 raw`
do
	echo $i 
	dir="raw/$i"
	rootid=`echo -n \`cat $dir/rootid\``
	echo "rootid:$rootid"
	rootlabel=`echo -n \` grep "^$rootid" $dir/node | awk '{print $2}' \``
	echo "rootlabel:$rootlabel"
	line=`wc -l $dir/node | awk '{print $1}'`
	line=`echo -n "$line"`
	training=`expr $line / 2`
	testing=`expr $line - $training`
	echo "line:$line, training:$training, testing:$testing"
	sort -R $dir/node > tmp/node.rnd
	head -n $training tmp/node.rnd | awk -F"\t" "BEGIN{OFS=\"\t\"}{if(\$2==$rootlabel){print \$1,1}else{print \$1,0}}" > $dir/training
	tail -n $testing tmp/node.rnd | awk -F"\t" "BEGIN{OFS=\"\t\"}{if(\$2==$rootlabel){print \$1,1}else{print \$1,0}}" > $dir/testing
	#break
done

#!/bin/bash
#hupili
#20111212

# test the pagerank module

for i in `ls -1 testcase`
do
	echo "----begin test $i"
	path="testcase/$i"
	a=`echo -n \`cat $path/alpha\``
	ulimit -c unlimited 
	./pagerank $path/link $path/escape-vector $path/output $a 2> log~
	#echo ./pagerank $path/link $path/escape-vector $path/output `cat $path/alpha`
	if [[ -e $path/stdout ]] ; then
		diff $path/stdout $path/output
	fi
	echo "----end test $i"
done

exit 0 


#!/bin/bash
#hupili
#20111212

# test the pagerank module

for i in `ls -1 testcase`
do
	echo "----begin test $i"
	path="testcase/$i"
	./pagerank $path/link $path/escape-vector $path/output `cat $path/alpha`
	if [[ -e $path/stdout ]] ; then
		diff $path/stdout $path/output
	fi
	echo "----end test $i"
done

exit 0 


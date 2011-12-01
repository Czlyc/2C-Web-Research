#!/bin/bash
#get the first circle of my friend

if [[ $# == 2 ]] ; then
	id=$1
	total_page=$2
else
	echo "$0 {id} {total_page}"
	exit 255
fi

#output_file="data.friend1"

for ((page=0;page<$total_page;page=page+1)) do
	#echo $page
	./get-friend.sh $id $page
	ret=$?
	echo "[$0] page=$page ret=$ret" >> log
	#./analyze-friend.sh friend.html >> $output_file
	./analyze-friend.sh tmp/friend.html 
	delay=`expr $RANDOM % 4`
	sleep $delay
done

exit 0 

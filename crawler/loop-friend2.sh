#!/bin/bash
#get the second cycle

if [[ $# == 1 ]] ; then
	input=$1
else
	echo "$0 {input}"
	exit 255
fi

#output_file="data.friend1"

for id in `cut -f1 $input` 
do
	if [[ -e data.friend2/$id ]] ; then
		echo "[$0] skip $id" >> log
		continue
	fi
	./get-friend.sh $id 0
	total=`./analyze-friend-page.sh friend.html`
	echo "[$0] id=$id total=$total" >> log
	./loop-friend1.sh $id $total > data.friend2/$id
done

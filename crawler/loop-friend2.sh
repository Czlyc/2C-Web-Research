#!/bin/bash
#get the second cycle

. ./conf.sh

if [[ $# == 1 ]] ; then
	input=$1
else
	echo "$0 {input}"
	exit 255
fi

#output_file="data.friend1"

for id in `cut -f1 $input` 
do
	if [[ -e $data/data.friend2/$id ]] ; then
		echo "[$0] skip $id" >> log
		continue
	fi
	./get-friend.sh $id 0
	total=`./analyze-friend-page.sh $tmp/friend.html`
	echo "[$0] id=$id total=$total" >> log
	if [[ $_TEST == "1" ]] ; then
		#only download 1 page for test
		./loop-friend1.sh $id 1 > $data/data.friend2/$id
	else
		./loop-friend1.sh $id $total > $data/data.friend2/$id
	fi
done

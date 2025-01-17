#!/bin/bash
#20111130
#hupili
#---
#the test version of 'run.sh'
#
#usage:
#   * please follow the 'Guide' or see 'run.sh'

. ./conf.sh
export _TEST=1

echo "[$0]===start===" >> log

rm -rf $tmp
mkdir -p $tmp
rm -rf $data
mkdir -p $data
mkdir -p $data/data.friend2

bash ./login.sh
ret=$?
if [[ $ret == 0 ]] ; then
	echo "[$0] login: success" >> log
else
	echo "[$0] login: $ret" >> log
	exit 255
fi

#myid=`echo -n \`bash ./analyze-myid.sh tmp/home.html\``
myid=`echo -n \`bash ./analyze-myid.sh\``
ret=$?
if [[ $ret == 0 ]] ; then
	echo "[$0] get myid: success" >> log
else
	echo "[$0] get myid: $ret" >> log
	exit 255
fi
echo $myid > $data/rootid

bash ./get-friend.sh $myid 0
total=`./analyze-friend-page.sh $tmp/friend.html`
if [[ $total > 2 ]] ; then
	cur=2
else
	cur=$total
fi
bash ./loop-friend1.sh $myid $cur | tail -n 2 > $data/data.friend1
echo "[$0] get level 1 list done" >> log

bash ./loop-friend2.sh $data/data.friend1

echo "[$0]===end===" >> log

exit 0 

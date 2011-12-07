#!/bin/bash
#20111130
#hupili
#---
#the uni-entry of this crawler
#
#usage:
#1. copy 'info/post.login.template' to 'info/post.login'
#2. modify 'post.login' using your own account
#3. issue command: bash ./test.sh
#4. check data files in 'data' directory against the 'Guide'
#5. issue command: nohup bash ./run.sh & 
#6. you can watch the progress using: tail -f log

. ./conf.sh

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
bash ./loop-friend1.sh $myid $total > $data/data.friend1
echo "[$0] get level 1 list done" >> log

bash ./loop-friend2.sh $data/data.friend1

echo "[$0]===end===" >> log

exit 0 

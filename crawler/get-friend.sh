#/bin/bash

. ./conf.sh

if [[ $# == 2 ]] ; then
	id=$1
	page=$2
else
	echo "usage: ./get-friend.sh {id} {page}"
	exit 255
fi

session_id=`awk '{if($6=="mt"){print $7}}' $tmp/cookies`
session_id=`echo -n $session_id`

#friend_url="http://3g.renren.com/getfriendlist.do?curpage=$page&id=$id&f=all&sid=$session_id"
friend_url="http://3g.renren.com/getfriendlist.do?curpage=$page&id=$id&f=all&sid=$session_id&stage="

user_agent=`echo -n \`cat $tmp/user-agent\``

wget $friend_url --user-agent="$user_agent" -O $tmp/friend.html --save-cookies="cookies" --load-cookies="cookies" --keep-session-cookies

ret=$?

exit $ret

#/bin/bash

if [[ $# == 1 ]] ; then
	id=$1
else
	echo "usage: ./get-latest.sh {id}"
	exit 255
fi

session_id=`awk '{if($6=="mt"){print $7}}' cookies`
session_id=`echo -n $session_id`

latest_url="http://3g.renren.com/footprint.do?id=$id&htf=739&fp=1&sid=$session_id"

user_agent=`echo -n \`cat user-agent\``

wget $latest_url --user-agent="$user_agent" -O latest.html --save-cookies="cookies" --load-cookies="cookies" --keep-session-cookies

#!/bin/bash
#hupili
#20111201
#---
#to obtain your ID easily

. ./conf.sh

#20111207
#interface upgraded. 
#no need to provide home page file. 
#this script will download home page itself. 
#make sure you logged in before run this script. 
#
#if [[ $# == 1 ]] ; then
#	home=$1
#else
#	echo "usage: $0 {fn_home}"
#	exit 255
#fi

home="$tmp/home.html"

session_id=`awk '{if($6=="mt"){print $7}}' $tmp/cookies`
session_id=`echo -n $session_id`
home_url="http://3g.renren.com/home.do?&sid=$session_id&htf=1"
user_agent=`echo -n \`cat $info/user-agent\``

wget "$home_url" --user-agent="$user_agent" -O $home --save-cookies="$tmp/cookies" --load-cookies="$tmp/cookies" --keep-session-cookies

id=`perl -e 'while(<>){(/http:\/\/3g.renren.com\/profile.do\?id=(\d+)/) && print "$1\n" }' $home | head -n1`

echo $id

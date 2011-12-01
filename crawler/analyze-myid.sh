#!/bin/bash
#hupili
#20111201
#---
#to obtain your ID easily

. ./conf.sh

if [[ $# == 1 ]] ; then
	home=$1
else
	echo "usage: $0 {fn_home}"
	exit 255
fi

id=`perl -e 'while(<>){(/http:\/\/3g.renren.com\/profile.do\?id=(\d+)/) && print "$1\n" }' $home | head -n1`

echo $id

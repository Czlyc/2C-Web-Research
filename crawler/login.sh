#!/bin/bash

. ./conf.sh

login_url=`echo -n \`cat $info/url.login\``
user_agent=`echo -n \`cat $info/user-agent\``

wget $login_url --user-agent="$user_agent" --post-file $info/post.login -O $tmp/home.html --save-cookies="$tmp/cookies" --keep-session-cookies


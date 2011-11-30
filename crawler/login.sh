#!/bin/bash

login_url=`echo -n \`cat url.login\``
user_agent=`echo -n \`cat user-agent\``

wget $login_url --user-agent="$user_agent" --post-file post.login -O home.html --save-cookies="cookies" --keep-session-cookies


#!/bin/bash

# Yadle username and password
username=""
password=""

# tag name
tag="favorite"

# API server url
api_url=""

# API app ID
app_id=""

# icon for notify-send messages
icon="${HOME}/yadle/plugins/logo.png"

# file id from Yadle
id=$1

# determine os
case $(uname) in
	Darwin)
		platform="darwin"
	;;

	Linux)
		platform="linux"
	;;
esac

# authenticate with API
auth=$(curl --silent \
	--request POST \
	--url ${api_url}/yadle/v2/auth/login \
	--header 'content-type: application/x-www-form-urlencoded' \
	--data 'username='${username}'&password='${password})

prop="password"
temp=`echo ${auth} | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
api_password=${temp##*|}

prop="token"
temp=`echo ${auth} | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $prop`
token=${temp##*|}

# add tag to file
curl -X PATCH \
--url "${api_url}/yadle/v2/file/${id}/tags" \
-H "Authorization: Bearer ${token}:${api_password}" \
-H "Content-Type: application/json" \
-H "x-app-id: ${app_id}" \
-d '{
    "'${tag}'": { 
    	"action": "add"
    }
}'

# send desktop[ message

if [[ ${platform} == "darwin" ]]; then
	osascript -e 'display notification "File ID: '${id}' tagged as #'${tag}' with title "Yadle"'

fi

if [[ ${platform} == "linux" ]]; then	
	notify-send -t 5000 -u normal -i ${icon} "File ID: '${id}' tagged as #'${tag}'"
fi

# EOF

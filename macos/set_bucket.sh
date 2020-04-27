#!/bin/bash

# this is the default bucket name
basebucket="${HOME}/Desktop/bucket_1"

# icon for notify-send messages
icon="${HOME}/yadle/plugins/logo.png"

# determine os
case $(uname) in
	Darwin)
		platform="darwin"
	;;

	Linux)
		platform="linux"
	;;
esac

# .../bucket.data contains the full path of the current bucket.  If not,
# then put the default from above in the file.
if [ ! -f "${HOME}/yadle/plugins/bucket1.data" ]; then echo "${basebucket}" > "${HOME}/yadle/plugins/bucket1.data"; fi

# get the bucket path from the file
bucket=$(< ~/yadle/plugins/bucket1.data)

if [[ ${platform} == "darwin" ]]; then
	# open file selector, start in current bucket
	dir=$(osascript -e 'set theOutputFolder to choose folder with prompt "Please select an output folder:"' -e 'set theOutputFolder to POSIX path of theOutputFolder')
	#dir=$(osascript -e 'set theOutputFolder to POSIX path of theOutputFolder'
	#echo ${dir}
fi


if [[ ${platform} == "linux" ]]; then
	# open file selector, start in current bucket
	dir=$(zenity --file-selection --directory ${bucket})
fi


if [[ ${platform} == "darwin" ]]; then
# if selected dir does not exists, no change
	if [ -z $dir ]; then
		osascript -e 'display notification "Bucket is still '${bucket}'" with title "Yadle"'
	else
		# set selected dir to be the dir in bucket.data file
		echo "${dir}" > "${HOME}/yadle/plugins/bucket1.data"

		# desktop notify message
		osascript -e 'display notification "Bucket set to '${dir}'" with title "Yadle"'
	fi
fi

if [[ ${platform} == "linux" ]]; then
# if selected dir does not exists, no change
	if [ -z $dir ]; then
		notify-send -t 5000 -u normal -i ${icon} "Bucket is still '${bucket}'"
	else
		# set selected dir to be the dir in bucket.data file
		echo "${dir}" > "${HOME}/yadle/plugins/bucket1.data"

		# desktop notify message
		notify-send -t 5000 -u normal -i ${icon} "Set bucket to '${dir}'"
	fi
fi
# eof

#!/bin/bash

# this is the default bucket name
basebucket="${HOME}/Desktop/bucket_1"

# icon for notify-send messages
icon="${HOME}/yadle/plugins/logo.png"


# .../bucket.data contains the full path of the current bucket.  If not,
# then put the default from above in the file.
if [ ! -f "${HOME}/yadle/plugins/bucket1.data" ]; then echo "${basebucket}" > "${HOME}/yadle/plugins/bucket1.data"; fi

# get the bucket path from the file
bucket=$(< ~/yadle/plugins/bucket1.data)

# open file selector, start in current bucket
dir=$(zenity --file-selection --directory ${bucket})

# if selected dir does not exists, no change
if [ -z $dir ]; then
	notify-send -t 5000 -u normal -i ${icon} "Bucket is still '${bucket}'"
else
	# set selected dir to be the dir in bucket.data file
	echo "${dir}" > "${HOME}/yadle/plugins/bucket1.data"

	# desktop notify message
	notify-send -t 5000 -u normal -i ${icon} "Set bucket to '${dir}'"
fi

# eof

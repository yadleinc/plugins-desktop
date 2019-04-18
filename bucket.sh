#!/bin/bash

# this is the default bucket name
basebucket="${HOME}/Desktop/bucket_1"

# icon for notify-send messages
icon="${HOME}/yadle/plugins/logo.png"

# full pathname from Yadle
fullpath=$1

# break filename into parts
filename="${fullpath##*/}"                      # Strip longest match of */ from start
dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ext="${filename:${#base} + 1}"

# .../bucket.data contains the full path of the current bucket.  If not,
# then put the default from above in the file.
if [ ! -f "${HOME}/yadle/plugins/bucket1.data" ]; then echo "${basebucket}" > "${HOME}/yadle/plugins/bucket1.data"; fi

# get the bucket path from the file
bucket=$(< ~/yadle/plugins/bucket1.data)

# if bucket does not exist, create it
if [ ! -f ${bucket} ]; then
	mkdir -p "${bucket}"
fi

# copy file to it
e=$(cp "${fullpath}" "${bucket}")

# send desktop[ message
notify-send -t 5000 -u normal -i ${icon} "Copied '${base}.${ext}' to '${bucket}'"

# EOF


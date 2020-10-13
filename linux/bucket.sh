#!/bin/bash

# Copyright 2020 Datawhere Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 
# “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject 
# to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# completion popup values
height=400
width=700
title="Yadle Copy-To-Bucket"

function do_copy () {
	fullpath=$1

	# break filename into parts
	filename="${fullpath##*/}"                      # Strip longest match of */ from start
	dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
	base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
	ext="${filename:${#base} + 1}"

	# check for file, then copy it
	if [ -f "${fullpath}" ]; then	
		e=$(cp "${fullpath}" "${bucket}")
		# send success message
		#notify-send -t 100 -u normal -i ${icon} "Copied '${base}.${ext}' to '${bucket}'"
		#echo "OK    : '${base}.${ext}'" >> ${file_list}
		echo "OK    : '${fullpath}'" >> ${file_list}
	else
		# send failure message
		#notify-send -t 5000 -u normal -i ${icon} "File not copied, check access to file location."
		#echo "FAILED: '${base}.${ext}'" >> ${file_list}
		echo "FAILED: '${fullpath}'" >> ${file_list}
	fi
}


# this is the default bucket name
basebucket="${HOME}/Desktop/bucket_1"

# icon for notify-send messages
icon="${HOME}/yadle/plugins/logo.png"

# .../bucket.data contains the full path of the current bucket.  If not,
# then put the default from above in the file.
if [ ! -f "${HOME}/yadle/plugins/bucket1.data" ]; then echo "${basebucket}" > "${HOME}/yadle/plugins/bucket1.data"; fi

# get the bucket path from the file
bucket=$(< ${HOME}/yadle/plugins/bucket1.data)

file_list="${HOME}/yadle/plugins/file_list.tmp"
echo "The following files were copied to '${bucket}':" > ${file_list}

# if bucket does not exist, create it
if [ ! -f ${bucket} ]; then
	mkdir -p "${bucket}"
fi

# skip command name
for ((i=1;i<=$#;i++))
do
  do_copy "${!i}"  
done

$(zenity --text-info --title=${title} --width=${width} --height=${height} --filename=${file_list})

# EOF

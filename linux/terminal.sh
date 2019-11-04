#!/bin/bash

# full pathname from Yadle
#
fullpath=$1
# break it into parts
#
filename="${fullpath##*/}"                      # Strip longest match of */ from start
dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ext="${filename:${#base} + 1}"

gnome-terminal --working-directory="${dir}" &

# EOF


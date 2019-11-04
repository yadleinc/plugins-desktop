#!/bin/bash

# File viewer example.
#
# the binaries, extensions supported, etc. are intended to be examples to you can
# implement you own previewer plugin for your needs.
#
# contact:   david@datahwere.com   for questions/comments.

# MAKE SURE THIS SCRIPT HAS EXECUTE BIT SET!

# full pathname from Yadle desktop app
fullpath=$1


# binaries
#
aplay="/usr/bin/aplay"
blender="/usr/bin/blender"
djview="/usr/local/djv-1.1.0-Linux-64/bin/djv_view.sh"
mpv="/usr/bin/mpv"
view3dscene="/usr/bin/view3dscene"
vlc="/usr/bin/vlc"


# window position & size
x=400
y=400
w=608
h=342


# break it into parts
#
filename="${fullpath##*/}"                      # Strip longest match of */ from start
dir="${fullpath:0:${#fullpath} - ${#filename}}" # Substring from 0 thru pos of filename
base="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ext="${filename:${#base} + 1}"

# get the file size
#
file_size=`du "${fullpath}" | cut -f1`
echo ${file_size}

# we check file size for audio to determine which player to use.
#
audio_type="small"

if [ ${file_size} -ge 2000 ]; then
	audio_type="big"
fi

#
case "$ext" in

	"3ds")
		${view3dscene} --hide-extras --hide-menu "${fullpath}" &
		exit
		;;


	"avi" | "mkv" | "mp4" | "mpeg" | "mpeg4" | "mpg" | "mov" )
		${mpv} --geometry 50%+400+300 "${fullpath}" &
		exit
		;;

	"dae")
		${view3dscene} --hide-extras --hide-menu "${fullpath}" &
		exit
		;;

	"exr")
		${djview} "${fullpath}" &
		exit
		;;

	"idl")
		${djview} "${fullpath}" &
		exit
		;;

	"mp3")
		${vlc} "${fullpath}" &
		exit
		;;


	"obj")
		#${view3dscene} --hide-extras --hide-menu --geometry ${w}+${h}+${x}+${y} "${fullpath}" &
		${view3dscene} --hide-extras --hide-menu "${fullpath}" &
		exit
		;;

	"stl")
		${view3dscene} --hide-extras --hide-menu --geometry ${w}x${h}+${x}+${y} "${fullpath}" &
		exit
		;;

	"tga")
		${djview} "${fullpath}" &
		exit
		;;

	"wav")
		# wave files whose size is less than 1M are played with aplay.
		# larger are played with vlc so that there are controls to stop it.
		#
		if [ ${audio_type} = "small" ]; then
			${aplay} -t wav "${fullpath}" &
		else
			${vlc} --height 10 --width 100 --no-video --loop "${fullpath}" &
		fi
		exit
		;;

	"x3d")
		${view3dscene} --hide-extras --hide-menu "${fullpath}" &
		exit
		;;

	*)
		# default - try with default app
		xdg-open "${fullpath}" &
		exit
		;;
esac

# EOF



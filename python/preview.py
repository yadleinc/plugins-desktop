""" Plugin for Yadle desktop app that opens requested file in a viewer app.
"""

import logging
import os
from subprocess import call
import sys

import log_config


file_path = sys.argv[1]
logging.debug('file_path: {}'.format(file_path))

try:
    file_size = os.path.getsize(file_path)
except FileNotFoundError:
    logging.error('File not found: {}'.format(file_path))
    sys.exit(1)
    
logging.debug('file_size: {}'.format(file_size))

command_args = {
    'file_path': file_path,
    'x': 400,
    'y': 400,
    'w': 608,
    'h': 342,
}

commands = {
    '3ds': "view3dscene --hide-extras --hide-menu '{file_path}'",
    'dae': "view3dscene --hide-extras --hide-menu '{file_path}'",
    'avi': "mpv --geometry 50%+400+300 '{file_path}''",
    'mkv': "mpv --geometry 50%+400+300 '{file_path}''",
    'mp4': "mpv --geometry 50%+400+300 '{file_path}''",
    'mpeg': "mpv --geometry 50%+400+300 '{file_path}''",
    'mpeg4': "mpv --geometry 50%+400+300 '{file_path}''",
    'mpg': "mpv --geometry 50%+400+300 '{file_path}''",
    'mov': "mpv --geometry 50%+400+300 '{file_path}''",
    'exr': "djview '{file_path}'",
    'idl': "djview} '{file_path}'",
    'mp3': "vlc '{file_path}'",
    'obj': "view3dscene --hide-extras --hide-menu '{file_path}'",
    'stl': "view3dscene --hide-extras --hide-menu --geometry ${w}x${h}+${x}+${y} '${file_path}'",
    'tga': "djview '{file_path}'",
    'wav': "aplay -t wav '{file_path}'" if file_size < 2000 else \
           "vlc --height 10 --width 100 --no-video --loop '{file_path}'",
    'x3d': "fview3dscene --hide-extras --hide-menu '{file_path}'",
}

_, extension = os.path.splitext(file_path)
command = commands[extension] if extension in commands.keys() else \
          "xdg-open '{file_path}'"

command = command.format(**command_args)
logging.debug('Calling command: {}'.format(command))
call(command, shell=True)

""" Plugin for the Yadle desktop app that opens terminal in a file's directory.
"""

import logging
import os
from subprocess import call
import sys

import log_config


file_path = sys.argv[1]
logging.debug('file_path: {}'.format(file_path))
file_dir = os.path.dirname(file_path)
command = "gnome-terminal --working-directory='{}'".format(file_dir)
logging.debug('Calling command: {}'.format(command))
call("gnome-terminal --working-directory='{}'".format(file_dir), shell=True)

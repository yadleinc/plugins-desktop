""" Plugin for the Yadle desktop app that opens a file's directory in
a file manager app.
"""

import logging
import os
from subprocess import call
import sys

import log_config


file_path = sys.argv[1]
logging.debug('file_path: {}'.format(file_path))

file_dir = os.path.dirname(file_path)
call('xdg-open {}'.format(file_dir), shell=True)

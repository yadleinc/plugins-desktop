""" Plugin for Yadle desktop app that opens a file's director in
a directory viewer.
"""

import logging.config
import os
import shutil
from subprocess import call
import sys


# Add location of python executable to sys.path,
# import local configuration and configure logging.
sys.path.append(os.path.dirname(sys.executable))
from log_config import log_config
logging.config.dictConfig(log_config)


file_path = sys.argv[1]
logging.debug('file_path: {}'.format(file_path))

file_dir = os.path.dirname(file_path)
call('xdg-open {}'.format(file_dir), shell=True)

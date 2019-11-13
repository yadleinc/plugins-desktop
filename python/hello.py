""" A "hello world" example of a python plugin.

Just writes sys.argv to a log file.
"""

import logging
import os
import sys


home_dir = os.path.expanduser('~')

# Setup logging.
log_file = os.path.join(home_dir, 'yadle', 'logs', 'plugin.log')
try:
	os.makedirs(os.path.dirname(log_file))
except:
	pass
logging.basicConfig(filename=log_file, level=logging.DEBUG)

for arg in sys.argv:
    logging.debug(arg)

""" Plugin for Yadle desktop papp that sets the bucket directory.
"""

import logging
import os
import shutil
from subprocess import call, check_output, CalledProcessError
import sys


# Configure logging by importing local module log_config.
sys.path.append(os.path.dirname(sys.executable))
import log_config

home_dir = os.path.expanduser('~')
default_bucket = os.path.join(home_dir, 'Desktop', 'bucket_1')
icon = os.path.join(home_dir, 'yadle', 'plugins', 'logo.png')
bucket_data = os.path.join(home_dir, 'yadle', 'plugins', 'bucket1.data')

if not os.path.isfile(bucket_data):
	logging.debug('{} does not exist, creating'.format(bucket_data))
	with open(bucket_data, 'w') as f:
		f.write(default_bucket + '\n')

logging.debug('Reading bucket location from {}'.format(bucket_data))
with open(bucket_data) as f:
	bucket = f.read().strip()

command = 'zenity --file-selection --directory {}'.format(bucket)
logging.debug('Running command: {}'.format(command))
try:
	new_dir = check_output(command, shell=True)
	new_dir = new_dir.decode().strip()
except CalledProcessError:
	new_dir = None
logging.debug('New dir: {}'.format(new_dir))

if new_dir is None or not os.path.isdir(new_dir):
	call("notify-send -t 5000 -u normal -i {} 'Bucket is still {}'".format(
		icon, bucket), shell=True)
	sys.exit(0)

with open(bucket_data, 'w') as f:
	f.write(new_dir + '\n')
call("notify-send -t 5000 -u normal -i {} 'Set bucket to {}'".format(
	icon, new_dir), shell=True)

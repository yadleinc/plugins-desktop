""" Plugin for Yadle desktop app that copies the file to a folder.
"""

import logging
import os
import shutil
from subprocess import call
import sys


home_dir = os.path.expanduser('~')

# Setup logging.
log_file = os.path.join(home_dir, 'yadle', 'logs', 'plugin.log')
try:
	os.makedirs(os.path.dirname(log_file))
except:
	pass
logging.basicConfig(filename=log_file, level=logging.DEBUG)

file_path = sys.argv[1]
home_dir = os.path.expanduser('~')
default_bucket = os.path.join(home_dir, 'Desktop', 'bucket_1')
icon = os.path.join(home_dir, 'yadle', 'plugins', 'logo.png')

with open(os.path.join(home_dir, 'yadle', 'plugins', 'bucket1.data')) as f:
	bucket = f.read().strip()

logging.debug('log_file: {}'.format(log_file))
logging.debug('file_path: {}'.format(file_path))
logging.debug('home_dir: {}'.format(home_dir))
logging.debug('default_bucket: {}'.format(default_bucket))
logging.debug('file_path: {}'.format(file_path))

if not os.path.isdir(bucket):
	logging.debug('Creating bucket {}'.format(bucket))
	os.makedirs(bucket)

logging.debug('Copying {} to {}'.format(file_path, bucket))
shutil.copy(file_path, bucket)

logging.debug('Notifying')
command = "notify-send -t 5000 -u normal -i {} 'Copied {} to {}'".format(
	icon, os.path.basename(file_path), bucket)
call(command, shell=True)
logging.debug('Notified')

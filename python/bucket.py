""" Plugin for Yadle desktop app that copies the file to a folder.
"""

import logging
import os
import shutil
from subprocess import call
import sys


# Configure logging by importing local module log_config.
sys.path.append(os.path.dirname(sys.executable))
import log_config

file_path = sys.argv[1]
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

logging.debug('file_path: {}'.format(file_path))
logging.debug('home_dir: {}'.format(home_dir))
logging.debug('default_bucket: {}'.format(default_bucket))

if not os.path.isdir(bucket):
    logging.debug('Creating bucket {}'.format(bucket))
    os.makedirs(bucket)

logging.debug('Copying {} to {}'.format(file_path, bucket))
try:
    shutil.copy(file_path, bucket)
except:
    logging.error('Failed to copy {} to {}'.format(file_path, bucket))
    sys.exit(1)

logging.debug('Notifying')
command = "notify-send -t 5000 -u normal -i {} 'Copied {} to {}'".format(
    icon, os.path.basename(file_path), bucket)
call(command, shell=True)
logging.debug('Notified')

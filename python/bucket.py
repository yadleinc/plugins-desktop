""" Plugin for the Yadle desktop app that copies file(s) to a folder.
"""

import logging
import os
import shutil
from subprocess import call
import sys

import log_config


file_paths = sys.argv[1:]
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

logging.debug('file_paths: {}'.format(file_paths))
logging.debug('home_dir: {}'.format(home_dir))
logging.debug('default_bucket: {}'.format(default_bucket))

if not os.path.isdir(bucket):
    logging.debug('Creating bucket {}'.format(bucket))
    os.makedirs(bucket)

for file_path in file_paths:
    logging.debug('Copying {} to {}'.format(file_path, bucket))
    try:
        shutil.copy(file_path, bucket)
        command = "notify-send -t 5000 -u normal -i {} 'Copied {} to {}'".format(
            icon, os.path.basename(file_path), bucket)
        call(command, shell=True)
    except:
        logging.error('Failed to copy {} to {}'.format(file_path, bucket))

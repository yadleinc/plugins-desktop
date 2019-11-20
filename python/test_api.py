""" Sample plugin to show usage of Yadle API.
"""

import json
import logging
import sys

import requests

import log_config


file_path = sys.argv[1]
server_url = sys.argv[2]
app_id = sys.argv[3]
token_key = sys.argv[4]
device_id = sys.argv[5]
file_id = sys.argv[6]

logging.debug('file_path  : {}'.format(file_path))
logging.debug('server_url : {}'.format(server_url))
logging.debug('app_id     : {}'.format(app_id))
logging.debug('token_key  : {}'.format(token_key))
logging.debug('device_id  : {}'.format(device_id))
logging.debug('file_id    : {}'.format(file_id))

headers = {
    'x-app-id': app_id,
    'Authorization': 'Bearer ' + token_key,
    'cache-control': 'no-cache',
    'Content-Type': 'application/json',
}

url = '{}/yadle/v2/file/{}'.format(server_url.rstrip('/'), file_id)
response = requests.get(url, headers=headers)
response = json.loads(response.text)
logging.debug(response)

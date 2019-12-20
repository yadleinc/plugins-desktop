""" Plugin for the Yadle desktop app that shows how to use the Yadle API.
"""

import json
import logging
import sys

import requests

import log_config


server_url = sys.argv[1]
app_id = sys.argv[2]
token_key = sys.argv[3]
user_id = sys.argv[4]
search_terms = sys.argv[5]
file_ids = sys.argv[6:]

logging.debug('server_url   : {}'.format(server_url))
logging.debug('app_id       : {}'.format(app_id))
logging.debug('token_key    : {}'.format(token_key))
logging.debug('user_id      : {}'.format(user_id))
logging.debug('search_terms : {}'.format(search_terms))
for file_id in file_ids:
    logging.debug('file_id    : {}'.format(file_id))

headers = {
    'x-app-id': app_id,
    'Authorization': 'Bearer ' + token_key,
    'cache-control': 'no-cache',
    'Content-Type': 'application/json',
}

for file_id in file_ids:
    url = '{}/yadle/v2/file/{}'.format(server_url.rstrip('/'), file_id)
    response = requests.get(url, headers=headers)
    response = json.loads(response.text)
    logging.debug(response)

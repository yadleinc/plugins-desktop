""" Logging configuration for the Yadle desktop app.
"""

import logging
import logging.config
import os


# Compose the log file name, and ensure that the directory is created.
home_dir = os.path.expanduser('~')
log_file = os.path.join(home_dir, 'yadle', 'logs', 'plugin.log')
try:
	os.makedirs(os.path.dirname(log_file))
except:
	pass


class FilenameLinenoFilter(logging.Filter):
    """ Filter that combines filename and line number into a single log field.
    """
    def filter(self, record):
        record.filename_lineno = '%s:%d'%(record.filename, record.lineno)
        return True

log_config = {
    'version': 1,
    'filters': {
        'filename_lineno_filter': {
            '()': FilenameLinenoFilter,
        },
    },
    'formatters': {
        'default': {
            'format': '%(asctime)-15s %(filename_lineno)-20s %(levelname)-8s| %(message)s',
        },
    },
    'handlers': {
        'default': {
            'filename': log_file,
            'class': 'logging.FileHandler',
            'filters': ['filename_lineno_filter'],
            'formatter': 'default',
        },
    },
    'loggers': {
        '': {
            'level': 'DEBUG',
            'handlers': ['default'],
        },
    },
    'root': None,
    'incremental': False,
    'disable_existing_loggers': True,
}

logging.config.dictConfig(log_config)

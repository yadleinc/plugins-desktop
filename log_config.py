""" Logging configuration.
"""

import logging


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
            'format': '%(asctime)-15s %(filename_lineno)-28s %(levelname)-8s| %(message)s',
        },
    },
    'handlers': {
        'default': {
            'class': 'logging.StreamHandler',
            'filters': ['filename_lineno_filter'],
            'formatter': 'default',
        },
    },
    'loggers': {
        '': {
            'level': 'INFO',
            'handlers': ['default'],
        },
    },
    'root': None,
    'incremental': False,
    'disable_existing_loggers': True,
}

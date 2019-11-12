""" Test for Yadle python plugins.
"""

import os
import sys

this_dir = os.path.dirname(os.path.abspath(__file__))
output_file = os.path.join(this_dir, 'hello.log')

with open(output_file, 'w') as f:
    for arg in sys.argv:
        f.write(arg + '\n')

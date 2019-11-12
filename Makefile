#####################################################################
#
#  Makefile for Yadle desktop plugins.
#
#  Copyright (c) Yadle Inc. All rights reserved.
#
#####################################################################

PLUGINS_DIR=~/yadle/plugins

plugins_dir:
	mkdir -p $(PLUGINS_DIR)

python: plugins_dir
	cp -r python/* $(PLUGINS_DIR)

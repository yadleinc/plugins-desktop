#####################################################################
#
#  Makefile for Yadle desktop plugins.
#
#  Copyright (c) Yadle Inc. All rights reserved.
#
#####################################################################

YADLE_DIR=~/yadle
PLUGINS_DIR=$(YADLE_DIR)/plugins
VENV_DIR=$(YADLE_DIR)/venv

venv/bin/activate: requirements.txt
	test -d $(VENV_DIR) || virtualenv -p python3 $(VENV_DIR)
	. $(VENV_DIR)/bin/activate; pip install -Ur requirements.txt
	touch $(VENV_DIR)/bin/activate
	ln -sf $(VENV_DIR)/bin/python $(YADLE_DIR)

venv: venv/bin/activate

plugins_dir:
	mkdir -p $(PLUGINS_DIR)

python: plugins_dir
	cp -r python/* $(PLUGINS_DIR)

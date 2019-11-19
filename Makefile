#####################################################################
#
#  Build the Yadle desktop plugins.
#
#####################################################################

INSTALL_DIR=~/yadle
PLUGINS_DIR=$(INSTALL_DIR)/plugins

setup:
	mkdir -p $(PLUGINS_DIR)

python_plugins: setup
	cp -r python/* $(PLUGINS_DIR)

bash_plugins: setup
	cp -r linux/* $(PLUGINS_DIR)

remove_plugins:
	rm -f $(PLUGINS_DIR)/*

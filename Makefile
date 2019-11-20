#####################################################################
#
#  Build the Yadle desktop plugins.
#
#####################################################################

INSTALL_DIR=~/yadle
PLUGINS_DIR=$(INSTALL_DIR)/plugins

setup:
	mkdir -p $(PLUGINS_DIR)

python_plugins: setup venv
	cp -r python/* $(PLUGINS_DIR)

bash_plugins: setup
	cp -r linux/* $(PLUGINS_DIR)

remove_plugins:
	rm -f $(PLUGINS_DIR)/*

venv/bin/activate: requirements.txt
	test -d $(INSTALL_DIR)/venv || virtualenv -p python3 $(INSTALL_DIR)/venv
	. $(INSTALL_DIR)/venv/bin/activate; pip install -Ur requirements.txt
	touch $(INSTALL_DIR)/venv/bin/activate
	ln -sf venv/bin/python $(INSTALL_DIR)/python

venv: venv/bin/activate setup

clean:
	rm -rf $(INSTALL_DIR)

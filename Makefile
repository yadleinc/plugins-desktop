#####################################################################
#
#  Build the Yadle desktop plugins.
#
#####################################################################

INSTALL_DIR=~/yadle
PLUGINS_DIR=$(INSTALL_DIR)/plugins
VENV_DIR=$(INSTALL_DIR)/venv

venv/bin/activate: requirements.txt
	test -d $(VENV_DIR) || virtualenv -p python3 $(VENV_DIR)
	. $(VENV_DIR)/bin/activate; pip install -Ur requirements.txt
	touch $(VENV_DIR)/bin/activate
	ln -sf venv/bin/python $(INSTALL_DIR)

venv: venv/bin/activate

setup:
	mkdir -p $(PLUGINS_DIR)
	cp log_config.py $(INSTALL_DIR)

python_plugins: setup venv
	cp -r python/* $(PLUGINS_DIR)

bash_plugins: setup venv
	cp -r linux/* $(PLUGINS_DIR)

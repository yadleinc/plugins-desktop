plugins-desktop
===============
Plugins for the Yadle desktop app.

Contains sample plugins that can do stuff like:

- copy the file into a custom folder
- show the file in File Explorer
- preview the file
- print the file
- etc.

Can be easily extended to handle custom functions.

Installation
------------
Install Python-based plugins by running make:
::

   make python_plugins

This creates the ~/yadle directory, builds a Python virtualenv in it
and copies plugins files into it.

You can add your own custom plugins to the ``python/`` directory,
and just re-run the make command to install them.

Create your own plugins
-----------------------
Take a look at ``linux/`` or ``python/`` directories for examples.

Each plugin has an implementation file (``.sh`` or ``.py``) and a ``.json`` file.

The ``.json`` file describes the plugin to the Yadle desktop app.

The JSON object has the following fields:

- ``"excludes"`` - file extensions ignored by this plugin
- ``"includes"`` - file extensions acted upon by this plugin
- ``"enabled"`` - whether or not the plugin is active
- ``"name"`` - text that appears in the Yadle desktop app menu

If you change a ``.json`` file, you need to exit and restart the Yadle desktop app.

(No need to restart if you change ``.sh`` or ``.py`` files.)

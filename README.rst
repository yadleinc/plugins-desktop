plugins-desktop
===============
Plugins for the Yadle desktop app.

Contains sample plugins that can:

- open the file in File Explorer
- preview the file
- print the file
- etc.
  
Installation
------------
Install Python versions of the plugins:
::

   make python

Create your own plugin
----------------------
Take a look at ``linux/`` or ``python/`` directories for examples.

Each plugin has an implementation file (``.sh`` or ``.py``) and a ``.json`` file.

The ``.json`` file describes the plugin to the Yadle desktop app.

The JSON object has the following fields:

- ``"excludes"`` - file extensions ignored by this plugin
- ``"includes"`` - file extensions acted upon by this plugin
- ``"enabled"`` - whether or not the plugin is active
- ``"name"`` - text that appears in the Yadle desktop app menu

You need to exit Yadle desktop and restart it if you change the ``.json`` file.

(No need to exit and restart if you change the ``.sh`` or ``.py`` file.)

plugins-desktop
===============
Plugins for the Yadle desktop app.

Contains sample plugins that can:

- open in File Explorer
- open in terminal
- print
- preview

Installation
------------
Install Python versions of the plugins:
::

   make python

Make your own plugin
--------------------
Each plugin has it's own ``.json`` file.
This file describes the plugin to the Yadle desktop app.
The JSON object has the following fields:

- ``"excludes"`` - File extensions ignored by this plugin
- ``"includes"`` - File extensions acted upon by this plugin
- ``"enabled"`` - Whether or not the plugin is active
- ``"name"`` - Text that appears in the Yadle app menu

Put the files in a yadle directory in your home.  Ex:  /home/david/yadle

Make sure all .sh files have execute bit set.  

You need to exit Yadle desktop and restart it if you change a .json file.   
No need to exit and restart if you change a .sh or .py file.

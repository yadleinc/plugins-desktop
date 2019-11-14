plugins-desktop
===============
Plugins for the Yadle Desktop app.

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
The .json files describe the plugin to the Yadle desktop app.

Put the files in a yadle directory in your home.  Ex:  /home/david/yadle

Make sure all .sh files have execute bit set.  

You need to exit Yadle desktop and restart it if you change a .json file.   
No need to exit and restart if you change a .sh or .py file.

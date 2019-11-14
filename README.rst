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
Install the plugins by running make:
::

   make python_plugins

This creates the ``~/yadle`` directory and copies the plugin files to it.

You can also install Bash versions of the plugins:
::

   make bash_plugins

Sample plugins are duplicated in both implementations, Python and Bash.
Installing both will create duplicate entries in the desktop app menu.
You can remove all plugins by running:
::

   make remove_plugins

Create your own plugins
-----------------------
You can add your own custom plugins to ``python/`` or ``linux/`` directories,
and then re-run ``make`` to install them.

Take a look at ``python/`` and ``linux/`` directories for examples.

How plugins work
................
A plugin is a standalone program that receives file path as a parameter on
the command line (e.g. ``sys.argv[1]`` in Python or ``$1`` in Bash).

Each plugin has an implementation file (``.py`` or ``.sh``) and a ``.json`` file.

The ``.json`` file describes the plugin to the Yadle desktop app.

The JSON object has the following fields:

- ``"command"`` - the command that receives the path
- ``"excludes"`` - file extensions ignored by this plugin
- ``"includes"`` - file extensions acted upon by this plugin
- ``"enabled"`` - whether or not the plugin is active
- ``"name"`` - text that appears in the Yadle desktop app menu

Make sure you give all files (``.json``, ``.py`` and ``.sh``) unique names,
because installation copies all of them into the same destination directory.

If you change a ``.json`` file, you need to exit and restart the Yadle desktop app.

(No need to restart if you change ``.sh`` or ``.py`` files.)

Implementation language
.......................
Examples are done in Python and Bash, but you can write your plugin in whatever
language you want.

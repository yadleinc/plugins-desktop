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
A plugin is a standalone program that runs predefined actions
on individual files or a group of selected files.
It accepts search results as command line parameters,
e.g. ``sys.argv`` in Python or ``$1 $2...`` in Bash.

Each plugin has an implementation file (``.py`` or ``.sh``) and
a ``.json`` file that describes the plugin to the Yadle desktop app.
The JSON object has the following fields:

:``"name"``:
   Text that appears in the Yadle desktop app menu.

:``"command"``:
   Command that runs when the plugin is invoked.
   Defined as a string, may contain environment variables, e.g. $HOME.

:``"leading_arguments"``:
   Optional list of command line arguments when invoking the plugin command.
   These are arguments added to the command string above.
   Can be any of the following:

     ``"server_url"``, ``"app_id"``, ``"token_key"``.

:``"file_argument"``:
   Optional field indicating the file attribute to add at the end of
   the command string.

   May be either ``"id"`` to denote file ID or ``"path"`` to indicate
   the complete filesystem path to the file.

   If operating on multiple files (i.e. bulk mode) the command
   string is extended by adding this attribute once for every file.
   
:``"excludes"``:
   Optional list of file extensions ignored by the plugin.
     
:``"includes"``:
   Optional list of file extensions acted upon by the plugin.
   
:``"enabled"``:
   Whether or not the plugin is active. This field is optional; by default
   the plugin is enabled.
   
Make sure you give all files (``.json``, ``.py`` and ``.sh``) unique names,
because installation copies all of them into the same destination directory.

If you change a ``.json`` file, you need to exit and restart the Yadle desktop app.

(No need to restart if you change ``.sh`` or ``.py`` files.)

Implementation language
.......................
Examples are done in Python and Bash, but you can write your plugin in whatever
language you want.

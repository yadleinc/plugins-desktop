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
**macOS / Linux**

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

**Windows**

Install the plugins by double-clicking the "windows_installer.bat".

This creates the ``~/yadle`` directory and copies the plugin files to it.

How plugins work
----------------
A plugin is a standalone program that runs predefined actions when the user
invokes it on an individual file or a group of selected files.
A plugin accepts optional, configurable parameters as command line
arguments, e.g. ``sys.argv`` in Python or ``$1 $2...`` in Bash.
Take a look at ``python/`` and ``linux/`` directories for examples.

The main configuration file ``plugins.json`` defines the plugin pulldown menu.
It contains an array of objects, where each object can be a single plugin entry,
using keys ``"item"`` and ``"plugin"``:
::

   {
       "item": "Plugin title",
       "plugin": "filename.json"
   }

or a submenu of plugins using keys ``"menu"`` and ``"items"``:
::

   {
       "menu": "Bash plugins",
       "items": [
           "bucket.json",
           "explorer.json",
           "preview.json",
           "print.json",
           "set_bucket.json",
           "terminal.json"
       ]
   }

In addition, each individual plugin has an implementation file
(``.py`` or ``.sh``) and a ``.json`` configuration file
with the following fields:

``"name"``
   Text that appears in the Yadle desktop app menu.

``"command"``
   Command that runs when the plugin is invoked.
   Defined as a string, may contain environment variables, e.g. $HOME.

``"leading_arguments"``
   Optional list of command line arguments when invoking the plugin command.
   These are arguments added to the command string above.
   Can be any of: ``"server_url"``, ``"app_id"``, ``"token_key"``,
   ``"user_id"``, ``"search_terms"``.

``"file_argument"``
   Optional field indicating the type of file attribute to add at the end of
   command string.

   May be either ``"id"`` for file ID, or ``"path"`` for the complete
   filesystem path to the file.

   When operating on multiple files, command string is extended by
   appending this attribute once for every file.
   
``"platforms"``
   Collection of name/Boolean pairs indicating O/S compatibility.
   Names can be any of:
   ``"aix"``, ``"macos"``, ``"freebsd"``, ``"linux"``, ``"openbsd"``,
   ``"sunos"``, ``"windows"``.

   For example:
   ::

      "platforms": {
        "win32": true,
        "osx": false,
        "linux": true
      }

   If name is missing, the plugin is disabled for that O/S.
   
``"enabled"``
   Optional field indicating whether or not the plugin is active.
   Can be ``true`` or ``false``. If not present, defaults to ``true``.

Make sure you give all files (``.json``, ``.py`` and ``.sh``) unique names,
because installation copies all of them into the same destination directory.

If you change a ``.json`` file, you need to exit and restart the Yadle desktop app.

(No need to restart if you change ``.sh`` or ``.py`` files.)

Implementation language
.......................
Examples are done in Python and Bash, but you can write your plugin in whatever
language you want.

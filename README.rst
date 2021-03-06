plugins-desktop
===============
Plugins for the Yadle desktop app.

Installation
------------
First, either clone this repo or download as .zip and extract. Then proceed with instructions depending on your OS.

**Linux**

Run the linux_installer.sh script. This creates the ``~/yadle/plugins`` directory and copies the Linux plugin files to it.
::

   bash linux_installer.sh

**macOS**

Run the macos_installer.sh script. This creates the ``~/yadle/plugins`` directory and copies the macOS plugin files to it.
::

   bash macos_installer.sh

**Windows**

Install the plugins by double-clicking the ``windows_installer.bat``.

This creates the ``%USERPROFILE%\yadle\plugins`` directory and copies the Windows plugin files to it.

Summary of available plugins
------------------
- **Set Bucket Folder:** Sets a destination folder or "bucket". (linux, macos, windows)

- **Copy to Bucket:** Copy files from Yadle search results to "bucket". (linux, macos, windows)

- **Preview:** Preview the file with application of your choosing based on extension. (linux)

- **Open in Terminal:** Opens selected file in terminal. (linux, windows)

- **Open in File Browser/Explorer:** Opens selected file in OS native file explorer. (linux, windows)

- **Tag as Favorite:** Apply #favorite tag to files with the click of a button. No need for any keyboard entry. (linux, macos)

- **Print:** Prints selected file. (linux)

These plugins are meant to act as examples providing the framework to create your own custom actions.

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
   ``"aix"``, ``"darwin"``, ``"freebsd"``, ``"linux"``, ``"openbsd"``,
   ``"sunos"``, ``"win32"``.

   For example:
   ::

      "platforms": {
        "win32": true,
        "darwin": true,
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

rem this program takes the plugins from the 'windows' folder
rem and stores them in %userprofile%\yadle\plugins
rem for the yadle desktop app to access

@echo off

rem Display YADLE logo
echo          __       __
echo \ / /\  ^|  \ ^|   ^|__
echo  ^| /~~\ ^|__/ ^|__ ^|__
echo --------------------

set newfolder="%userprofile%\yadle\plugins"

IF NOT EXIST %newfolder% (
   mkdir %newfolder%
)

copy plugins.json %newfolder%
copy windows\* %newfolder%

echo "Done, press any key to close."
pause


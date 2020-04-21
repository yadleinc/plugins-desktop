@echo off

rem this program takes the plugins from the 'windows' folder
rem and stores them in %userprofile%\yadle\plugins
rem for the yadle desktop app to access

rem Display YADLE logo
echo          __       __
echo \ / /\  ^|  \ ^|   ^|__
echo  ^| /~~\ ^|__/ ^|__ ^|__
echo --------------------

set newfolder="%userprofile%\yadle\plugins"

rem check for newfolder
IF NOT EXIST %newfolder% (
   mkdir %newfolder%
)

rem copy plugins
echo Installing plugins...
echo.
copy plugins.json %newfolder%
copy windows\* %newfolder%
echo.
echo Plugins installed
echo.

pause


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
copy plugins.json %newfolder% > NUL
copy windows\* %newfolder% > NUL
echo.
echo Plugins installed!
echo.

pause


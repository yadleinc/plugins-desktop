#!/bin/bash

echo "          __        ___   "
echo "\ /  /\  |  \ |    |__    "
echo " |  /~~\ |__/ |___ |___   "
echo "                          "
echo "Installing Desktop Plugins for Linux..."

install_location="$HOME/yadle/plugins"

mkdir -p ${install_location}

echo "Copying Plugins to ${install_location}..."
cp plugins.json ${install_location}

cp linux/* ${install_location}

chmod +x ${install_location}/*.sh

echo "Plugins Installed Successfully"

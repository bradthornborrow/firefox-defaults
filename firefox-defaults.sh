#!/bin/bash

# Set source path to script location 
$SOURCE_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Change to default Firefox config directory
if [ -d "$HOME/Library/Application Support/Firefox" ]; then
	cd ~/Library/Application\ Support/Firefox
else
	cd -- "$(find $HOME -ipath "*/.mozilla/firefox" -type d -printf '%h' -quit)"/firefox
fi

# Locate default Firefox profile directory
if [[ $(grep '\[Profile[^0]\]' profiles.ini) ]]
	then PROFPATH=$(grep -E '^\[Profile|^Path|^Locked' profiles.ini | grep -1 '^Locked=1' | grep '^Path' | cut -c6-)
	else PROFPATH=$(grep 'Path=' profiles.ini | sed 's/^Path=//')
fi

# Copy preferences to default Firefox profile folder
cp -R $SOURCE_PATH/firefox-defaults/* $PROFPATH/

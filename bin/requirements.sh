#!bin/bash

## Settings file exist, if not prompt creation
if [ ! -f "settings/settings.txt" ] || [ ! -d "../configuration" ]; then
	echo -e "\e[36mIt seems to be the first time running the manager"
	echo -ne "Would you like to make configuration? (y/n):\e[0m "
	read answer
	echo ""
	
	if [ "$answer" != "${answer#[Yy]}" ]; then
		pushd "configure/" > /dev/null
		bash create_settings.sh
		bash auto_create_channels.sh
		popd > /dev/null
	fi
fi
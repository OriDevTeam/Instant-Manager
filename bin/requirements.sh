#!bin/bash
pushd "../" > /dev/null

## Check necessary folders
folder=(
"shared/data"
"shared/locale"
"shared/package"
)
necessaryFolders=()

for folder in "${folder[@]}"
do
    if [ ! -d $folder ]; then
        necessaryFolders+=($folder)
    fi
done

if (( ${#necessaryFolders[@]} )); then
	echo "There is necessary folders needed to run the server properly, heres which:"
	
	for folder in "${necessaryFolders[@]}"
	do
		echo " - $folder"
	done
	
	exit 1
fi

popd > /dev/null

## Settings file exists, if not prompt creation
settingsFolderNamePath="settings/settings_folder.txt"
if [ ! -f "$settingsFolderNamePath" ]; then
	echo -e "\e[36mIt seems to be the first time running the manager"
	echo -ne "Would you like to make configuration? (y/n):\e[0m "
	read answer
	echo ""
	
	if [ "$answer" != "${answer#[Yy]}" ]; then
		pushd "configure/" > /dev/null
		bash create_settings.sh
		popd > /dev/null
	else
		touch "$settingsFolderNamePath"
		echo  "default" > "$settingsFolderNamePath"
		
		echo -e "\e[32mSettings configuration was set to Default"
		echo -e "You can modify this later on the Configure/Settings menu\e[0m "
	fi
else
	settingsName=$(awk 'NR==1 {print; exit}' $settingsFolderNamePath)
	
	if [ -z "$settingsName" ]; then
		echo -e "It seems the Settings Folder Name is empty"
		echo -e "Setting it to Default settings..."

		echo  "default" > "$settingsFolderNamePath"
	else
		settingsFolderDir="../shared/settings/$settingsName/"
		if [ ! -d "$settingsFolderDir" ]; then 
			echo -e "It seems the Settings Folder '$settingsName' doesn't exist"
			echo -e "on $settingsFolderDir, so it will be set to Default"
			
			echo  "default" > "$settingsFolderNamePath"
		fi
	fi
	
	echo -e ""
fi

## Channel configuration exists, if not prompt creation
if [ ! -d "../configuration" ]; then
	echo -ne "\e[36mWould you like to configurate channels? (y/n):\e[0m "
	read answer
	echo ""
	
	pushd "configure/" > /dev/null
	bash create_map_index.sh
	bash auto_create_channels.sh
	popd > /dev/null
fi

pushd "settings/" > /dev/null

locale=$(bash get_setting.sh general locale)
env=$(bash get_setting.sh general environment)
game_bin=$(bash get_setting.sh general game_bin)
db_bin=$(bash get_setting.sh general db_bin)
qc_bin=$(bash get_setting.sh general qc_bin)

popd > /dev/null

pushd "../" > /dev/null

files=(
"shared/envs/$env/$game_bin"
"shared/envs/$env/$db_bin"
"shared/envs/$env/$qc_bin"
"shared/CMD"
)

for file in "${files[@]}"
do
    if [ ! -f "$file" ]; then
        necessaryFiles+=($file)
    fi
done

if (( ${#necessaryFiles[@]} )); then
	echo "There is necessary files needed to run the server properly, heres which:"
	
	for file in "${necessaryFiles[@]}"
	do
		echo " - $file"
	done
	
	exit 1
fi

popd > /dev/null

exit 0

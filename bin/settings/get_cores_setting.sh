#!/bin/bash
coreType=$1
settingsType=$2
configurationToken=$3
folderSettingsPath="settings_folder.txt"

if [ ! -f $folderSettingsPath ]; then
	echo "Settings Folder file not found" >&2
	echo ""
	exit
fi

settingsFolderPath=$(awk 'NR==1 {print; exit}' $folderSettingsPath)

if [ -z $settingsFolderPath ]; then
	echo "Settings Folder File $settingsFolderPath not found" >&2
	echo ""
	exit
fi

settingsFilePath="../../shared/settings/${settingsFolderPath}/cores/${coreType}/${settingsType}.txt"

if [ ! -f "$settingsFilePath" ]; then
	echo "Core Settings File $settingsFilePath not found" >&2
	echo ""
	exit
fi

echo $(bash get_folder_cores_setting.sh "${settingsFilePath}" "$configurationToken")

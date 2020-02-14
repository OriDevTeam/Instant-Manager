#!/bin/bash
settingsType=$1
settingsToken=$2
valueToSet=$3
toggleEnable=$4
dataType=$5
addNewIfMissing=$6
folderSettingsPath="settings_folder.txt"

if [ ! -f $folderSettingsPath ]; then
	echo "Settings Folder file not found"
	exit 0
fi

settingsFolderPath=$(awk 'NR==1 {print; exit}' $folderSettingsPath)

if [ -z $settingsFolderPath ]; then
	echo "Settings file $settingsFolderPath not found"
	exit 0
fi

settingsFilePath="../../shared/settings/${settingsFolderPath}/structure/${settingsType}.txt"

if [ ! -f $settingsFilePath ]; then
	echo "Settings File $settingsFilePath not found"
	exit 0
fi

echo $(bash set_folder_setting.sh "${settingsFilePath}" "$settingsToken" "$valueToSet" "$toggleEnable" "$dataType" "$addNewIfMissing")

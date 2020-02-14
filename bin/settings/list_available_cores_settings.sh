#!/bin/bash
coreType=$1
settingsType=$2
folderSettingsPath="settings_folder.txt"

if [ ! -f $folderSettingsPath ]; then
	echo "Settings Folder file not found"
	exit 0
fi

settingsFolderPath=$(awk 'NR==1 {print; exit}' $folderSettingsPath)

if [ -z "$settingsFolderPath" ]; then
	echo "Settings Folder File $settingsFolderPath not found"
	exit 0
fi

settingsFilePath="../../shared/settings/${settingsFolderPath}/cores/${coreType}/${settingsType}.txt"

if [ ! -f "$settingsFilePath" ]; then
	echo "Settings File $settingsFilePath not found"
	exit 0
fi

availableSettings=()
while IFS="" read -r line || [ -n "$line" ]
do
	type=$(echo $line | cut -d ":" -f1)
	availableSettings+=("$type")
done < $settingsFilePath

echo "${availableSettings[@]}"

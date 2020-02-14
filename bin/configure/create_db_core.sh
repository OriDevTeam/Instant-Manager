#!/bin/bash

mkdir -p ../../configuration/databases/db/$core
cd ../../configuration/databases/db/$core

bash ../../../../bin/external/link CMD ../../../../shared/CMD
bash ../../../../bin/external/link keepalive.sh ../../../../shared/db_keepalive.sh

bash ../../../../bin/external/link item_names.txt ../../../../shared/item_names.txt
bash ../../../../bin/external/link item_proto.txt ../../../../shared/item_proto.txt
bash ../../../../bin/external/link mob_names.txt ../../../../shared/mob_names.txt
bash ../../../../bin/external/link mob_proto.txt ../../../../shared/mob_proto.txt

configDir=../../../configuration/databases/db/$core/conf.txt

cd ../../../../bin/

pushd "settings/" > /dev/null

settingsDir="settings_folder.txt"
settingsName=$(awk 'NR==1 {print; exit}' $settingsDir)

if [ -z $settingsName ]; then
	echo "No Settings Name defined"
	exit 0
fi

echo -e "\e[33mCreating Database Core Configuration...\e[0m"

pushd "../../shared/settings/$settingsName/cores/database/" > /dev/null

coreSettingsAvailable=()
for config in *; do coreSettingsAvailable+=("${config%.txt}"); done

popd > /dev/null

configDir="../../configuration/databases/db/$core/conf.txt"
touch "$configDir"

for coreSetting in "${coreSettingsAvailable[@]}"
do
	availableSettings=($(bash list_available_cores_settings.sh database "$coreSetting"))
	
	echo "// ${coreSetting^} Settings //" >> $configDir
	
	for setting in "${availableSettings[@]}"
	do
		configurationString=$(bash get_cores_setting.sh database "$coreSetting" "$setting")
		
		if [ -z "$configurationString" ]; then
			echo "Exiting Database Core creation..."
			exit
		fi
		
		configurationString=$(eval $configurationString)
		echo "$configurationString" >> $configDir
	done
	
	echo "" >> $configDir
done

popd > /dev/null

echo -e "Created Database Core."

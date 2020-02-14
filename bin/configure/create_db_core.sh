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

echo "Creating Database Core Configuration..."

pushd "../../shared/settings/$settingsName/cores/database/" > /dev/null

coreSettingsAvailable=()
for config in *; do coreSettingsAvailable+=("${config%.txt}"); done

popd > /dev/null

configDir="../../configuration/databases/db/$core/conf.txt"
for coreSetting in "${coreSettingsAvailable[@]}"
do
	availableSettings=($(bash list_available_cores_settings.sh database "$coreSetting"))
	
	echo "// ${coreSetting^} Settings //" >> $configDir
	
	for setting in "${availableSettings[@]}"
	do
		configurationString=$(bash get_cores_setting.sh database "$coreSetting" "$setting")
		configurationString=$(eval $configurationString)
		echo "$configurationString" >> $configDir
	done
	
	echo ""
	
done

popd > /dev/null

echo -e "Created Database Core."

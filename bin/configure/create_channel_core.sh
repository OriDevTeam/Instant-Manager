#!/bin/bash
channel=$1
channel_number=$2
core=$3
core_name=$4
base_num=$5
map_allow=$6

mkdir -p ../../configuration/channels/$channel/$core_name
cd ../../configuration/channels/$channel/$core_name

mkdir -p mark
mkdir -p log

bash ../../../../bin/external/link locale ../../../../shared/locale
bash ../../../../bin/external/link data ../../../../shared/data
bash ../../../../bin/external/link CMD ../../../../shared/CMD
bash ../../../../bin/external/link keepalive.sh ../../../../shared/game_keepalive.sh
bash ../../../../bin/external/link package ../../../../shared/package

configDir=../../../configuration/channels/$channel/$core_name/CONFIG

cd ../../../../bin/

pushd "settings/" > /dev/null

settingsDir="settings_folder.txt"
settingsName=$(awk 'NR==1 {print; exit}' $settingsDir)

if [ -z $settingsName ]; then
	echo "No Settings Name defined"
	exit 0
fi

echo "Creating Channel '$channel' '$core_name' Configuration..."


paths=("")

if [ $channel == "auth" ]; then
	paths+=("auth")
else
	paths+=("game")
fi

coreDir="../../configuration/channels/$channel/$core_name/CONFIG"

for path in "${paths[@]}"; do
	
	pushd "../../shared/settings/$settingsName/cores/channels/$path" > /dev/null
	
	coreSettingsAvailable=()
	configFiles=$(ls -p | grep -v /)
	for config in ${configFiles[@]}; do coreSettingsAvailable+=("${config%.txt}"); done
	
	popd > /dev/null
	
	for coreSetting in "${coreSettingsAvailable[@]}"
	do
		availableSettings=($(bash list_available_cores_settings.sh "channels/$path" "$coreSetting"))
		
		echo "// ${coreSetting^} Settings //" >> $coreDir
		
		for setting in "${availableSettings[@]}"
		do
			configurationString="$(bash get_cores_setting.sh "channels/$path" "$coreSetting" "$setting")"
			configurationString=$(eval "$configurationString")
			echo "$configurationString" >> $coreDir
		done
		
		echo "" >> $coreDir
		
	done
done

popd > /dev/null

echo -e "Created '$channel' '$core_name'"

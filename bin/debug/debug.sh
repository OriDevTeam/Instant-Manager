#!/bin/bash
settingsDir="../settings/settings.txt"
type=$1
number=$2

debugger_names=(
	"LLDB"
	"GDB"
)

debugger_scripts=(
	"lldb.sh"
	"gdb.sh"
)

source ../utilities/choice_menu.sh

debugger=$(cd ../settings && bash general debugger)
map_index="../../shared/locale/$locale/map/index"

if [ -z "$debugger" ]; then
	echo -e "Wich debugger to use?"
	showMenu ${debugger_names[@]}
	debuggerIndex=$selectedIndex
	debuggerScript="${debugger_scripts[$debuggerIndex]}"
fi

channel_paths=()
channel_names=()

# Channel Cores
pushd ../../configuration/channels/ > /dev/null

channels=(*/)
channels=("${channels[@]%/}")
for channel in ${channels[@]}
do
	cd $channel
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		pushd $core > /dev/null
		
		channelName="${channel^}-${core^}"
		channel_names+=($channelName)
		channel_paths+=("$channel/$core")
		
		popd > /dev/null
	done
	cd ../
done

popd > /dev/null

echo -e "Wich channel core to debug?"
showMenu ${channel_names[@]}
channelIndex=$selectedIndex
channelPath="${channel_paths[$channelIndex]}"

echo -e "Debugging with ${debugger_names[$selectedIndex]} on path $channelPath"

cd debuggers
bash $debuggerScript "channels/$channelPath" "core.6"

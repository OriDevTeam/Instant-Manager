#!/bin/bash

locale=$(cd ../settings/settings_values && bash locale)
map_index="../../shared/locale/$locale/map/index"

if [ -z $map_index ]; then
	echo "Missing map index on path: $map_index"
	echo "If this is the first manager run, please check for needed files."
	exit
fi

channel_types=(
	"number"
	"city"
	"99"
)

channel_stypes=(
	"channel"
	"channel_99"
	"auth"
)

for i in $(seq 1 $(cd ../settings/settings_values/ && bash channels_num));
	while IFS="" read -r p || [ -n "$p" ]
	do
		map_number=$(cut -d "	" -f 1 <<< $p)
		map_channel_type=$(cut -d "	" -f 3 <<< $p)
		
		if [[ $map_channel_type == *"99"* ]]; then
			channelType="channel"
		elif [ -n "$map_channel_type" ] && [ "$map_channel_type" -eq "$map_channel_type" ] 2>/dev/null; then then
			channelType="99"
		else
			channelType="city"
		fi
		
		bash create_channel.sh channel $i 1
		
	done < $map_index
done


if [ "$channelType" == "auth" ]; then
	channel="${channelType}"

	cores=("main")
elif [ "$channelType" == "channel_99" ]; then
	channel="${channelType}_${channel_number}"

	cores=("1" "2" "3")
else
	channel="${channelType}_${channel_number}"

	cores=("1" "2" "3" "city")
fi


for core in "${cores[@]}"
do
	core_name="core_${core}"
	
	bash create_channel_core.sh $channel $core_name $core
	
	cd ../../configure
done



#!/bin/bash
channel=$1

pushd "../../configuration/channels/" > /dev/null 

channelsList=(*/)
channelsList=("${channelsList[@]%/}")

for channelFolder in "${channelsList[@]}"
do 
	pushd "../../bin/configure/" > /dev/null
	
	source "./get_existing_map_indexes.sh"
	channels_map_index_list=$(bash get_available_map_indexes.sh $channelFolder)
	
	popd > /dev/null
	
	for index in "${channels_map_index_list[@]}"
	do
		if [ ! -v channels_map_index_list[index] ]; then
			unset 'map_list[index]'
			unset 'index_list[index]'
		fi
	done
	
done

popd > /dev/null

title="Pick the maps for $channel:"
chosen=$(bash multi_menu.sh "${#map_list[@]}" "${map_list[@]}" "${#index_list[@]}" "${index_list[@]}" "$title")

#chosen=$(echo "multi_menu.sh "${#map_list[@]}" "${map_list[@]}" "${#index_list[@]}" "${index_list[@]}" $title" | bash)

#bash multi_menu.sh "${#map_list[@]}" "${map_list[@]}" "${#index_list[@]}" "${index_list[@]}" "$title"

echo $chosen

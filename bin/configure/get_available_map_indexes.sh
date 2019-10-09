#!/bin/bash
channel=$1
channels_map_index_list=()

pushd "../../configuration/channels/$channel" > /dev/null

cores=(*/)
cores=("${cores[@]%/}")
for core in "${cores[@]}"
do
	pushd $core > /dev/null
	
	if [ -f "CONFIG" ]; then
		while IFS= read -r line
		do
			var=$(echo $line | cut -d ":" -f1)
			value=$(echo $line | cut -d ":" -f2)
			
			if [ "$var" == "MAP_ALLOW" ]; then
				IFS=' ' read -r -a cmiArray <<< "$value"
				for element in "${cmiArray[@]}"
				do
					channels_map_index_list+=($element)
				done
			fi
		done < "CONFIG"
	
	fi
		
	popd > /dev/null
done

popd > /dev/null

echo "${channels_map_index_list[@]}"

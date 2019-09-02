#!/bin/bash
# To use this script for now, call it using 'source' command
# declare two arrays with the names: options and result
# And fill both with same number of elements
# Chosen output will be elements from result array

channels_map_index_list=()
map_list=()
index_list=()
options=()
results=()

cd ../../configuration/channels/$channel/

cores=(*/)
cores=("${cores[@]%/}")
for core in "${cores[@]}"
do
	cd $core
	
	if [ -f "CONFIG" ]; then
		while IFS= read -r line
		do
			var=$(echo $line | cut -d ":" -f1)
			value=$(echo $line | cut -d ":" -f2)
			
			if [ "$var" == "MAP_ALLOW" ]; then
				IFS=' ' read -r -a cmiArray <<< "$value"
				for element in "${cmiArray[@]}"
				do
					channels_map_index_list[element]=1
				done
			fi
		done < "CONFIG"
	fi
		
	cd ../
done

cd ../../../bin/configure/

source ./get_existing_map_indexes.sh

cd ../../../../bin/

options=("${map_list[@]}")
results=("${index_list[@]}")

source ./configure/multi_menu.sh


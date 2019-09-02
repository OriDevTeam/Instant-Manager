#!/bin/bash
# To use this script for now, call it using 'source' command
# declare two arrays with the names: options and result
# And fill both with same number of elements
# Output will be written in arrays map_list and index_list 

cd ../settings/settings_values/
locale=$(sh locale)

cd ../../../shared/locale/$locale/map/

while IFS= read -r line
do
	index=$(echo $line | cut -d " " -f1)
	map=$(echo $line | cut -d " " -f2)
	
	if [[ ! -z "$index" && "$map" ]] ; then
		if [[ ! -v "channels_map_index_list[index]" ]] ; then
			map_list+=($map)
			index_list+=($index)
		fi
	fi
done < "index"


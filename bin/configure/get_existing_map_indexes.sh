#!/bin/bash
# To use this script for now, call it using 'source' command
# declare two arrays with the names: options and result
# And fill both with same number of elements
# Output will be written in arrays map_list and index_list 

pushd "../settings/settings_values/" > /dev/null
locale=$(bash locale)
popd > /dev/null

pushd "../../shared/locale/$locale/map/" > /dev/null

while IFS= read -r line
do
	index=$(echo $line | cut -d " " -f1)
	map=$(echo $line | cut -d " " -f2)
	
	if [[ ! -z "$index" && "$map" ]] ; then
		map_list[index]=$map
		index_list[index]=$index
	fi
done < "index"

popd > /dev/null
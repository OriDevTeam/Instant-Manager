#!bin/bash

locale=$(cd ../settings && bash get_setting.sh general locale)
map_index_file="../../shared/locale/$locale/map/index"

mapsInfo=()

core_type_names=(
	"City"
	"Normal"
	"Special(99)"
)

core_types=(
	"city"
	"normal"
	"special"
)

pushd "../../shared/locale/$locale/map/" > /dev/null

maps=(*/*/)
maps=("${maps[@]%/}")

popd > /dev/null

for map in ${maps[@]}
do
	clear
	read -r -p "Set up $map? (y/n): " response   
	if [ "$response" != "${response#[Yy]}" ]; then
		read -p "Map Index: " prompt
		while [ ! "$prompt" -eq "$prompt" ] 2> /dev/null; do
			read -p "Map Index: " map_index
		done
		
			
		echo -e "\e[32mWhat's the type of core for this map?\e[0m"
		
		
		source ../utilities/choice_menu.sh
		showMenu ${core_type_names[@]}
		
		mapsInfo+=("${prompt}:${map}:${core_types[$selectedIndex]}")
	fi
done

rm -rf $map_index_file

for mapInfo in ${mapsInfo[@]}
do
	index=$(cut -d ":" -f1 <<< $mapInfo)
	name=$(cut -d ":" -f2 <<< $mapInfo)
	core_type=$(cut -d ":" -f3 <<< $mapInfo)
	
	echo "${index}	${name}	${core_type}" >> $map_index_file
done

echo -e "\e[33mMap index saved in $map_index_file\e[0m"

#!bin/bash
pushd "../" > /dev/null

## Check necessary folders
folder=(
"shared/data"
"shared/locale"
"shared/package"
)
necessaryFolders=()

for folder in "${folder[@]}"
do
    if [ ! -d $folder ]; then
        necessaryFolders+=($folder)
    fi
done

if (( ${#necessaryFolders[@]} )); then
	echo "There is necessary folders needed to run the server properly, heres which:"
	
	for folder in "${necessaryFolders[@]}"
	do
		echo " - $folder"
	done
	
	exit
fi

popd > /dev/null

## Settings file exist, if not prompt creation
if [ ! -f "settings/settings.txt" ] || [ ! -d "../configuration" ]; then
	echo -e "\e[36mIt seems to be the first time running the manager"
	echo -ne "Would you like to make configuration? (y/n):\e[0m "
	read answer
	echo ""
	
	if [ "$answer" != "${answer#[Yy]}" ]; then
		pushd "configure/" > /dev/null
		bash create_settings.sh
		bash create_map_index.sh
		bash auto_create_channels.sh
		popd > /dev/null
	fi
fi


locale=$(cd settings/settings_values && bash locale)
env=$(cd settings/settings_values && bash env_path)
game_bin=$(cd settings/settings_values && bash game_bin)
db_bin=$(cd settings/settings_values && bash db_bin)
qc_bin=$(cd settings/settings_values && bash qc_bin)

pushd "../" > /dev/null

files=(
"shared/envs/$env/$game_bin"
"shared/envs/$env/$db_bin"
"shared/envs/$env/$qc_bin"
"shared/locale/$locale/map/index"
"shared/CMD"
)

for file in "${files[@]}"
do
    if [ ! -f $file ]; then
        necessaryFiles+=($file)
    fi
done

if (( ${#necessaryFiles[@]} )); then
	echo "There is necessary files needed to run the server properly, heres which:"
	
	for file in "${necessaryFiles[@]}"
	do
		echo " - $file"
	done
	
	exit
fi

popd > /dev/null

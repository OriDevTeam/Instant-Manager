#!bin/bash
pushd "../" > /dev/null

## Check necessary folders
folder=(configuration source shared)
for i in "${folder[@]}"
do
    if [ ! -d $i ]; then
        mkdir $i
    fi
done

## Settings file exist, if not prompt creation
if [ ! -f "settings/settings.txt" ] && [ ! -d "configuration" ]; then
	echo "It seems to be the first time running the manager"
	echo -ne "Would you like to make configuration? (y/n):"
	read answer
	
	if [ "$answer" != "${answer#[Yy]}" ]; then
		push "configure/"
		bash create_settings.sh &
		bash auto_create_channels.sh
		popd
	fi
fi

popd > /dev/null
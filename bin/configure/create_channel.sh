#!/bin/bash
channelType=$1
channel_number=$2
skipOverwriteCheck=$3

channel_types=(
	"Normal"
	"Special(99)"
	"Auth"
)

channel_stypes=(
	"channel"
	"channel_99"
	"auth"
)

if [ -z "$channelType" ]; then
	source ./choice_menu.sh
	showMenu ${channel_types[@]}

	channelType="${channel_stypes[$selectedIndex]}"
fi

if [ -z "$channel_number" ]; then
	read -p 'Whats the channel number?: ' channel_number
fi

echo -e "Hey"

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

echo -e "Low"

if [[ -d ../../configuration/channels/$channel ]] && [[ ! "$skipOverwriteCheck" -eq 1 ]]; then
	echo -e "\e[36mThe Channel '$channel' directory already exists"
	echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
	read answer
fi

if [ "$answer" != "${answer#[Yy]}" ] || [[ ! "$skipOverwriteCheck" -eq 1 ]]; then
	rm -rf ../../configuration/channels/$channel
else
	exit
fi

echo -e "xD"

for core_name in "${cores[@]}"
do
	core="core_${core_name}"
	
	source ./create_channel_core.sh
	
	cd ../../configure
done


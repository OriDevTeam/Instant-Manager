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
	source ../utilities/choice_menu.sh
	showMenu ${channel_types[@]}

	channelType="${channel_stypes[$selectedIndex]}"
fi

if [ -z "$channel_number" ]; then
	read -p 'Whats the channel number?: ' channel_number
fi

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

if [[ -d ../../configuration/channels/$channel ]] && [[ ! "$skipOverwriteCheck" -eq 1 ]]; then
	echo -e "\e[36mThe Channel '$channel' directory already exists"
	echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
	read answer
else
	answer="pass"
fi


if [ "$answer" != "${answer#[Yy]}" ] || [[ ! "$skipOverwriteCheck" -eq 1 ]]; then
	rm -rf ../../configuration/channels/$channel
elif [ "$answer" = "pass" ]; then
	answer="passed"
else
	exit
fi

for core in "${cores[@]}"
do
	core_name="core_${core}"
	
	baseNum=0
	if [ "$channelType" != "auth" ]; then
		map_allow=$(bash pick_maps.sh $channel)
		core="0"
	elif [ "$channelType" == "channel_99" ]; then
		baseNum=70
	fi
	
	bash create_channel_core.sh $channel $channel_number $core $core_name $map_allow
done


#!/bin/bash

locale=$(cd ../settings/ && bash get_setting.sh general locale)
map_index="../../shared/locale/$locale/map/index"
channel_count=$1
channel_special_count=$2

if [ -z $map_index ]; then
	echo "Missing map index on path: $map_index"
	echo "If this is the first manager run, please check for needed files."
	exit
fi

if [ -d "../../configuration" ]; then
	echo -e "\e[36mThe configuration folder already exists"
	echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
	read answer
else
	answer="pass"
fi

if [ "$answer" != "${answer#[Yy]}" ]; then
	rm -rf ../../configuration
elif [ "$answer" = "pass" ]; then
	answer="passed"
else
	exit
fi

if [ -z "$channel_count" ]; then
	read -p 'How many channels to create?: ' channel_count
fi

if [ -z "$channel_special_count" ]; then
	read -p 'How many special channels(99) to create?: ' channel_special_count
fi

channel_normal_index_list=()
channel_city_index_list=()
channel_special_index_list=()

while IFS="" read -r p || [ -n "$p" ]
do
	map_number=$(cut -d "	" -f 1 <<< $p)
	map_channel_type=$(cut -d "	" -f 3 <<< $p)
	
	if [[ $map_channel_type == "city" ]]; then
		channel_city_index_list+=($map_number)
	elif [[ $map_channel_type == "special" ]]; then
		channel_special_index_list+=($map_number)
	else
		channel_normal_index_list+=($map_number)
	fi
done < $map_index


CreateChannel()
{
	channelType=$1; shift;
	channelPrefix=$1; shift;
	channelCount=$1; shift;
	channelArray=("$@")
	
	for ci in $(seq 1 $channelCount)
	do
		channel="${channelPrefix}_${ci}"
		
		if [ "$channelType" == "city" ]; then
			cores=("city")
		elif [ "$channelType" == "special" ]; then
			cores=("1" "2" "3")
		else
			cores=("1" "2" "3")
		fi
		
		idx=0
		for core in "${cores[@]}"
		do
			core_name="core_$core"
			
			map_allow_per_core=$(( ${#channelArray[@]} / ${#cores[@]} - 1))
			map_allow=""
			
			indx=$(( $map_allow_per_core * $idx ))
			
			for i in $(seq $(( $indx + $idx )) $(( $indx + $map_allow_per_core + $idx )))
			do
				if [ -z "${channelArray[i]}" ]; then
					break
				fi
				
				map_allow=$map_allow" "${channelArray[i]}
			done
			
			
			if [ -n "$map_allow" ]; then
				baseNum=0
				if [ $channelPrefix == "channel_99" ]; then
					baseNum=70
				fi
				
				if [ ! $core == "city" ]; then
					coreNum=$(($idx + 1))
				else
					coreNum="0"
				fi
				
				bash create_channel_core.sh $channel $ci $coreNum $core_name $baseNum "$map_allow"
			fi
			
			((idx+=1))
		done
	done
}

bash create_db.sh
bash create_channel.sh "auth" 1 0
CreateChannel "city" "channel" $channel_count "${channel_city_index_list[@]}"
CreateChannel "normal" "channel" $channel_count "${channel_normal_index_list[@]}"
CreateChannel "special" "channel_99" $channel_special_count "${channel_special_index_list[@]}"

echo -e "\e[33mChannels created sucessfully\e[0m"

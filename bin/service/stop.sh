#!/bin/bash

pushd "..settings/" > /dev/null

game_binary=$(bash get_setting.sh general game_bin)
db_binary=$(bash get_setting.sh general db_bin)
cores_num=$(bash get_setting.sh general cores_num)

popd > /dev/null

clear
echo -e "Stopping Server..."
echo -e ""

stop_core()
{
	binary_name=$1
	folder=$2
	p_text=$(echo $folder | tr '[:lower:]' '[:upper:]')
	corePath=$PWD
	
	if [[ $(cd ../../../../bin/service/ && bash cores/check_core_by_name "$p_text") != 1 ]]; then
		echo -e "\e[33m$p_text not running\e[0m" >&2
		return 1
	fi
	
	bash ../../../../bin/service/off.sh "$p_text" &
	
	elapsed=0
	
	while [[ $(cd ../../../../bin/service/ && bash cores/check_core_by_name "$p_text") == 1 ]]; do
		elapsed=$(($elapsed+1))

		#clear
		echo -e "Waiting $p_text termination" >&2
		echo -e "$elapsed seconds elapsed..." >&2
		echo
		
		delayBeforeFail=5
		if (( $elapsed >= $delayBeforeFail ))
		then
			echo -e "\e[31m$p_text wasn't terminated properly\e[0m" >&2
			echo -e "\e[33mCheck $corePath syserr/syslog or logs above for information.\e[0m" >&2
			return 0
		fi
		
		sleep 1
		#clear
	done
	
	echo -e "\e[32m$p_text terminated\e[0m" >&2
	return 1
}

cd ../../configuration/channels

channels=($(ls -rd */))
channels=("${channels[@]%/}")

for channel in ${channels[@]}
do
	pushd $channel > /dev/null
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		pushd $core > /dev/null
		
		sleep 1
		stop_core "$game_binary" "$channel"_"$core"
		sucess=$?
		[[ $sucess != 1 ]] && exit
		
		popd > /dev/null
	done
	
	popd > /dev/null
done

## Databases
cd ../databases

database=(*/)
database=("${database[@]%/}")
for database in ${database[@]}
do
	pushd $database > /dev/null
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		pushd $core > /dev/null
		
		sleep 1
		stop_core "$db_binary" "$database"_"$core"
		sucess=$?
		[[ $sucess != 1 ]] && exit
		
		popd > /dev/null
	done
	
	popd > /dev/null
done

echo -e "The server was turned off."

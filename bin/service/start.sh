#!/bin/bash

pushd "..settings/" > /dev/null

game_binary=$(bash get_settings.sh general game_bin)
db_binary=$(bash get_settings.sh general db_bin)

popd > /dev/null

#clear

available=$(bash ../external/mysql_available "account")
if [[ ! $available == 1 ]]; then
	echo -e "Database Server is unavailable, please be sure the"
	echo -e "MySQL server is running or configuration is correct."
	exit
fi

echo -e "Starting Server"
echo -e ""

sleep 1

start_core()
{
	binary_name=$1
	folder=$2
	p_text=$(echo $folder | tr '[:lower:]' '[:upper:]')
	#bash ../../../../bin/service/clean &
	bash ../../../../bin/service/on.sh "$p_text" &
	
	elapsed=0
	
	corePath=$PWD
	while [ $(cd ../../../../bin/service && bash cores/check_core "$corePath" $binary_name) == 0 ]; do
		elapsed=$(($elapsed+1))

		#clear
		echo -e "Waiting  $p_text initialization" >&2
		echo -e "$elapsed seconds elapsed..." >&2
		echo
		
		delayBeforeFail=5
		if (( $elapsed >= $delayBeforeFail ))
		then
			bash ../../../../bin/service/cores/stop_core "$binary_name" "$folder"
			echo -e "\e[31m$p_text wasn't initialized properly\e[0m" >&2
			echo -e "\e[33mCheck $corePath syserr/syslog or logs above for information.\e[0m" >&2
			return 0
		fi
		
		sleep 1
		#clear
	done
	
	echo -e "\e[32m$p_text initialized\e[0m" >&2
	return 1
}

cd ../../configuration/

## Databases
cd databases

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
		start_core "$db_binary" "$database"_"$core"
		sucess=$?
		[[ $sucess != 1 ]] && exit
		
		popd > /dev/null
	done
	
	popd > /dev/null
done

sleep 5

## Channels
cd ../channels

channels=(*/)
channels=("${channels[@]%/}")
for channel in ${channels[@]}
do
	pushd $channel > /dev/null
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		pushd $core > /dev/null
		
		start_core "$game_binary" "$channel"_"$core"
		sucess=$?
		[[ $sucess != 1 ]] && exit
		
		sleep 2
		
		popd > /dev/null
	done
	
	popd > /dev/null
done

echo -e "The server is online."

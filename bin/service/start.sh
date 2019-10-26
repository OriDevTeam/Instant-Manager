#!/bin/bash

game_binary=$(cd ../settings/settings_values && bash game_bin)
db_binary=$(cd ../settings/settings_values && bash db_bin)
cores_num=$(cd ../settings/settings_values && bash cores_num)

clear

available=$(bash ../external/mysql_available "mysql")
if [[ ! $available == 1 ]]; then
	echo -e "Database Server is unavailable, please be sure the"
	echo -e "MySQL server is running or configuration is correct"
	exit
fi

echo -e "Starting Server"
echo -e ""

sleep 1
#bash update_db

start_core()
{
	binary_name=$1
	folder=$2
	p_text=$(echo $folder | tr '[:lower:]' '[:upper:]')
	#bash ../../../../bin/service/clean &
	bash ../../../../bin/service/on.sh "$p_text" &
	
	elapsed=0
	
	corePath=$PWD
	while [ $(cd ../../../../bin/service && bash test_core "$corePath" $binary_name) == 0 ]; do
		elapsed=$(($elapsed+1))

		#clear
		echo -e "A aguardar resposta de $p_text"
		echo -e "$elapsed..."
		echo
		if [ $elapsed -gt 9 ]
		then
			echo
			echo -e "O $p_text não responde."
			echo -e "Pressione CTRL+C para cancelar."
		fi
		sleep 1
		#clear
	done
}

cd ../../configuration/

## Databases
cd databases

database=(*/)
database=("${database[@]%/}")
for database in ${database[@]}
do
	cd $database
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		cd $core
		sleep 2
		start_core "$db_binary" "$database"_"$core"
		cd ../
	done
	cd ../
done

## Channels
cd ../channels

channels=(*/)
channels=("${channels[@]%/}")
for channel in ${channels[@]}
do
	cd $channel
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		cd $core
		sleep 2
		start_core "$game_binary" "$channel"_"$core"
		cd ../
	done
	cd ../
done

echo -e "The server is online."

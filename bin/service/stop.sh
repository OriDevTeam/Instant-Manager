#!/bin/bash

game_binary=$(cd ../settings/settings_values && bash game_bin)
db_binary=$(cd ../settings/settings_values && bash db_bin)
cores_num=$(cd ../settings/settings_values && bash cores_num)

clear
echo -e "Stopping Server..."
echo -e ""

stop_core()
{
	binary_name=$1
	folder=$2
	p_text=$(echo $folder | tr '[:lower:]' '[:upper:]')
	bash ../../../../bin/service/off.sh &
	
	elapsed=0
	
	corePath=$PWD

	while [ $(cd ../../../../bin/service && bash test_core "$corePath" $binary_name) == 1 ]; do
		status=$(cd ../../../../bin/service && bash test_core "$corePath" $binary_name)
		echo -e "status: $status"
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
		clear
	done
	
	echo "Stopped $p_text"
}

cd ../../configuration/channels

channels=($(ls -rd */))
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
		stop_core "$game_binary" "$channel"_"$core"
		cd ../
	done
	cd ../
done

cd ../databases/db/core_main
stop_core "$db_binary" "db"

echo -e "The server was turned off."

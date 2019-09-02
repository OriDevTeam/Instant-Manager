#!/bin/sh

echo -ne "\e[33mService Status:\e[0m"
echo -e " \e[32mOnline\e[0m|\e[31mOffline\e[0m|\e[33mMalfunction\e[0m|\e[35mUnknown\e[0m"
echo -e "note: press ctrl+c to skip status check"
trap "echo -e ''; exit;" SIGINT SIGTERM

game_binary=$(cd ../settings/binaries && sh game_bin)
db_binary=$(cd ../settings/binaries && sh db_bin)
cores_num=$(cd ../settings/settings_values && sh cores_num)

cd ../../configuration/databases/db/

echo -ne "\e[33mDB -\e[0m"

cores=(*/)
cores=("${cores[@]%/}")
for core in ${cores[@]}
do
	
	cd $core
	#echo $PWD
	corePath=$PWD
	
	status=$(cd ../../../../bin/service && sh test_core "$corePath" $db_binary)
	case $status in
		0) echo -ne " \e[31m$core\e[0m";;
		1) echo -ne " \e[32m$core\e[0m";;
		2) echo -ne " \e[33m$core\e[0m";;
		*) echo -ne " \e[35m$core\e[0m";;
	esac
	
	cd ../
	
	echo -e ""
done

cd ../../channels/

channels=(*/)
channels=("${channels[@]%/}")

for channel in ${channels[@]}
do
	cd $channel
	
	echo -ne "\e[33m$channel -\e[0m"
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		cd $core
		corePath=$PWD
		
		status=$(cd ../../../../bin/service && sh test_core "$corePath" $game_binary)
		case $status in
			0) echo -ne " \e[31m$core\e[0m";;
			1) echo -ne " \e[32m$core\e[0m";;
			2) echo -ne " \e[33m$core\e[0m";;
			*) echo -ne " \e[35m$core\e[0m";;
		esac
	
		cd ../
	done
	
	echo -e ""
	
	cd ../
done

cd ../../bin/

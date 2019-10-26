#!/bin/sh
name=$1

GAME_BIN=$(cd ../../../../bin/settings/settings_values && sh game_bin)
ENV_PATH=$(cd ../../../../bin/settings/settings_values && sh env_path)

while ( : ) do
	
	DATE=`date +"%d.%m.%y.%T"`
	
	if [ ! -d logs/$DATE ]; then
		mkdir -p logs/$DATE
	fi
	
	if [ -w syslog.txt ]; then
		mv syslog.txt logs/$DATE/syslog.txt
	fi
	
	if [ -w syserr.txt ]; then
		mv syserr.txt logs/$DATE/syserr.txt
	fi
	
	echo "autogame starting game $DATE" >> syslog.txt
	echo "running" $GAME_BIN >> syslog.txt
	
	bash -c "exec -a $name ../../../../shared/envs/$ENV_PATH/$GAME_BIN"
  
	if [ -r $GAME_BIN.core ]; then
		mv $GAME_BIN.core cores/core-$DATE
	fi

	if [ ! -r .fastboot ]; then
		sleep 3
	else
		rm .fastboot
		sleep 3
	fi
	
	if [ -r .killscript ]; then
		echo "autoscript killed $DATE"  >> syslog.txt
		rm .killscript
		exit
	fi
	
	while [ -r pause ]; do
		sleep 60
	done

done

sh keepalive.sh "$name" &

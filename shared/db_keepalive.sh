#!/bin/sh

DB_BIN=$(cd ../../../../bin/settings/settings_values && sh db_bin)
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
	
	echo "autogame starting db $DATE" >> syslog.txt
	echo "running" $DB_BIN >> syslog.txt
	
	exec ../../../../shared/envs/$ENV_PATH/$DB_BIN
  
	if [ -r $DB_BIN.core ]; then
		mv $DB_BIN.core cores/core-$DATE
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

sh keepalive.sh &

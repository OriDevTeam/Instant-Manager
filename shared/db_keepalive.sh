#!/bin/sh
name=$1

pushd "../../../../bin/settings/"

DB_BIN=$(bash get_setting.sh general db_bin)
ENV_PATH=$(bash get_setting.sh general environment)

popd > /dev/null

while ( : ) do

	DATE=`date +"%d.%m.%y.%T"`
	
	echo "autogame starting db $DATE" >> syslog
	echo "running" $DB_BIN >> syslog
	
	bash -c "exec -a $name ../../../../shared/envs/$ENV_PATH/$DB_BIN"
  
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
		echo "autoscript killed $DATE"  >> syslog
		rm .killscript
		exit
	fi
	
	while [ -r pause ]; do
		sleep 60
	done

done

sh keepalive.sh "$name" &

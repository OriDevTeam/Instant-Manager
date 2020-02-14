#!/bin/sh
name=$1

pushd "../../../../bin/settings/" > /dev/null

GAME_BIN=$(bash general game_bin)
ENV_PATH=$(bash general environment)

popd > /dev/null

while ( : ) do
	
	DATE=`date +"%d.%m.%y.%T"`
	
	echo "autogame starting game $DATE" >> syslog
	echo "running" $GAME_BIN >> syslog
	
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
		echo "autoscript killed $DATE"  >> syslog
		rm .killscript
		exit
	fi
	
	while [ -r pause ]; do
		sleep 60
	done

done

sh keepalive.sh "$name" &

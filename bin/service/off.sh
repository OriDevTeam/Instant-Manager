#!/bin/bash
core_name=$1

if [ -z $core_name ]; then
	echo "No core name was provided"
	exit
fi

if [ -r keepalive.sh ]; then
	mv keepalive.sh keepalive.sh.off
fi

bash ../../../../bin/external/namekill "$core_name"

if [ -r ./pid ]; then
	touch .killscript
fi

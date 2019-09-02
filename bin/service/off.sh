#!/bin/sh

if [ -r keepalive.sh ]; then
	mv keepalive.sh keepalive.sh.off
fi

if [ -r ./pid ]; then
	touch .killscript
	sh ../../../../bin/external/prockill `cat ./pid`
fi

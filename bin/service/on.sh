#!/bin/bash
name=$1

if [ -r keepalive.sh.off ]; then
	mv keepalive.sh.off keepalive.sh
fi

bash keepalive.sh "$name" &

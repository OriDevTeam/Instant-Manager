#!/bin/bash

if [ -r keepalive.sh.off ]; then
  mv keepalive.sh.off keepalive.sh
fi

#echo "$PWD"
bash keepalive.sh &

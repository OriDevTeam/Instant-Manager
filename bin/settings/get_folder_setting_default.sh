#!/bin/bash
settingsDescriptionFilePath=$1
configurationToken=$2

line=$(grep -F "$configurationToken" $settingsDescriptionFilePath)

if [ -z "$line" ]; then
	echo "Token $configurationToken not found in $settingsDescriptionFilePath" >&2
	exit 0
fi

default=$(echo $line | cut -d ":" -f3)

if [ -z "$default" ]; then
	exit 0
fi

echo $default
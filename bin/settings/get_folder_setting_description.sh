#!/bin/bash
settingsDescriptionFilePath=$1
configurationToken=$2

line=$(grep -F "$configurationToken" $settingsDescriptionFilePath)

if [ -z "$line" ]; then
	echo "Token $configurationToken not found in $settingsDescriptionFilePath" >&2
	exit 0
fi

description=$(echo $line | cut -d ":" -f2)

if [ -z "$description" ]; then
	exit 0
fi

echo $description
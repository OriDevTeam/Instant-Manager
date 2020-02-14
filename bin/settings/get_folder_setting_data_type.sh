#!/bin/bash
settingsFilePath=$1
configurationToken=$2

line=$(grep -F "$configurationToken" $settingsFilePath)

if [ -z "$line" ]; then
	echo "Token $configurationToken not found in $settingsFilePath" >&2
	exit 0
fi

dataType=$(echo $line | cut -d ":" -f4)

if [ -z "$dataType" ]; then
	
	case $dataType in
		''|*[!0-9]*)
			echo "Token is broken, see below:" >&2
			echo "$line" >&2
			echo "Be sure the setting format is like: Token:Value:Enabled:DataType" >&2
			echo "                                    TOKEN:value:<0:1>:<str:int:pw>:" >&2
			;;
		*)
			echo "Token is disabled" >&2
			;;
	esac
	
	exit 0
fi

echo $dataType
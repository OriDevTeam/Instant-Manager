#!/bin/bash
settingsDescriptionFilePath=$1
configurationToken=$2

line=$(grep -F "$configurationToken" $settingsDescriptionFilePath)

if [ -z "$line" ]; then
	echo "Cores Token '$configurationToken' not found in $settingsDescriptionFilePath" >&2
	echo ""
	exit
fi

configuration="$(echo $line | awk -F '::' '{print $2}')"

if [ -z "$configuration" ]; then
	echo "Cores token '$configurationToken' is broken, see below " >&2
	echo "$configuration" >&2
	echo "Be sure the setting format is like: Token::Value" >&2
	echo "                                    TOKEN::value" >&2
	echo ""
	exit
fi

echo "$configuration"

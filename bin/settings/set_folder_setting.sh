#!/bin/bash
settingsFilePath=$1
settingsToken=$2
valueToSet=$3
toggleEnable=$4
dataType=$5
addNewIfMissing=$6

lineIndex=$(grep -n "$settingsToken" $settingsFilePath | head -n 1 | cut -d: -f1)
line=$(grep -F "$settingsToken" $settingsFilePath)

if [ -z $lineIndex ]; then
	if [ -z $addNewIfMissing ]; then
		echo "Token $settingsToken not found in $settingsFilePath" >&2
		exit 0
	fi
	
	if [ -z $dataType ]; then
		echo "DataType not provided for new setting creation" >&2
		exit 0
	fi
	
	echo "$settingsToken:$valueToSet:$toggleEnable:$dataType:" >> $settingsFilePath
	exit 1
fi

value=$(echo awk $line | cut -d ":" -f2)
enabled=$(echo awk $line | cut -d ":" -f3)

newLine="$settingsToken:$valueToSet:$toggleEnable:$dataType:"
#echo $newLine >&2

# Replace the line of the given line number with the given replacement in the given file.
function replace-line-in-file() {
    local file="$1"
    local line_num="$2"
    local replacement="$3"
	
    # Escape backslash, forward slash and ampersand for use as a sed replacement.
    replacement_escaped=$( echo "$replacement" | sed -e 's/[\/&]/\\&/g' )
	
    sed -i '' -e "${line_num}s/.*/$replacement_escaped/" "$file"
}

replace-line-in-file "$settingsFilePath" "$lineIndex" "$newLine"

exit 1


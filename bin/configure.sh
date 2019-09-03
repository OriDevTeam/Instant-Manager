#!/bin/sh
echo -e "\e[33mConfiguration Manager:\e[0m"

PS3='What to do?: '
options=("Settings" "Channels" "Backups" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd configure && sh settings.sh
            break
			;;
		2)
			cd configure && sh channels.sh
            break
			;;
		3)
			cd configure && sh backups.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

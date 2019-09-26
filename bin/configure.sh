#!/bin/bash
echo -e "\e[33mConfiguration Manager:\e[0m"

PS3='What to do?: '
options=("Settings" "Channels" "Backups" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd configure && bash settings.sh
            break
			;;
		2)
			cd configure && bash channels.sh
            break
			;;
		3)
			cd configure && bash backups.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

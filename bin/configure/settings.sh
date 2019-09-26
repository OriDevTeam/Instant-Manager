#!/bin/bash
echo -e "\e[33mSettings Manager:\e[0m"

PS3='What to do?: '
options=("Create Settings" "Default Settings" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			bash create_settings.sh
            break
			;;
		2)
			bash channels.sh
            break
			;;
		3)
			bash backups.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

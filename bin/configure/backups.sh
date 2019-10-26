#!/bin/bash
echo -e "\e[33mBackup Configuration Manager(Unavailable):\e[0m"

PS3='What to do?: '
options=("General Settings" "Schedule" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			echo "Unavailable action"
            break
            ;;
        2)
			echo "Unavailable action"
            break
            ;;
		3)
			echo "Unavailable action"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

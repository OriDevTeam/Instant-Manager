#!/bin/bash
echo -e "\e[33mDebug Manager:\e[0m"
echo -e "Debugger configured:\e[32m None \e[0m"
echo -e "Wich core to debug?"
PS3='What to do?: '
options=("Database" "Channel" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd debug
			bash debug.sh
            break
			;;
		2)
            break
			;;
		3)
			break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

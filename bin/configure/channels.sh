#!/bin/bash
echo -e "\e[33mChannel Configuration Manager:\e[0m"

PS3='What to do?: '
options=("Automatic Channel Configuration" "Create Channel" "Create Database Core" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			#echo -e "This operation still requires the maps for each core to be selected"
			bash auto_create_channels.sh
            break
            ;;
        2)
			bash create_channel.sh
            break
            ;;
		3)
			bash create_db.sh
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

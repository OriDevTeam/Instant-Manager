#!/bin/sh
echo -e "\e[33mChannel Configuration Manager:\e[0m"

PS3='What to do?: '
options=("Automatic Channel Configuration" "Create Channel" "Create Database Core" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			echo -e "This operation still requires the maps for each core to be selected"
			sleep 3
			
			sh create_db.sh 1
			sh create_channel.sh auth 1 1
			
			for i in $(seq 1 $(cd ../settings/settings_values/ && sh channels_num)); do sh create_channel.sh channel $i 1; done
			for i in $(seq 1 $(cd ../settings/settings_values/ && sh channels_99_num)); do sh create_channel.sh channel_99 $i 1; done

            break
            ;;
        2)
			sh create_channel.sh
            break
            ;;
		3)
			sh create_db.sh
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
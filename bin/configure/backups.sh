#!/bin/sh
echo -e "\e[33mBackup Configuration Manager:\e[0m"

PS3='What to do?: '
options=("General Settings" "Schedule" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			echo -e "This operation still requires the maps for each core are selected"
			sleep 3
			sh create_db.sh 1
			
			sh create_channel.sh auth 1 1
			
			for i in $(seq 1 4); do sh create_channel.sh channel $i 1; done
			for i in $(seq 1 3); do sh create_channel.sh channel_99 $i 1; done

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
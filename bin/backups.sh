#!/bin/bash
echo -e "\e[33mBackup Manager:\e[0m"

PS3='What to do?: '
options=("Do Backup" "Restore Backup" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd backups && bash do_backup.sh
            break
			;;
		2)
			cd backups && bash restore_backup.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

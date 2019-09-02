#!/bin/sh
echo -e "\e[33mBackup Manager:\e[0m"

PS3='What to do?: '
options=("Do Backup" "Restore Backup" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd backups && sh do_backup.sh
            break
			;;
		2)
			cd backups && sh restore_backup.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

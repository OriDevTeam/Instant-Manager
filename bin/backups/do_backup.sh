#!/bin/sh
PS3='What backup to do?: '
options=("Full(SQL-LOGS)" "SQL" "LOGS" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			cd ../external/ && sh backup_sql "all"
			sh backup_cores_logs.sh
            break
			;;
		2)
			cd ../external/ && sh backup_sql "all"
            break
			;;
		3)
			sh backup_cores_logs.sh
            break
			;;
        *) echo "invalid option $REPLY";;
    esac
done
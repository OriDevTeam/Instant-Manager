#!/bin/sh
cd service && sh status.sh

PS3='What to do?: '
options=("Start" "Stop" "Restart" "Generate TXT(from DB)" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
			#echo "$PWD"
			sh start.sh
            break
            ;;
        2)
			sh stop.sh
            break
            ;;
        3)
            sh restart.sh
			break
            ;;
		4)
            sh update_db.sh
			break
            ;;
		5)
			break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#!/bin/bash
cd service && bash status.sh

PS3='What to do?: '
options=("Start" "Stop" "Restart" "Generate TXT(from DB)" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
			bash start.sh
            break
            ;;
        2)
			bash stop.sh
            break
            ;;
        3)
            bash restart.sh
			break
            ;;
		4)
            bash update_db.sh
			break
            ;;
		5)
			break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

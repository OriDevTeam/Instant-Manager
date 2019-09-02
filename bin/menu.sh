#!/bin/sh
title=`cat title.txt`
echo -e "$title"

echo -e "\e[32mPlaying: Basshunter - Welcome to Rainbow\e[0m"
mpg123 -q -f 6000 musics/basshunter_rainbow.mp3 > /dev/null &
playerPid=$!

PS3='What to manage?: '
options=("Service" "Questing" "Configure" "Backups" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
        1)
			sh service.sh
            break
            ;;
        2)
			sh quest.sh
            break
            ;;
        3)
            sh configure.sh
			break
            ;;
		4)
            sh backups.sh
			break
            ;;
        5)
			break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

sh external/winkill $playerPid

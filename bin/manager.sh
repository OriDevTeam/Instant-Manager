#!/usr/local/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
	CYGWIN* | MINGW*)	[ $(bash external/is_admin) == 0 ] && echo "warning: adminstrator privileges are required";;
	FreeBSD*)	echo "Requires X permissions";;
	Linux*)		echo "Requires X Permissions";;
esac

mpg123=`command -v mpg123`
if [ ! -v $mpg123 ]; then
	echo -e "\e[32mPlaying: Basshunter - Welcome to Rainbow\e[0m"
	$mpg123 -q -f 6000 musics/basshunter_rainbow.mp3 > /dev/null &
	playerPid=$!
fi

PS3='What to manage?: '
options=("Service" "Questing" "Configure" "Debug" "Backups" "Update" "Quit")
select opt in "${options[@]}"
do
	echo ""
    case $REPLY in
        1)
			bash service.sh
            break
            ;;
        2)
			bash questing.sh
            break
            ;;
        3)
            bash configure.sh
			break
            ;;
		4)
            bash debug.sh
			break
            ;;
		
		5)
            bash backups.sh
			break
            ;;	
        6)
			bash update.sh
			break
            ;;
		7)
			break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

if [ ! -z $playedPid ]; then
	bash external/winkill $playerPid
fi

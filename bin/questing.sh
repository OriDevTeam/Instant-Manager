#!/bin/bash
cd questing

locale=$(cd ../settings/ && bash get_setting.sh general locale)
questObjectDir="../../shared/locale/$locale/quest/object/"

pushd "$questObjectDir" > /dev/null
pushd "state/" > /dev/null

installedQuests=(*)
installedQuests=("${installedQuests[@]%/}")

popd > /dev/null

echo -e "\e[33mQuesting Manager(Installed Quests: ${#installedQuests[@]})\e[0m"
echo ""
popd > /dev/null

PS3='What to do?: '
options=("Reload Quests" "Add Quests" "Remove Quests" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			bash reload_quests.sh
            break
			;;
		2)
			bash add_quests.sh
			break
			;;
		3)
			bash remove_quests.sh
			break
			;;
		4)
			break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

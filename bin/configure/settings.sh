#!/bin/bash
echo -e "\e[33mSettings Manager:\e[0m"

PS3='What to do?: '
options=("Select Available Settings" "Create Settings" "Default Settings" "Create Map Index List" "Quit")
select opt in "${options[@]}"
do
    case $REPLY in
		1)
			
			settingsDir="../settings/settings_folder.txt"
			settingsFolderDir="../../shared/settings/"
			settingsName="default"
			
			pushd $settingsFolderDir > /dev/null
			
			availableSettings=(*/)
			availableSettings=("${availableSettings[@]%/}")
			
			popd > /dev/null
			
			source ../utilities/choice_menu.sh
			showMenu ${availableSettings[@]}
			
			settingsName="${availableSettings[$selectedIndex]}"
			
			echo "$settingsName" > $settingsDir
			echo "Settings folder was set to ${settingsFolderDir}${settingsName}"
			
			break
			;;
		2)
			bash create_settings.sh
            break
			;;
		3)
			echo ""
			
			echo $PWD
			
			settingsDir="../settings/settings_folder.txt"
			settingsFolderDir="../../shared/settings/"
			settingsName="default"
			
			if [ -f "${settingsFolderDir}${settingsName}" ]; then
				echo "Default settings folder doesn't exist."
				echo "Please get this at Instant-Manager Git repository"
				echo "or press 'Update' at the beggining of the Menu"
				exit
			fi
			
			echo "$settingsName" > $settingsDir
			echo "Settings folder was set to ${settingsFolderDir}${settingsName}"
			break
			;;
		4)
			bash create_map_index.sh
			break
			;;
		5)
			break
			;;
        *) echo "invalid option $REPLY";;
    esac
done

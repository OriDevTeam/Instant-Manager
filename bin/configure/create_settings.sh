#!/bin/bash
settingsDir="../settings/settings_folder.txt"
settingsFolderPath=$(awk 'NR==1 {print; exit}' $settingsDir)

if [ -f $settingsDir ]; then
	
	settingsFolderDir="../../shared/settings/"
	settingsFolder=$(awk 'NR==1 {print; exit}' $settingsDir)
		
	echo -ne "\e[36mWhats the new settings name?:\e[0m "
	read settingsName

	if [ -z $settingsName ]; then
		echo "No settings name specified, stopping..."
		exit 0
	fi
	
	if [ ! -z $settingsFolder ] && [ -d "${settingsFolderDir}${settingsName}/" ]; then
		if [ $settingsFolder != "default" ] || [ $settingsName != "default" ]; then
		
			echo -e "\e[36mThe Settings folder '$settingsName' already exists"
			echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
			
			read answer
			if [ "$answer" != "${answer#[Yy]}" ]; then
				rm -r "${settingsFolderDir}${settingsName}/"
			else
				echo "Aborted Settings creation."
				exit 0
			fi
		fi
	fi

	echo "Copying 'default' configuration to '$settingsName' ..."
	cp -rf "${settingsFolderDir}default" "${settingsFolderDir}${settingsName}"
	
fi

echo "$settingsName" > $settingsDir
echo "Settings folder was set to '$settingsName' in $settingsDir"

createSetting()
{
	settingFile=$1
	
	cd ../settings
	availableSettings=($(bash list_available_structure_settings.sh $settingFile))
	
	for setting in "${availableSettings[@]}"
	do
		dataType=$(bash get_setting_data_type.sh $settingFile $setting)
		description=$(bash get_setting_description.sh $settingFile $setting)
		default=$(bash get_setting_default.sh $settingFile $setting)
		default=$(eval $default)
		
		if [ -z "$dataType" ]; then
			echo "No data type available for '$setting', please check integrity"
			echo "of the settings structure, as this may be an important setting."
			exit
		fi
		
		if [ -z "$description" ]; then
			echo "No description available for '$setting', please check integrity"
			echo "of the settings description, as this may be an important setting."
			exit
		fi
		
		case $dataType in
			"str")
					dialog="$description (leave empty for default '$default'): "
					read -p "$dialog" -i "$default" inputValue
					
					if [ -z $inputValue ]; then
						#inputValue=$($default | tr '[:upper:]' '[:lower:]')
						inputValue=$default
					fi
				;;
			"int")
					
				;;
			"pw")
				echo -ne "Would you like to generate a random password for $description Password? (y/n): "
				read answer
				
				if [ "$answer" != "${answer#[Yy]}" ]; then
					inputValue=$(openssl rand -base64 16)
				else
					echo -ne "Type the password(input is hidden): "
					read -s inputValue
					echo -e ""
					
					if [ -z $inputValue ]; then
						echo "No password provided, setting to default"
						inputValue="$default"
					fi
				fi
				;;
			*)
				echo "Unknown Data Type $dataType"
				echo "Please pick one of the available data types"
				echo "And retry the auto configuration"
				exit 0
				;;
		esac
		
		sucess=$(bash set_setting.sh $settingFile "$setting" "$inputValue" 1 $dataType 1)
	done
}

echo -e ""
echo -e "\e[36mGeneral Settings:\e[0m"
createSetting "general"

echo -e ""
echo -e "\e[36mDatabase Settings:\e[0m"
createSetting "database"

echo -e ""
echo -e "\e[36mChannels Settings:\e[0m"
createSetting "channels"

echo "Settings saved in ${settingsFolderDir}${settingsName}/"

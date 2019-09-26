#!/bin/bash
settingsDir="../settings/settings.txt"

if [ -f $settingsDir ]; then
	echo -e "\e[36mThe Settings file already exists"
	echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
	
	read answer
	if [ "$answer" != "${answer#[Yy]}" ]; then
		rm $settingsDir
	else
		exit
	fi
fi

read -p 'Environment folder name: ' environment
read -p 'Locale folder name: ' locale
read -p 'Bind IP: ' bind_ip
read -p 'SQL Database IP: ' db_ip
read -p 'SQL Database Port: ' db_port
read -p 'SQL Database User: ' db_user

echo -ne "Would you like to generate a random password for SQL Database Password? (y/n): "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	db_password=$(openssl rand -base64 16)
	#echo "Generated password: $db_password"
else
	echo -ne "Type the password(input is hidden): "
	read -s db_password
	echo -e ""
fi

read -p 'Base Game Port(where core ports are based): ' base_game_port
read -p 'Base Game 99 Port(where core ports are based): ' base_game_99_port
read -p 'Adminpage IP: ' adminpage_ip

echo -ne "Would you like to generate a random password for Adminpage Password? (y/n): "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	adminpage_password=$(openssl rand -base64 16)
	#echo "Generated password: $adminpage_password"
else
	echo -ne "Type the password(input is hidden): "
	read -s adminpage_password
	echo -e ""
fi

read -p 'Mall URL: ' mall_url
read -p 'Backup Databases: ' backup_databases

echo ""
echo -e "\e[32mAre you sure of these settings:\e[0m"
echo "Environment folder name: $environment"
echo "Locale folder name: $locale"
echo "Bind IP: $bind_ip"
echo "SQL Database IP: $db_ip"
echo "SQL Database Port: $db_port"
echo "SQL Database User: $db_user"
echo "SQL Database Password: (hidden)"
echo "Base Game Port: $base_game_port"
echo "Base Game 99 Port: $base_game_99_port"
echo "Adminpage IP: $adminpage_ip"
echo "Adminpage Password: (hidden)"
echo "Mall URL: $mall_url"
echo "Backup Databases: $backup_databases"
echo ""

echo -ne "\e[32mSave settings? (y/n): \e[0m"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	echo "environment=$environment" >> $settingsDir
	echo "locale=$locale" >> $settingsDir
	echo "channels=1" >> $settingsDir
	echo "channels_99=1" >> $settingsDir
	echo "cores=4" >> $settingsDir
	echo "bind_ip=$db_ip" >> $settingsDir
	echo "db_ip=$db_ip" >> $settingsDir
	echo "db_port=$db_port" >> $settingsDir
	echo "db_user=$db_user" >> $settingsDir
	echo "db_password=$db_password" >> $settingsDir
	echo "base_game_port=$base_game_port" >> $settingsDir
	echo "base_game_99_port=$base_game_99_port" >> $settingsDir
	echo "adminpage_ip=$adminpage_ip" >> $settingsDir
	echo "adminpage_password=$adminpage_password" >> $settingsDir
	echo "mall_url=$mall_url" >> $settingsDir
	echo "backup_databases=$backup_databases" >> $settingsDir
	echo -e "\e[33mSettings saved in $settingsDir\e[0m"
fi


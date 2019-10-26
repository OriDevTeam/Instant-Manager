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

env_dialog="Environment folder name(leave empty for detected $(uname -o)): "
read -p "$env_dialog" -i "$uname -o" environment
if [ -z $environment ]; then
	environment=$(uname -o | tr '[:upper:]' '[:lower:]')
fi

read -p 'Locale folder name: ' locale
read -p 'Bind IP: ' bind_ip
read -p 'SQL Database IP(leave empty for default localhost): ' db_ip
if [ -z $db_ip ]; then
	db_ip="localhost"
fi
read -p 'SQL Database Port(leave empty for default 29999): ' db_port
if [ -z $db_port ]; then
	db_port="29999"
fi

read -p 'SQL Database User: ' db_user

echo -ne "Would you like to generate a random password for SQL Database Password? (y/n): "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	db_password=$(openssl rand -base64 16)
	db_password_generated=1
	#echo "Generated password: $db_password"
else
	echo -ne "Type the password(input is hidden): "
	read -s db_password
	echo -e ""
fi

read -p 'Base Game Port(where core ports are based of, default 20000): ' base_game_port
if [ -z $base_game_port ]; then
	base_game_port="20000"
fi

read -p 'Base Game 99 Port(where core ports are based of, default 20000): ' base_game_99_port
if [ -z $base_game_99_port ]; then
	base_game_99_port="20000"
fi

read -p 'Adminpage IP: ' adminpage_ip

echo -ne "Would you like to generate a random password for Adminpage Password? (y/n): "
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
	adminpage_password=$(openssl rand -base64 16)
	adminpage_password_generate=1
	#echo "Generated password: $adminpage_password"
else
	echo -ne "Type the password(input is hidden): "
	read -s adminpage_password
	echo -e ""
fi

read -p 'Mall URL: ' mall_url
read -p "Backup Databases(default is account common log player): " backup_databases
if [ -z $backup_databases ]; then
	backup_databases="account common log player"
fi

echo ""
echo -e "\e[32mAre you sure of these settings:\e[0m"
echo "Environment folder name: $environment"
echo "Locale folder name: $locale"
echo "Bind IP: $bind_ip"
echo "SQL Database IP: $db_ip"
echo "SQL Database Port: $db_port"
echo "SQL Database User: $db_user"
echo -ne "SQL Database Password: "
[[ $db_password_generated -eq 1 ]]; echo "$db_password" || echo "(hidden)"
echo "Base Game Port: $base_game_port"
echo "Base Game 99 Port: $base_game_99_port"
echo "Adminpage IP: $adminpage_ip"
echo -ne "Adminpage Password: "
[[ $adminpage_password_generate -eq 1 ]]; echo "$adminpage_password" || echo "(hidden)"
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
	echo "bind_ip=$bind_ip" >> $settingsDir
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
	echo "db_bin=db" >> $settingsDir
	echo "game_bin=game" >> $settingsDir
	echo "qc_bin=qc" >> $settingsDir
	echo -e "\e[33mSettings saved in $settingsDir\e[0m"
fi


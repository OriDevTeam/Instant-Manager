#!bin/bash
## This script is required to be Unix EOL(LF)
## to run and make the rest os the scripts compatible
os=$(uname -s)

bash=$(command -v bash)

if [ -z $bash ]; then
	if [[ $os == "CYGWIN" ]]; then
		install_cmd="apt-cyg"
		install_cmd_args="apt-cyg install bash"
	elif [[ $os =~ "MINGW" ]]; then
		install_cmd="pacman"
		install_cmd_args="pacman -S bash"
	elif [[ $os == "Linux" ]]; then
		install_cmd="apt-get"
		install_cmd_args="apt-get install bash"
	elif [[ $os == "FreeBSD" ]]; then
		install_cmd="pkg"
		install_cmd_args="pkg install bash"
	else
		install_cmd="none"
		install_cmd_args="none"
	fi
	
	echo "Bash needs to be installed to run this tool"
	echo "Attempting Bash install"
	
	command_exists=$(command -v $install_cmd)
	if [ -z $command_exists ]; then
		echo "Command '$install_cmd' doesn't exist,"
		echo "Try to install Bash manually and run the tool again after."
	else
		if [[ $EUID -ne 0 ]]; then
			echo "There is not enough permissions to run the following command:"
			echo "$install_cmd"
			echo "Please run the menu the first time with enough permissions"
			exit
		else
			echo "Installing Bash"
			$install_cmd_args
		fi
	fi
	
fi

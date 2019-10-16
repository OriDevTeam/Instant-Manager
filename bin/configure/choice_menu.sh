showMenu() {
	while [ ! "$SelectedItem" ]; do
		local arr=("${@}")
		local arrLen="${#arr[@]}"-1
		for ((n=0; n<=$arrLen; n++))
		do
			echo "$((n+1))) ${arr[$n]}"
		done
		
		# info: the amount of chars it listens for is hardcoded to 3
		read -n 3 -p "Select an item by it's number and press enter: " selectedIndex
		let selectedIndex-=1
		
		local intRegex='^[0-9]+$'
		if ! [[ $selectedIndex =~ $intRegex ]] || (($arrLen < $selectedIndex)); then
			echo "Not a member or out of range"
		else
			SelectedItem=${arr[$selectedIndex]}
		fi
	done
	
	unset selectedIndex
	unset SelectedItem
}
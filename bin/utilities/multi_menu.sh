#!/bin/bash

options=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"
results=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"

declare -p options results >&2

title=$1

menu() {
	clear >&2
	echo $title >&2
    echo -e "\e[36mAvailable options:\e[0m" >&2
    for i in ${!options[@]}; do 
        printf "\e[36m%3d%s)\e[33m %25s - \e[32m%2s\n\e[0m" $((i+1)) "${choices[i]:- }" "${options[i]}" "${results[i]}" >&2
    done
	
    if [[ "$msg" ]]; then echo "$msg" >&2; fi
}

choices=()
chosen=""

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done

#printf "You selected"; msg=" nothing"

for i in ${!options[@]}; do 
    # [[ "${choices[i]}" ]] && { printf " %s" "${results[i]}"; msg=""; }
	[[ "${choices[i]}" ]] && { chosen+=" ${results[i]}"; }
done

echo $chosen

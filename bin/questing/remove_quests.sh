#!/bin/bash
quests=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"

declare -p quests 1> /dev/null 2> /dev/null

locale=$(cd ../settings && bash get_setting.sh general locale)
questObjectDir="../../shared/locale/$locale/quest/object/"

if [ -z $quests ]; then
	pushd "$questObjectDir" > /dev/null
	pushd "state/" > /dev/null

	installedQuests=(*)
	installedQuests=("${installedQuests[@]%/}")

	popd > /dev/null

	for quest in ${installedQuests[@]}
	do
		echo " - $quest"
	done

	popd > /dev/null

	title="Wich quests to remove?"
	quests=$(bash ../utilities/multi_menu.sh "${#installedQuests[@]}" "${installedQuests[@]}" "${#installedQuests[@]}" "${installedQuests[@]}" "$title")
	quests=($(echo "$quests" | tr ',' '\n'))
fi

pushd "$questObjectDir" > /dev/null

for quest in ${quests[@]}
do
	echo -e "\e[31mRemoving $quest\e[0m"
	rm state/$quest
	rm */*/$quest.*
done

echo "Removed ${#quests[@]} quests"

popd > /dev/null

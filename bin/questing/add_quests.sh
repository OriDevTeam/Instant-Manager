#!/bin/bash
quests=( "${@:2:$1}" ); shift "$(( $1 + 1 ))"

declare -p quests 1> /dev/null 2> /dev/null

locale=$(cd ../settings/ && bash get_setting.sh general locale)
questObjectDir="../../shared/locale/$locale/quest/object/state/"
questDir="../../shared/locale/$locale/quest/source/"

if [ -z $quests ]; then 
	pushd "$questObjectDir" > /dev/null

	installedQuests=(*)
	installedQuests=("${installedQuests[@]%/}")

	popd > /dev/null

	###

	pushd $questDir > /dev/null

	existingQuests=(*.*)
	existingQuests=("${existingQuests[@]%/}")

	popd > /dev/null

	availableQuests=()

	for existingQuest in ${existingQuests[@]}
	do
		questName="${existingQuest%%.*}"
		if [[ ! " ${installedQuests[*]} " == *"$questName"* ]]; then
			availableQuests+=($questName)
			availableQuestNames+=($existingQuest)
		fi
	done

	title="Wich quests to add?"
	quests=$(bash ../utilities/multi_menu.sh "${#availableQuests[@]}" "${availableQuests[@]}" "${#availableQuestNames[@]}" "${availableQuestNames[@]}" "$title")
	quests=($(echo "$quests" | tr ',' '\n'))
	echo ""
else
	pushd $questDir > /dev/null

	existingQuests=(*.*)
	existingQuests=("${existingQuests[@]%/}")

	popd > /dev/null
	
	for existingQuest in ${existingQuests[@]}
	do
		questName="${existingQuest%%.*}"
		if [[ " ${quests[*]} " == *"$questName"* ]]; then
			availableQuests+=($existingQuest)
		fi
	done
	
	quests=$availableQuests
fi

pushd "../settings" > /dev/null

QC_BIN=$(bash get_setting.sh general qc_bin)
ENV_PATH=$(sh get_setting.sh general environment)

popd > /dev/null

pushd "../../shared/locale/$locale/quest/" > /dev/null

for picked in ${quests[@]}
do
	echo -e "\e[32mAdding $picked\e[0m"
	exec ../../../envs/$ENV_PATH/$QC_BIN "source/$picked"
	echo "source/$picked"
done

echo "Added ${#quests[@]} quests."

popd > /dev/null

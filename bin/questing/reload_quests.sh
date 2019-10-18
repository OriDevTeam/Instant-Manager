#!/bin/bash

locale=$(cd ../settings/settings_values && bash locale)
questObjectDir="../../shared/locale/$locale/quest/object/state/"

pushd $questObjectDir > /dev/null

installedQuests=(*)
installedQuests=("${installedQuests[@]%/}")

popd > /dev/null

if [ "${installedQuests[@]}" == "*" ]; then
	echo "No quests to reload"
	exit 1
fi

echo -e "\e[33mReloading ${#installedQuests[@]} quests\e[0m"
bash remove_quests.sh "${#installedQuests[@]}" "${installedQuests[@]}"
bash add_quests.sh "${#installedQuests[@]}" "${installedQuests[@]}"
echo "Quests reloaded"

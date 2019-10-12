#!/bin/bash
skipOverwriteCheck=$1

if [[ -d ../../configuration/databases/db ]] && [[ ! "$skipOverwriteCheck" -eq 1 ]]; then
	echo -e "\e[36mThe Database directory already exists"
	echo -ne "Are you sure of removing and recreating? (y/n):\e[0m "
	read answer
else
	answer="pass"
fi

if [[ "$answer" != "${answer#[Yy]}" ]] || [[ "$skipOverwriteCheck" -eq 1 ]] ; then
	rm -rf ../../configuration/databases/db
elif [ "$answer" = "pass" ]; then
	answer="passed"
else
	echo "exit"
	exit
fi

cores=("main")

for core_name in "${cores[@]}"
do
	core="core_${core_name}"
	
	source ./create_db_core.sh
	
	cd ../../configure
done


#!bin/bash
## This script is required to be Unix EOL(LF)
## to run and make the rest os the scripts compatible

cd bin

title=`cat title.txt`
echo -e "$title"

bash requirements.sh
reqs="$?"
if [ "$reqs" == "0" ]; then
	bash compability.sh
else
	exit 1
fi

comp=$?
if [ "$comp" == "0" ]; then
	bash manager.sh
else
	exit 1
fi

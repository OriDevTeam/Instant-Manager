#!bin/bash
## This script is required to be Unix EOL(LF)
## to run and make the rest os the scripts compatible

cd bin

title=`cat title.txt`
echo -e "$title"

bash compability.sh
bash requirements.sh
bash manager.sh
#!/bin/bash

mkdir -p ../../configuration/databases/db/$core
cd ../../configuration/databases/db/$core

bash ../../../../bin/external/link CMD ../../../../shared/CMD
bash ../../../../bin/external/link keepalive.sh ../../../../shared/db_keepalive.sh

bash ../../../../bin/external/link item_names.txt ../../../../shared/item_names.txt
bash ../../../../bin/external/link item_proto.txt ../../../../shared/item_proto.txt
bash ../../../../bin/external/link mob_names.txt ../../../../shared/mob_names.txt
bash ../../../../bin/external/link mob_proto.txt ../../../../shared/mob_proto.txt

configDir=../../../configuration/databases/db/$core/conf.txt

cd ../../../../bin/
cd settings/settings_values/

echo "// General Settings //" >> $configDir
echo 'WELCOME_MSG = "Database Core Initialized"' >> $configDir
echo "BIND_PORT = $(bash db_port)" >> $configDir
echo "SQL_ACCOUNT = \"$(bash db_ip) account $(bash db_user) $(bash db_password) 0\"" >> $configDir
echo "SQL_PLAYER = \"$(bash db_ip) player $(bash db_user) $(bash db_password) 0\"" >> $configDir
echo "SQL_COMMON = \"$(bash db_ip) common $(bash db_user) $(bash db_password) 0\"" >> $configDir
echo "SQL_HOTBACKUP = \"$(bash db_ip) hotbackup $(bash db_user) $(bash db_password) 0\"" >> $configDir
echo "TABLE_POSTFIX = \"\"" >> $configDir
echo "" >> $configDir
echo "// Other Settings //" >> $configDir
echo "CLIENT_HEART_FPS = 25" >> $configDir
echo "BACKUP_LIMIT_SEC = 3600" >> $configDir
echo "ITEM_ID_RANGE = 2000000000 2100000000" >> $configDir
echo "PLAYER_ID_START = 100" >> $configDir
echo "PLAYER_DELETE_LEVEL_LIMIT = 120" >> $configDir
#echo "Block "Y/QSB7omi36awq4ctpUxuiwRARM="" >> $configDir

echo -e "Created Database core"

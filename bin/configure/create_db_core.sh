#!/bin/sh

mkdir -p ../../configuration/databases/db/$core
cd ../../configuration/databases/db/$core

sh ../../../../bin/external/link CMD ../../../../shared/CMD
sh ../../../../bin/external/link keepalive.sh ../../../../shared/db_keepalive.sh

sh ../../../../bin/external/link item_names.txt ../../../../shared/item_names.txt
sh ../../../../bin/external/link item_proto.txt ../../../../shared/item_proto.txt
sh ../../../../bin/external/link mob_names.txt ../../../../shared/mob_names.txt
sh ../../../../bin/external/link mob_proto.txt ../../../../shared/mob_proto.txt

configDir=../../../configuration/databases/db/$core/conf.txt

cd ../../../../bin/
cd settings/settings_values/

echo "// General Settings //" >> $configDir
echo 'WELCOME_MSG = "Database Core Initialized"' >> $configDir
echo "BIND_PORT = $(sh db_port)" >> $configDir
echo "SQL_ACCOUNT = \"$(sh db_ip) account $(sh db_user) $(sh db_password) 0\"" >> $configDir
echo "SQL_PLAYER = \"$(sh db_ip) player $(sh db_user) $(sh db_password) 0\"" >> $configDir
echo "SQL_COMMON = \"$(sh db_ip) common $(sh db_user) $(sh db_password) 0\"" >> $configDir
echo "SQL_HOTBACKUP = \"$(sh db_ip) hotbackup $(sh db_user) $(sh db_password) 0\"" >> $configDir
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

#!/bin/bash
channel=$1
channel_number=$2
core=$3
core_name=$4
map_allow=$5

mkdir -p ../../configuration/channels/$channel/$core_name
cd ../../configuration/channels/$channel/$core_name

mkdir -p mark

bash ../../../../bin/external/link locale ../../../../shared/locale
bash ../../../../bin/external/link data ../../../../shared/data
bash ../../../../bin/external/link CMD ../../../../shared/CMD
bash ../../../../bin/external/link keepalive.sh ../../../../shared/game_keepalive.sh
bash ../../../../bin/external/link package ../../../../shared/package

configDir=../../../configuration/channels/$channel/$core_name/CONFIG

cd ../../../../bin/

cd settings/settings_values/

echo "# General Settings #" >> $configDir
echo "HOSTNAME: "$channel"_"$core_name >> $configDir
echo "CHANNEL: $channel_number" >> $configDir
echo "BIND_IP: $(bash bind_ip)" >> $configDir
echo "PORT: $(($(bash base_game_port) + (10 * $channel_number) + $core))" >> $configDir
echo "P2P_PORT: $(($(bash base_game_port) + (100 * $channel_number) + (10 * $channel_number) + $core))" >> $configDir
echo "DB_ADDR: $(bash db_ip)" >> $configDir
echo "DB_PORT: $(bash db_port)" >> $configDir
echo "PLAYER_SQL: $(bash db_ip) $(bash db_user) $(bash db_password) player" >> $configDir
echo "COMMON_SQL: $(bash db_ip) $(bash db_user) $(bash db_password) common" >> $configDir
echo "LOG_SQL: $(bash db_ip) $(bash db_user) $(bash db_password) log" >> $configDir

if [ "$channel" != "auth" ]; then
	echo "MAP_ALLOW:$map_allow" >> $configDir
fi

echo "LOCALE_SERVICE: $(bash locale)" | tr a-z A-Z >> $configDir
echo "" >> $configDir
echo "# Sync Settings #" >> $configDir
echo "SAVE_EVENT_SECOND_CYCLE: 180" >> $configDir
echo "PING_EVENT_SECOND_CYCLE: 180" >> $configDir
echo "" >> $configDir
echo "# Mall Settings #" >> $configDir
echo "MALL_URL: $(bash mall_url)" >> $configDir
echo "ADMINPAGE_IP: $(bash adminpage_ip)" >> $configDir
echo "ADMINPAGE_PASSWORD: $(bash adminpage_password)" >> $configDir
echo "" >> $configDir
echo "# Game Settings #" >> $configDir
echo "VIEW_RANGE: 6000" >> $configDir

: '
TABLE_POSTFIX: 
mark_server 1
mark_min_level 1
traffic_profile: 1
user_limit: 1000
speedhack_limit_count: 10
speedhack_limit_bonus: 10
spam_block_duration: 10
spam_block_score: 10
spam_block_reload_cycle: 10
spam_block_max_level: 90
protect_normal_player: 1
'

echo -e "Created '$channel' '$core_name'"

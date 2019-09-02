#!/bin/sh

mkdir -p ../../configuration/channels/$channel/$core
cd ../../configuration/channels/$channel/$core

mkdir -p mark

sh ../../../../bin/external/link locale ../../../../shared/locale
sh ../../../../bin/external/link data ../../../../shared/data
sh ../../../../bin/external/link CMD ../../../../shared/CMD
sh ../../../../bin/external/link keepalive.sh ../../../../shared/game_keepalive.sh
sh ../../../../bin/external/link package ../../../../shared/package

configDir=../../../configuration/channels/$channel/$core/CONFIG

cd ../../../../bin/

if [ "$channel" != "auth" ]; then
	cd configure/
	
	echo "Loading Available Map Menu..."
	source ./get_available_map_indexes.sh
	map_allow=$chosen
fi

cd settings/settings_values/

echo "# General Settings #" >> $configDir
echo "HOSTNAME: "$channel"_"$core >> $configDir
echo "CHANNEL: $channel_number" >> $configDir
echo "BIND_IP: $(sh bind_ip)" >> $configDir
echo "PORT: $(($(sh base_game_port) + (10 * $channel_number) + $core_name))" >> $configDir
echo "P2P_PORT: $(($(sh base_game_port) + (100 * $channel_number) + (10 * $channel_number) + $core_name))" >> $configDir
echo "DB_ADDR: $(sh db_ip)" >> $configDir
echo "DB_PORT: $(sh db_port)" >> $configDir
echo "PLAYER_SQL: $(sh db_ip) $(sh db_user) $(sh db_password) player" >> $configDir
echo "COMMON_SQL: $(sh db_ip) $(sh db_user) $(sh db_password) common" >> $configDir
echo "LOG_SQL: $(sh db_ip) $(sh db_user) $(sh db_password) log" >> $configDir

if [ "$channel" != "auth" ]; then
	echo "MAP_ALLOW:$map_allow" >> $configDir
fi

echo "LOCALE_SERVICE: $(sh locale)" | tr a-z A-Z >> $configDir
echo "" >> $configDir
echo "# Sync Settings #" >> $configDir
echo "SAVE_EVENT_SECOND_CYCLE: 180" >> $configDir
echo "PING_EVENT_SECOND_CYCLE: 180" >> $configDir
echo "" >> $configDir
echo "# Mall Settings #" >> $configDir
echo "MALL_URL: $(sh mall_url)" >> $configDir
echo "ADMINPAGE_IP: $(sh adminpage_ip)" >> $configDir
echo "ADMINPAGE_PASSWORD: $(sh adminpage_password)" >> $configDir
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

echo -e "Created '$channel' '$core'"

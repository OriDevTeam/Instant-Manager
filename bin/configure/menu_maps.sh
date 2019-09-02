#!/bin/bash
declare -a map_index_list=$(sh get_available_map_indexes.sh)

./multi_menu.sh "$(printf "(" ; printf "'%s' " "${map_index_list[@]}" ; printf ")")"

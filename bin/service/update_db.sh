#!/bin/bash

echo -e "Converting item_proto and mob_proto to TXT from SQL"

cd ../../shared

rm -f item_names.txt
rm -f item_proto.txt
rm -f mob_names.txt
rm -f mob_proto.txt

cd ../bin/tools
python2 convert_item.py
python2 convert_mob.py

echo -e "Protos converted."

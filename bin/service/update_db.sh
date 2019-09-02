#!/bin/sh

echo -e "A sincronizar com base de dados..."

cd ../../shared

rm -f item_names.txt
rm -f item_proto.txt
rm -f mob_names.txt
rm -f mob_proto.txt

cd ../bin/tools
python2 convert_item.py
python2 convert_mob.py

echo -e "Base de dados sincronizada."

#!bin/bash
pushd "../" > /dev/null
folder=(configuration source shared)
for i in "${folder[@]}"
do
    if [ ! -d $i ]; then
        mkdir $i
    fi
done
popd > /dev/null
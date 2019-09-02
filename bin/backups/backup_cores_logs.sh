#!/bin/sh

DATE=`date +"%d.%m.%y.%H"`
echo "$DATE" >> ARCHIVED_DATE
echo "Creating logs tarball"
mkdir -p ../../backups/logs/$DATE/
tar -cf ../../backups/logs/$DATE/logs.tgz ARCHIVED_DATE

cd ../../configuration/

## Channels
cd channels

channels=(*/)
channels=("${channels[@]%/}")
for channel in ${channels[@]}
do
	cd $channel
	
	cores=(*/)
	cores=("${cores[@]%/}")
	for core in ${cores[@]}
	do
		cd $core
		sleep 2
		
		if [ -d logs ]; then
			echo "Adding $channel $core logs"
			mkdir -p ../../../../backups/logs/$DATE/$channel/$core
			mv logs ../../../../backups/logs/$DATE/$channel/$core
			cd ../../../../backups/logs/$DATE
			tar -rf logs.tgz $channel/$core
		fi
		
		cd ../
	done
	cd ../
done

echo "Created logs tarball date: $DATE"

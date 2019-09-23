#!/bin/bash

export LFS=/mnt/lfs;
mkdir -pv $LFS;
sudo mount -v -t ext4 /dev/sdc3 /mnt/lfs;

RESULT=$?

 if [ $RESULT -eq 0 ]; then
	exit 0
 else
	sudo mount -v -t ext4 /dev/sdd3 /mnt/lfs;
	
	RESULT2=$?

	if [ $RESULT2 -eq 0 ]; then
		exit 0
	else
		sudo mount -v -t ext4 /dev/sdb3 /mnt/lfs;
		
		RESULT3=$?

		if [ $RESULT3 -eq 0 ]; then
			exit 0
		else
			sudo mount -v -t ext4 /dev/sde3 /mnt/lfs;
			exit 0
		fi
	fi
 fi

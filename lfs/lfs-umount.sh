#!/bin/bash

attempt_umount() {

	# Finally, unmount the drive and swap (if necessary)
	# Note* sd[x]2 seems to always give error "device is busy" (just restart)

	sudo umount /dev/sdc3;
	sudo umount /dev/sdc1;
	sudo umount -f /dev/sdc2;

	RESULT=$?

	if [ $RESULT -eq 0 ]; then
		exit 0
	else
		sudo umount -f /dev/sdb2;
		sudo umount /dev/sdb3;
		sudo umount /dev/sdb1;

		RESULT2=$?

		if [ $RESULT2 -eq 0 ]; then
			exit 0
		else
			sudo umount -f /dev/sdd2;
			sudo umount /dev/sdd3;
			sudo umount /dev/sdd1;

			RESULT3=$?

			if [ $RESULT3 -eq 0 ]; then
				exit 0
			else
				exit 1
			fi
		fi
	fi
}
#--------------------------------------------------------------------

# Unmount file systems after exitting chroot environment
sudo umount /mnt/lfs/dev/pts;
sudo umount /mnt/lfs/dev;
sudo umount /mnt/lfs/proc;
sudo umount /mnt/lfs/sys;
sudo umount /mnt/lfs/run;

read -p "Attempt to unmount the disk drive as well? (yes/no): " answer

if [ "$answer" == "yes" ]; then
	attempt_umount
else
	echo 
	echo "WARNING: Do NOT remove the disk drive without first ensuring that the swap"
	echo "partition is properly unmounted! Failure to do so can result in the host"
	echo "OS crashing!"
	echo
	exit 0
fi

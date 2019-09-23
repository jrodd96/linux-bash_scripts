#!/bin/sh

files() {

	# Bind /dev to $LFS/dev directory
	sudo mount -v --bind /dev $LFS/dev;

	# Mount devpts, proc, sysfs, tmpfs
	sudo mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620;
	sudo mount -vt proc proc $LFS/proc;
	sudo mount -vt sysfs sysfs $LFS/sys;
	sudo mount -vt tmpfs tmpfs $LFS/run;
}

chroot() {

	# chroot cmd for entering chroot environment in $LFS
	sudo chroot "$LFS" /usr/bin/env -i HOME=/root TERM="$TERM" PS1='(lfs chroot) \u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login;
}

mntdisk() {

	# Export LFS env variable for /mnt/lfs
	export LFS=/mnt/lfs;

	# mkdir $LFS directory to mount
	sudo mkdir -pv $LFS;

	# Mount disk sd[x]2
	sudo mount -v -t ext4 /dev/sdb2 $LFS;
	sudo mount -v -t vfat /dev/sdb1 $LFS/boot;
	sudo mount -v -t ext4 /dev/sdb3 $LFS/usr/src;
	sudo mount -v -t ext4 /dev/sdb4 $LFS/tmp;
	RESULT=$?
	
	# If NOT sdb, try sdc or sdd (or in rare cases, sda)
	if [ $RESULT -eq 0 ]; then
		sudo /sbin/swapon -v /dev/sdb5;

		files
		chroot
	else
		sudo mount -v -t ext4 /dev/sdc2 $LFS;
		sudo mount -v -t vfat /dev/sdc1 $LFS/boot;
		sudo mount -v -t ext4 /dev/sdc3 $LFS/usr/src;
		sudo mount -v -t ext4 /dev/sdc4 $LFS/tmp;
		RESULT2=$?

		if [ $RESULT2 -eq 0 ]; then
			sudo /sbin/swapon -v /dev/sdc5;

			files
			chroot
		else
			sudo mount -v -t ext4 /dev/sdd2 $LFS;
			sudo mount -v -t vfat /dev/sdd1 $LFS/boot;
			sudo mount -v -t ext4 /dev/sdd3 $LFS/usr/src;
			sudo mount -v -t ext4 /dev/sdd4 $LFS/tmp;
			
			sudo /sbin/swapon -v /dev/sdd5;

			files
			chroot 
		fi
	fi
}

mntdisk

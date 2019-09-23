#!/bin/bash

# Decrypts Bitlocker on <mount_dir1>, mounts it at /media/<mount_dir2>

sudo dislocker -V /dev/sdb1 -u<password> -- /media/<mount_dir1>

RESULT=$?

  if [ $RESULT -eq 0 ]; then
	sudo mount -o loop,uid=jrodd96 /media/<mount_dir1>/dislocker-file /media/<mount_dir2>
  else
	sudo dislocker -V /dev/sdc1 -u<password> -- /media/<mount_dir1>
	if [ $RESULT -eq 0 ]; then
	      sudo mount -o loop,uid=jrodd96 /media/<mount_dir1>/dislocker-file /media/<mount_dir2>
	else
	      sudo dislocker -V /dev/sdd1 -u<password> -- /media/<mount_dir1>
              sudo mount -o loop,uid=jrodd96 /media/<mount_dir1>/dislocker-file /media/<mount_dir2>
        fi
  fi


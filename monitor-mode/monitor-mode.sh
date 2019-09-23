#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ] 
        then
        	echo
        	echo "Success"
        	echo
        else
        	echo
        	echo "[ERROR] Process Failed!"
        	echo

        	read -p "The last command exited with an error. Exit script? (yes/no) " answer

        	if [ "$answer" == "yes" ]
        	then
        		exit 1
                fi
        fi
}

up() {

	# Turns on monitor mode for wlan0 using airmon-ng
	# NOTE: you need airmon-ng installed (via "katoolin" script for Kali Linux tools)
	sudo airmon-ng start wlan0;

	check_exit_status
}

down() {

	# Turns off airmon-ng
	sudo airmon-ng stop wlan0mon
	check_exit_status

	# Disables wlan0 interface, switches wlan0 from "monitor" to "managed"
	# mode, and re-enables wlan0 interface
	sudo ifconfig wlan0 down;
	check_exit_status
	sudo iwconfig wlan0 mode managed;
	check_exit_status
	sudo ifconfig wlan0 up;
	check_exit_status

	# Restarts NetworkManager service that was disabled when activating monitor mode
	sudo systemctl start NetworkManager;
	check_exit_status
}

intro() {

	echo
	read -p "Enter [0] to start monitor mode OR enter [1] to turn OFF monitor mode: " answer
	echo

	if [ "$answer" == "0" ]
	then
		up
		exit 0
	elif [ "$answer" == "1" ]
	then
		down
		exit 0
	else
		echo
		echo "[ERROR]: Incorrect input -- exitting script..."
		echo
		exit 1
	fi
}

intro
	

#!/bin/bash

# Script to autorun the SSH command for connecting to Debian 10 server

global_ip() {

	ssh -p 1996 hostname@<global_ip>
}

local_ip() {

	ssh -p 1996 hostname@<local_ip>
}

menu() {

	read -p "Remote connect or local connect? (r/l)? " answer

	if [ "$answer" == "r" ] 
	then
		global_ip
	elif [ "$answer" == "l" ] 
	then
		local_ip
	else
		echo "Unknown answer given. Exitting script..."
		exit 1
	fi
}

menu

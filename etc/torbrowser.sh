#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ]
	then
	  echo
	  echo "Success! Opening Tor Browser"
	  echo
	else
	  echo
	  echo "[ERROR] Failed to start Tor Browser"
	  echo

	  read -p "Attempt to open Tor Browser failed with an error. Exit script? (yes/no) "

	  if [ "$answer" == "yes" ]
	  then
	    exit 1
	  fi
	fi
}

greeting() {

	echo
	echo "Opening Tor Browser..."
	echo
}

cdTorFolder() {

	cd /media/jrodd96/ISO\ and\ Software/Programs/tor-browser_en-US/Browser
	check_exit_status
}

openTor() {

	./start-tor-browser
	check_exit_status
}

greeting
cdTorFolder
openTor

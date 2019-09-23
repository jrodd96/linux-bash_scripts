#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ]
	then
	  echo
	  echo  "Done!"
	  echo

	else
	  echo
	  echo "[ERROR] Process Failed"
	  echo

	  read -p "The last command exited with an error. Exit? (yes/no) " answer

	  if [ "$answer" == "yes" ]
	  then
	    exit 1
	  fi
	fi
}

reset1() {

	echo "Resetting Firewall Rules..."
	sudo ufw reset;
	check_exit_status

	echo
	menu
}

default2() {

	sudo ufw default deny incoming;
	sudo ufw default allow outgoing;
	check_exit_status

	echo
	menu
} 

ssh3() {

	sudo ufw allow from 192.168.0.0/24 to any port 22;
	check_exit_status

	echo
	menu
}

rdp_local4() {

	sudo ufw allow from 192.168.0.0/24 to any port 3389;
	check_exit_status

	echo
	menu
}

rdp_vpn5() {

	sudo ufw allow from 10.x.x.x/24 to any port 3389;
	check_exit_status

	echo
	menu
}

ftp6() {

	sudo ufw allow from 192.168.0.0/24 to any port 21;
	check_exit_status

	echo
	menu
}

rsync7() {

	sudo ufw allow from 192.168.0.0/24 to any port 873;
	check_exit_status

	echo
	menu
}

https8() {

	echo "WARNING - This exposes this PC to the Global Internet!"
	echo "Set additional rules accordingly and use CAUTION!"
	echo "Note: this also enables WebDav functionality."
	echo
	sudo ufw allow 443;
	check_exit_status

	echo
	menu
}

sftp9() {

	sudo ufw allow from 192.168.0.0/24 to any port 50005;
	check_exit_status

	echo
	menu
}

status10() {

	sudo ufw status verbose;
	check_exit_status

	echo
	menu
}

enable11() {

	sudo ufw enable;
	check_exit_status
	exit 0
}

menu() {

	echo
	echo "Welcome $USER, select option for configuring UFW firewall rules: "
	echo
	echo "(1) Reset UFW Firewall Rules (WILL REMOVE CURRENT RULES!)"
	echo "(2) Set Default UFW Policies - Deny Incoming/Allow Outgoing"
	echo "(3) Allow SSH via 192.168.0.0/24 Subnet - Port 22"
	echo "(4) Allow Remote Desktop (RDP) via 192.168.0.0/24 - Port 3389"
	echo "(5) Allow Remote Desktop (RDP) via VPN Tunnel - Port 3389"
	echo "(6) Allow FTP from 192.168.0.0/24 IPs - Port 21"
	echo "(7) Allow Rsync on port 873 from 192.168.0.0/24 IPs"
	echo "(8) Allow HTTPS traffic to 'jared-stevens1996.com' - Port 443"
	echo "(9) Allow SFTP from 192.168.0.0/24 to Port 50005"
	echo "(10) View Current Status of Applied UFW Rules"
	echo "(11) Enable New UFW Rules and Exit Script"	
	echo
	echo "Enter any other value to force exit script."
	echo "Note: any changes to above UFW rules WILL still apply."
	echo

	read -p  "Enter your choice (1-11): " choice

	if [ "$choice" == "1" ]
	then
	  reset1
	elif [ "$choice" == "2" ]
	then
	  default2
	elif [ "$choice" == "3" ]
	then
	  ssh3
	elif [ "$choice" == "4" ]
	then
	  rdp_local4
	elif [ "$choice" == "5" ]
	then
	  rdp_vpn5
	elif [ "$choice" == "6" ]
	then
	  ftp6
	elif [ "$choice" == "7" ]
	then
	  rsync7
	elif [ "$choice" == "8" ]
	then
	  https8
	elif [ "$choice" == "9" ]
	then
	  sftp9
	elif [ "$choice" == "10" ]
	then
	  status10
	elif [ "$choice" == "11" ]
	then
	  enable11
	else
	  echo
	  echo "No choice selected. Exitting script..."
	  exit 1
	fi
}

menu

#!/bin/bash

# This script is designed to auto-enter the necessary commands for creating,
# moving, and sourcing a new bash script.

# Note: This script follows the steps for creating a bash script listed in the
# article "Create a Bash Script in Ubuntu 18.04" on VirtualZero website.

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

# Create file in nano
echo
read -p "Enter the file name of the new bash script you wish to create in ~/scripts directory (filename.sh): " filename
echo 

sudo nano ~/scripts/$filename;
check_exit_status


# Execute chmod permissions
echo
echo "Applying proper execute permissions..."

sudo chmod a+x ~/scripts/$filename;
check_exit_status


# Move and rename script to ~/.bin
echo
read -p "Enter the new file name to be moved to ~/.bin directory (ex. file instead of filename.sh): " filename2
echo

sudo cp ~/scripts/$filename ~/.bin/$filename2;
check_exit_status


# Export PATH and source ~/.bashrc
echo
echo "Exporting PATH and sourcing ~/.bashrc..."
echo

bash ~/.bin/source-bash
check_exit_status

echo
echo "Bash script created successfully! Exitting script..."
exit 0

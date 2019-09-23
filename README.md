# Bash Script Files for Linux OS

This repository is a compilation of all of my bash scripts that have been either created by me or saved from other sources.

All scripts in this repo were created on the **Ubuntu 19.04** distro and have been proven to run successfully in other distros such as Debian Stretch (*and its Linux Subsystem on Windows counterpart*), Debian Buster (*and its Linux Subsystem on Windows counterpart*), Ubuntu 18.04, and Raspbian (*Raspberry Pi 3*).
- All scripts are current as of <b>September 2019</b>.

> **Note:** Most of these scripts were designed for personal use with my customized settings on my Linux distro and PC at the time. As such, use of these scripts in other environments may require certain aspects to be tweaked in order to work properly (i.e. file paths, hard drive names, etc.).

This repo currently contains the following bash scripts: 

### Update -- *[update.sh](apt-update/update.sh)* 
- Script for simplifying the process of updating and upgrading the Linux distro through the APT package manager (**Note:** requires **aptitude** to be installed on system).
- The script runs the following commands (as root using **sudo**):
  ```
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt-get autoremove -y 
  sudo apt-get autoclean -y
  ```
### Bitlocker Decryption -- *[unlock.sh](bitlocker/unlock.sh)*
- Script for decrypting a Windows Bitlocker-encrypted NTFS-formatted hard disk and mounting the filesystem to a specified folder
  1. Dislocker command decrypts the hard drive using user-inputted password and creates a `loop` device of the drive filesystem at `<mount_dir1>/dislocker-file`
  2. Mounts the created loop device `dislocker-file` at `/media/<mount_dir2>` to allow user read/write access to the drive's contents
- **Dependencies:**
    - Requires the **dislocker** package for Bitlocker decryption capabilities
    - Ability to have read/write access to Windows NTFS filesystems using **ntfs-3g** package
    - Two directories should be specified/created for use as mountpoints -- `<mount_dir1>` and `<mount_dir2>`
  
### Create Bash Script -- *[create-bash.sh](create-bash/create-bash.sh)*
- Executes the necessary commands for creating a new Bash script file, making it executable, and moving it to a pre-determined directory that is `$PATH` sourced in the `~/.bashrc` file (see below)
  - Includes **[source-bash.sh](create-bash/source-bash.sh)** file for assigning `$PATH` variable to a directory `~/.bin` (change to point to your desired directory path) using the following commands:
    ```
    export PATH=~/.bin:$PATH
    source ~/.bashrc
    ```
  1. Creates the script file and opens the `nano` text editor (can be adjusted to use `vim`, `gedit`, `emacs`, etc.
  2. Executes file permission command for making the file executable:
    `sudo chmod a+x ~/<path>/$filename.sh`
  3. Moves and renames script file to sourced `$PATH` directory to allow for execution of script anywhere in Terminal.
  4. Executes `source-bash` script to source `~/.bashrc`

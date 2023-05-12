#!/bin/bash


clear


echo "                         ##################################################################"
echo "                         !!                                                              !!"
echo "                         !!                                                              !!"
echo "                         !!               Welcome To TechGenies Family                   !!"
echo "                         !!                                                              !!"
echo "                         !!                                                              !!"
echo "                         ##################################################################"
echo
echo
echo
echo


function usercreate(){
        show=$(users)
        echo "All The Present Users Of This System"
        echo "$show"
        # Prompt the user to enter a username
        read -p "Enter New Username: " username

        # Check if the username is blank
        if [ -z "$username" ]; then
                echo "Error: Username cannot be blank"
                exit 1
        fi

        # Check if the username already exists
        if id "$username" >/dev/null 2>&1; then
                echo "Error: Username already exists"
                exit 1
        fi

        # Prompt the user to enter a password
        read -p "Set password for ne user $username: " password

        # Create the user account with the given username and password
        # sudo useradd -m -p "$(openssl passwd -1 "$password")" "$username"  --> saw error while run it on other linux
        sudo adduser "$username" --disabled-password --gecos "" && \
        echo "$username:$password" | sudo chpasswd

        # Print a message indicating that the user account has been created
        echo "User account '$username' created successfully"
}


function userdelete(){
        echo
        echo "Number of users this system has"
        sudo users
        echo
        echo
        echo "Before running any script to delete users,
It is important to understand the potential risks of deleting users,
And ensure that you have the necessary permissions to perform such an action."
        echo
        echo
        # Prompt the user for the username to delete
        read -p "Enter the username to delete everything: " USERNAME

        # Check if the user exists
        if id "$USERNAME" >/dev/null 2>&1; then
                # Delete the user and their home directory
                echo "Deleting user $USERNAME"
                sleep 1
                sudo userdel -r "$USERNAME"
        else
                # If the user doesn't exist, print an error message
                echo "User $USERNAME does not exist"
        fi
}


function connect_to_server(){
    read -p "Enter the server name: " user server_address
    read -p "Enter the server's ip address: " server_address
    echo "Enter password of the server to get connected: "
    read -s PASSWORD
    echo "Trying to connect to $user@$server_address..."
    sshpass -p $PASSWORD ssh $user@$server_address
    if [ $? -eq 0 ]; then
        echo "SSH connection established."
    else
        echo "Failed to establish SSH connection."
    fi
    exit
}


function connectaws(){
        # set the directory to search in
        directory="$HOME/Downloads/"

        # set the extension to search for
        extension=".pem"

        # use the find command to search for files with the given extension in the specified directory
        connect=$(find "$directory" -type f -name "*$extension" -print)

        sudo chmod 600 $connect
        echo "Permission is been added to $connect"

        read -p "Enter server/user name: " userserver
        read -p "Enter your server/user IP: " userserverIP

        ssh -i "$connect" "$userserver@$userserverIP"
}


function chhost(){
        show=$(hostname)
        echo
        echo "Your current hostname is $show"
        read -p "Enter new hostname: " new_hostname
        hostnamectl set-hostname "$new_hostname"
        echo "This hostname has been change to $new_hostname. Please restart to system to take effect."
}


function rsyncfuc(){
        echo "Example: /home/username/Desktop/(copy-file-name)"
        read -p "Enter the source directory: " source_directory
        echo "Example: /home/username/Downloads(Distination)"
        read -p "Enter the target directory: " target_directory
        # Check to make sure the user has entered exactly two arguments.
        if [ -z "$source_directory" ] || [ -z "$target_directory" ]
                then
                        echo "Error: make sure you have entered correct path"
                        echo "Usage: <source_directory> <target_directory>"
                        echo "Please try again."
                exit 1
        fi

        # Check to see if rsync is installed.
        if ! command -v rsync > /dev/null 2>&1
                then
                        echo "This script requires rsync to be installed."
                        echo "Please use your distribution's package manager to install"
                exit 2
        fi

        # Capture the current date, and store it in the format YYYY-MM-DD
        current_date=$(date +%Y-%m-%d)
        # rsync_options="-avb --backup-dir $2/current_date --delete --dry-run"    --> data copy hobe kintu thakbe na okhane.
        rsync_options="-avb --backup-dir $2/current_date --delete"
        $(which rsync) $rsync_options $source_directory $target_directory >> backup_$current_date.log
}


function rsyncfuc1(){
        echo "Example: /home/username/Desktop/(copy-file-nme)"
        read -p "Enter the source directory:" source_directory
        echo "Example: username@IP:/root/distication-folder"
        read -p "Enter the target directory:" target_directory
        # Check to make sure the user has entered exactly two arguments.
        if [ -z "$source_directory" ] || [ -z "$target_directory" ]
                then
                        echo "Error: make sure you have entered correct path"
                        echo "Usage: <source_directory> <target_directory>"
                        echo "Please try again."
                exit 1
        fi

        # Check to see if rsync is installed.
        if ! command -v rsync > /dev/null 2>&1
                then
                        echo "This script requires rsync to be installed."
                        echo "Please use your distribution's package manager to install"
                exit 2
        fi

        # Capture the current date, and store it in the format YYYY-MM-DD
        current_date=$(date +%Y-%m-%d)
        # rsync_options="-avb --backup-dir $2/current_date --delete --dry-run"    --> data copy hobe kintu thakbe na okhane.
        rsync_options="-avb --backup-dir $2/current_date --delete"
        $(which rsync) $rsync_options $source_directory $target_directory >> backup_$current_date.log
}


function rsyncfuc2(){
        echo "Example: username@IP:/root/copy-file"
        read -p "Enter the source directory: " source_directory
        echo "Example: /home/username/Destop/"
        read -p "Enter the target directory: " target_directory
        # Check to make sure the user has entered exactly two arguments.
        if [ -z "$source_directory" ] || [ -z "$target_directory" ]
                then
                        echo "Error: make sure you have entered correct path"
                        echo "Usage: <source_directory> <target_directory>"
                        echo "Please try again."
                exit 1
        fi

        # Check to see if rsync is installed.
        if ! command -v rsync > /dev/null 2>&1
                then
                        echo "This script requires rsync to be installed."
                        echo "Please use your distribution's package manager to install"
                exit 2
        fi

        # Capture the current date, and store it in the format YYYY-MM-DD
        current_date=$(date +%Y-%m-%d)
        # rsync_options="-avb --backup-dir $2/current_date --delete --dry-run"    --> data copy hobe kintu thakbe na okhane.
        rsync_options="-avb --backup-dir $2/current_date --delete"
        $(which rsync) $rsync_options $source_directory $target_directory >> backup_$current_date.log

        if [ $? -eq 0 ]
        then
                echo "Backup completed successfully to this $target_directory"
        else
                echo "Error: Backup failed. Please check your input parameters and try again."
        fi
}

function syncaws(){
        # set the directory to search in
        directory="$HOME/Downloads/"

        # set the extension to search for
        extension=".pem"

        # use the find command to search for files with the given extension in the specified directory
        connect=$(find "$directory" -type f -name "*$extension" -print)

        sudo chmod 600 $connect
        echo "Permission is been added to $connect"
        echo

        read -p "Enter your aws instance/server name: " num
        read -p "Enter the ip of that: " ipp

        # Prompt the user to enter the source and target directories
        echo
        echo "Type the path like: /home/any-user-name/copyme.txt (it should be aws instance path)"
        read -p "Enter the source directory: " source_directory
        echo
        echo "Type the path of physical system, Like /home/username/Desktop/"
        read -p "Enter the target directory: " target_directory

        # Check to make sure the user has entered both directories
        if [ -z "$source_directory" ] || [ -z "$target_directory" ]
                then
                        echo "Error: make sure you have entered correct paths"
                        echo "Usage: <source_directory> <target_directory>"
                        echo "Please try again."
                        exit 1
        fi

        # Check to see if rsync is installed
        if ! command -v rsync > /dev/null 2>&1
                then
                        echo "This script requires rsync to be installed."
                        echo "Please use your distribution's package manager to install."
                        exit 2

        fi

        # Capture the current date, and store it in the format YYYY-MM-DD
        current_date=$(date +%Y-%m-%d)

        # Define rsync_options
        rsync_options=(-avz --progress -e "ssh -i $connect" --delete-after --exclude='*.log')

        # Run the rsync command
        rsync "${rsync_options[@]}" "$num@$ipp:$source_directory" "$target_directory" >> backup_$current_date.log

        if [ $? -eq 0 ]
        then
                echo
                echo "Backup completed successfully to this $target_directory"
        else
                echo "Error: Backup failed, Please check your input parameters and try again."
        fi
}

function syncaws1(){
        # set the directory to search in
        directory="$HOME/Downloads/"

        # set the extension to search for
        extension=".pem"

        # use the find command to search for files with the given extension in the specified directory
        connect=$(find "$directory" -type f -name "*$extension" -print)

        sudo chmod 600 $connect
        echo "Permission is been added to $connect"

        read -p "Enter your aws instance/server name: " num
        read -p "Enter the ip of that: " ipp
        echo

        # Prompt the user to enter the source and target directories
        echo "Type physical system path like: /home/physical-user-name/Desktop/copyme.txt"
        echo
        read -p "Enter the source directory: " source_directory
        echo
        echo "Type aws/server instalce pack like: /home/aws-instance-username/filepast/here/"
        echo
        read -p "Enter the target directory: " target_directory

        # Check to make sure the user has entered both directories
        if [ -z "$source_directory" ] || [ -z "$target_directory" ]
                then
                        echo "Error: make sure you have entered correct paths"
                        echo "Usage: <source_directory> <target_directory>"
                        echo "Please try again."
                        exit 1
        fi

        # Check to see if rsync is installed
        if ! command -v rsync > /dev/null 2>&1
                then
                        echo "This script requires rsync to be installed."
                        echo "Please use your distribution's package manager to install."
                        exit 2
        fi

        # Capture the current date, and store it in the format YYYY-MM-DD
        current_date=$(date +%Y-%m-%d)

        # Define rsync_options
        rsync_options=(-avz --progress -e "ssh -i $connect" --delete-after --exclude='*.log')

        # Run the rsync command
        rsync "${rsync_options[@]}" "$source_directory" "$num@$ipp:$target_directory" >> backup_$current_date.log

        if [ $? -eq 0 ]
        then
                echo
                echo "Backup completed successfully to this $target_directory"
        else
                echo "Error: Backup failed, Please check your input parameters and try again."
        fi
}


function ftpfuc(){
read -p "Enter your HOST ip or domain: " HOST
read -p "Enter the user-name: " USERNAME
echo "Enter the password: "
read -s PASSWORD

while true
do
  echo "---------------------------------------------"
  echo
  echo "These are the option to work with:"
  echo "1. Put a file"
  echo "2. Get a file"
  echo "3. Quit"
  read -p "Enter your choice (1-3): " choice
  echo "______________________________________________"
  echo

  case $choice in
    1)
      read -p "Enter the file-name to put: " f1
      # Connect to the FTP server and put the file
      ftp -nv $HOST <<END_SCRIPT
      quote USER $USERNAME
      quote PASS $PASSWORD
      put $f1
      quit
END_SCRIPT
      ;;
    2)
      read -p "Enter the file to get: " f2
      # Connect to the FTP server and get the file
      ftp -nv $HOST <<END_SCRIPT
      quote USER $USERNAME
      quote PASS $PASSWORD
      get $f2
      quit
END_SCRIPT
      ;;
    3)
      echo "Quitting the program..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number from 1-3."
      ;;
  esac
done
}



function sftpfuc(){
        # Prompt the user for the SFTP server hostname or IP address and login credentials
        read -p "Enter the SFTP server hostname or IP address: " host
        read -p "Enter the SFTP server username: " username
        read -s -p "Enter the SFTP server password: " password
        echo
function generate_ssh_keypair {
    # Create an SSH key pair if it does not exist
    ssh_dir="$HOME/.ssh"
    if [ ! -f "$ssh_dir/id_rsa" ]; then
        ssh-keygen -t rsa -b 4096 -C "SFTP key pair" -N "" -f "$ssh_dir/id_rsa"
        echo "New SSH key pair generated in $ssh_dir"
    else
            echo "It's already there: $ssh_dir/id_rsa"
    fi
}
echo
read -p "Do you want to generate an SSH key pair? (y/n): " choice
echo
if [ "$choice" == "y" ]; then
    generate_ssh_keypair
else
    echo "Skipping SSH key pair generation"
fi

# Function to append the local public key to the authorized_keys file on the remote server
function append_public_key {
  downloads_dir="$HOME/Downloads"
  private_key_file=$(find "$downloads_dir" -type f -name "*.pem" -print -quit)

  public_key=$(cat ~/.ssh/id_rsa.pub)
  ssh -i "$private_key_file" "$username@$host" "echo \"$public_key\" >> ~/.ssh/authorized_keys"
}

# Ask user if they want to append the public key
echo
echo
echo "*** It should be 'yes' onece in a physical system, 'Not recommended more than two times' ***"
read -p "Do you want to append your public key to the remote server? (y/n) " response
echo
if [[ "$response" == "y" || "$response" == "Y" ]]; then
  append_public_key
  echo "Public key appended to authorized_keys file on remote server."
  echo
else
  echo "Public key was not appended to the remote server."
  echo
fi



# Loop through the options and perform the corresponding action
while true
do
  echo "What do you want to do?"
  echo "1. Put a file"
  echo "2. Get a file"
  echo "3. Quit"

  # Prompt the user for their choice
  read -p "Enter your choice (1-3): " choice

  case $choice in
    1)
      # Prompt the user for the local file to upload
      read -p "Enter the local file path to upload: " local_file

      # Use SFTP to upload the file to the remote server
      sftp -oBatchMode=no "$username@$host" <<EOF
        put "$local_file"
        quit
EOF
      ;;
     2)
      # Prompt the user for the remote file to download
      read -p "Enter the remote file path to download: " remote_file

      # Use SFTP to download the file from the remote server
      sftp -oBatchMode=no "$username@$host" <<EOF
        get "$remote_file"
        quit
EOF
      ;;
     3)
      # Exit the script
      echo "Exiting the script..."
      exit 0
      ;;
     *)
      # Invalid choice
      echo
      echo "Invalid choice. Please enter a number from 1-3."
      echo
      ;;
  esac
done
}





while true; do
    echo
    read -p "Whose family do you belong to?: " name

    if [ "$name" == "Techgenies" ] || [ "$name" == "techgenies" ]; then
        echo ""
        echo "Oh Wow, Welcome to Techgenies's world"
        sleep 1
        echo ""
        echo "What would you like to do here? All are your"
        echo
        echo "1 - Create New Users"
        echo "2 - To Delete User"
        echo "3 - Change hostname"
        echo "4 - Connect to guest-machine from physical-host via ssh"
        echo "5 - Connect to aws-server via ssh"
        echo "6 - Copy One directory to other directory"
        echo "7 - Copy From Host To Guest/Server"
        echo "8 - Copy From Server/Guest to Host"
        echo "9 - Copy From Aws-instance/server to physical host"
        echo "10 - Copy From physical host to Aws-instance/server"
        echo "11 - Start FTP"
        echo "12 - Start SFTP"
        echo "19 - Exit"
        echo

        read distro

        case $distro in
            1) usercreate;;
            2) userdelete;;
            3) chhost;;
            4) connect_to_server;;
            5) connectaws;;
            6) rsyncfuc;;
            7) rsyncfuc1;;
            8) rsyncfuc2;;
            9) syncaws;;
            10) syncaws1;;
            11) ftpfuc;;
            12) sftpfuc;;
            19) exit;;
            *) echo "you didn't enter an appropriate choice.";;
        esac

    else
        echo "Sorry, You are not belong to techgenies family"
        echo "Have a nice day!"
    fi

    echo
    echo
    read -p "Would you like to run the script again? (yes/no) " choice
    if [[ "$choice" =~ ^[nN][oO]?$|^no$ ]]; then
        break
    fi
done

echo "Exiting program..."

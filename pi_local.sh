#!/bin/bash

# This script will log in the address of a raspberry-pi 400 ubuntu server, copy the files over the Pi, excute the script, and SSH into the server.
PI_HOST=pi
echo -e "\n==== Validate Pi server is running ====\n"
while true
do
  if (  ping -c 1 $PI_HOST > /dev/null 2>&1 )
  then
    echo -e "\n==== Server is running  ====\n"
    break
  else
    printf "\033[31m.\033[0m"
    sleep 5
  fi
done

# Use rsync to copy files to the Pi server
echo -e "\n==== Copying files to Pi ====\n"
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519" --delete --exclude={'.git','.gitignore','commands.txt','images','README.md'} "$(pwd)" "$USER"@$PI_HOST:/home/"$USER"

# Use SSH to execute commands on the Pi server
echo -e "\n==== Executing install script ====\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@$PI_HOST ''

# SSH into Pi server
echo -e "\n==== SSH into Pi ====\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@$PI_HOST
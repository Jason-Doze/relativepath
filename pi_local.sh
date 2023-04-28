#!/bin/bash

# This script will log in the address of a raspberry-pi 400 ubuntu server, copy the files over the Pi, excute the script, and SSH into the server.

echo -e "\n==== Validate Pi server is running ====\n"
while true
do
  if ( ssh -T -o StrictHostKeyChecking=no "$USER"@"$PI_HOST" 'exit' 2>/dev/null )
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
rsync -av -e "ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519" --delete --exclude={'.git','.gitignore','commands.txt','images','README.md','node_modules'} "$(pwd)" "$USER"@"$PI_HOST":/home/"$USER"

# Use SSH to execute commands on the Pi server
echo -e "\n==== Executing install script ====\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@"$PI_HOST" 'cd relativepath && bash nginx_install.sh && bash api_deploy.sh && bash service.sh' # && bash api_deploy.sh && bash service.sh

# SSH into Pi server
echo -e "\n==== SSH into Pi ====\n"
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 "$USER"@"$PI_HOST"
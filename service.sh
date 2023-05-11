#!/bin/bash

# This script copies the service file for the expressapi and relativepath repos to systemd/system directory.

# Copy service file and reload daemon
if [ -f /etc/systemd/system/api.service ] 
then
  echo -e "\n==== Service file present ====\n"
else 
  echo -e "\n==== Copying api.service ====\n"
  sudo cp /home/jasondoze/expressapi/api.service /etc/systemd/system/ && sudo systemctl daemon-reload
fi

# Restart express api.service
if ( systemctl is-active api.service ) 
then
  echo -e "\n==== Chuckie App running ====\n"
else 
  echo -e "\n==== Starting Chuckie App ====\n"
  sudo systemctl restart api.service
fi

# Copy service file and reload daemon
if [ -f /etc/systemd/system/rp.service ] 
then
  echo -e "\n==== Service file present ====\n"
else 
  echo -e "\n==== Copying rp.service ====\n"
  sudo cp /home/jasondoze/relativepath/rp.service /etc/systemd/system/ && sudo systemctl daemon-reload
fi

# Restart rp.service
if ( systemctl is-active rp.service ) 
then
  echo -e "\n==== RP App running ====\n"
else 
  echo -e "\n==== Starting RP App ====\n"
  sudo systemctl restart rp.service
fi

echo -e "\n==== Install complete ====\n"

echo -e "\n\033[1m \033[32mIP Address:\033[0m \033[37m$( hostname -I | awk '{print $1}' ) \033[0m\n"
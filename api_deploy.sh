#!/bin/bash

# This script clones the expressapi repo from github using HTTPS, and installs dependencies

# Check for git and clone
if ( which git > /dev/null)
then 
  echo "git is present"
else  
  echo "install git"
  sudo apt install git
fi

# Clone the repo
if [ -d expressapi ] 
then
  echo -e "\n==== Repo already cloned ====\n"
else 
  echo -e "\n==== Cloning repo ====\n"
  git clone git@github.com:Jason-Doze/relativepath.git
fi

# Install NodeJS 
if ( which nodejs > /dev/null ) 
then
  echo -e "\n==== NodeJS setup present ====\n"
else 
  echo -e "\n==== Installing NodeJS setup ====\n"
  curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - 
  sudo apt install -y nodejs 
fi

# Install NPM and its dependencies
if [ -d node_modules ] 
then
  echo -e "\n==== Node_modules installed ====\n"
else 
  echo -e "\n==== Installing node_modules ====\n"
  cd /home/jasondoze/expressapi && npm install 
fi


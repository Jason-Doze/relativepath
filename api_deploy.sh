#!/bin/bash

# This script clones the expressapi repo from github using HTTPS, and installs Nodejs and its dependencies in the relativepath and expressapi repos.

# Check for git and clone
if ( which git > /dev/null )
then 
  echo -e "\n==== Git is present ====\n"
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
  git clone https://github.com/Jason-Doze/expressapi.git /home/jasondoze/expressapi
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

# Install NPM dependencies in relativepath
if [ -d /home/jasondoze/relativepath/node_modules ] 
then
  echo -e "\n==== Relativepath node_modules installed ====\n"
else 
  echo -e "\n==== Installing relativepath node_modules ====\n"
  npm install 
fi

# Install NPM dependencies in expressapi
if [ -d /home/jasondoze/expressapi/node_modules ] 
then
  echo -e "\n==== Expressapi node_modules installed ====\n"
else 
  echo -e "\n==== Installing node_modules in expressapi ====\n"
  pushd /home/jasondoze/expressapi || exit
  npm install 
  popd || exit  
fi


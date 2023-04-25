#!/bin/bash

# This script will install and run nginx in the Pi server.

if ( which nginx > /dev/null )
then 
    echo -e "\n==== Nginx is present ====\n"
else 
    echo -e "\n==== Updating apt ====\n"
    sudo apt update

    # Installing a Prebuilt Ubuntu Package from the Official NGINX Repository
    echo -e "\n==== Installing a Prebuilt Ubuntu Package ====\n"
    sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring

    # Import an official nginx signing key so apt could verify the packages authenticity. Fetch the key:
    echo -e "\n==== Importing nginx signing key ====\n"
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg > /dev/null

    # Verify that the downloaded file contains the proper key:
    echo -e "\n==== Verifying nginx signing key ====\n"
    gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

    # To set up the apt repository for stable nginx packages, run the following command:curl
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" \
        | sudo tee /etc/apt/sources.list.d/nginx.list

    # Set up repository pinning to prefer our packages over distribution-provided ones:
    echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
        | sudo tee /etc/apt/preferences.d/99nginx

    # Install NGINX Open Source
    echo -e "\n==== Installing nginx and updating apt ====\n"
    sudo apt install -y nginx

    # Start NGINX Open Source:
    echo -e "\n==== Starting nginx  ====\n"
    sudo systemctl start nginx
fi

# Copy nameless_api.conf to /etc/nginx/sites-available directory.
if [ -f /etc/nginx/sites-available/namelessapi ]
then
    echo -e "\n==== Nameless_api.conf present in sites-available ====\n"
else
    echo -e "\n==== Copying nameless_api.conf to sites-available ====\n"
    sudo cp /home/jasondoze/nameless/nameless_api.conf /etc/nginx/sites-available/namelessapi
fi

# Remove symlink to Nginx default in /etc/nginx/sites-enabled directory.
if [ -L /etc/nginx/sites-enabled/default ]
then
    echo -e "\n==== Removing default symlink ====\n"
    sudo rm /etc/nginx/sites-enabled/default
else
    echo -e "\n==== Default symlink not present ====\n"
fi

# Create symlink in /etc/nginx/sites-enabled directory.
if [ -L /etc/nginx/sites-enabled/namelessapi ]
then
    echo -e "\n==== Symlink present ====\n"
else
    echo -e "\n==== Creating symlink ====\n"
    sudo ln -s /etc/nginx/sites-available/namelessapi /etc/nginx/sites-enabled/
fi

# Restart nginx service
echo -e "\n==== Restarting nginx service ====\n"
sudo systemctl restart nginx



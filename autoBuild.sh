#!/bin/bash

# Variables for Bitbucket 

user_name="luis9897"
app_password="ATBBTxHdnrL22zgWNCtjhNe7k7Ph8C8525D0"
repo_path="bitbucket.org/z-idan/get-a-vet-frontend.git"
project_name="get-a-vet-frontend"

cd /var/www/

sudo rm -rf "/var/www/$project_name"
sudo git clone "https://$user_name:$app_password@$repo_path"

sudo apt install npm

sudo apt install curl

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt install yarn

cd "/var/www/$project_name/"

sudo yarn install

sudo yarn build

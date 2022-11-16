
#!/bin/bash

# Variables for Auto SSL install with Certbot
domain_name="example.com"
www_domain_name="www.example.com"
mail_name="mymailid@gmail.com"

echo -e "\033[1;32mHello, Starting script to create SSL with certbot ..."

# Check if Nginx is already installed

sudo apt update

if [ -e /var/run/nginx.pid ]
then 
	echo -e "\033[1;32mNginx is already running ... "; 
else 
	echo -e "\033[1;32mInstalling Nginx ..."
	sudo apt install nginx
fi

# Install the Certbot

echo -e "\033[1;32mInstalling certbot ..."

sudo apt install certbot python3-certbot-nginx

nginx_conf_path="/etc/nginx/sites-available/default"

default_setting="server_name _"

updated_setting="server_name $domain_name $www_domain_name"; 


# Confirm the Nginx Conf

echo -e "\033[1;32mConfirming Nginx's configuration ... "

if [[ $domain_name != "" && $www_domain_name != "" ]]
then
	sudo sed -i "s/$default_setting/$updated_setting/gi" $nginx_conf_path
fi
sudo nginx -t
sudo systemctl reload nginx


# Allow HTTPS through the firewall

echo -e "\033[1;32mAllowing HTTPS Through the Firewall ... "

sudo ufw status

sudo ufw allow 'Nginx Full'


# Obtaining an SSL Certificate with Certbot

echo -e "\033[1;32mObtaining an SSL Certificate with Certbot ... "

sudo certbot run -n --nginx --agree-tos -d $domain_name -d $www_domain_name -m $mail_name --redirect

sudo systemctl status certbot.timer


# Verifying Certbot Auto-Renewal 

echo -e "\033[1;32mVerifying Certbot Auto-Renewal ... "

sudo certbot renew --dry-run

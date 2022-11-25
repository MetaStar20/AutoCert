
#!/bin/bash

# Check if Nginx is already installed

sudo apt update

if [ -e /var/run/nginx.pid ]
then 
	echo -e "\033[1;32mNginx is already running ... "; 
else 
	echo -e "\033[1;32mInstalling Nginx ..."
	sudo apt install nginx
fi


# Confirm the Nginx Conf

echo -e "\033[1;32mConfirming Nginx's configuration ... "

sudo nginx -t
sudo systemctl reload nginx


# Allow HTTPS through the firewall

echo -e "\033[1;32mAllowing HTTPS Through the Firewall ... "

sudo ufw status

sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx Full'

sudo systemctl status nginx

# To re-enable the service to start up at boot, you can type:
sudo systemctl enable nginx
sudo systemctl restart nginx







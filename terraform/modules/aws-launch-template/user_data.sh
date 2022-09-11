#!/bin/bash
apt update -y
apt install -y apache2
systemctl enable apache2
systemctl start apache2
mkdir /tmp/portfolio
cd /tmp/portfolio && git clone https://github.com/patrickellis/Portfolio
cp -rf Portfolio/* /var/www/html/
sed -i "s/placeholder-header/$(hostname -f)/g" /var/ww/html/all/menu.html

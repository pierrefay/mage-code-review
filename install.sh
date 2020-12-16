#!/bin/bash
apt-get update
apt-get install -y python3-pip python3  wget curl
pip3 install prettytable beautifulsoup4 lxml
curl -sS http://files.magerun.net/n98-magerun-latest.phar -o n98-magerun.phar
chmod +x ./n98-magerun.phar
mv ./n98-magerun.phar /usr/bin/magerun

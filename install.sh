#!/bin/bash
apt-get install python python-prettytable python-bs4 wget curl
curl -sS http://files.magerun.net/n98-magerun-latest.phar -o n98-magerun.phar
chmod +x ./n98-magerun.phar
mv ./n98-magerun.phar /usr/bin/magerun

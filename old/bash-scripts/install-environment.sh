#!/bin/bash

# ################################################################################ Drupal sites
# Create folder for websites to live in
sudo mkdir $QS_WEBROOT
sudo chown `whoami`:www-data $QS_WEBROOT
sudo chmod -R ug=rwX,o= $QS_WEBROOT


# ################################################################################ Log Files
LOGS=$QS_WEBROOT/logs
mkdir $LOGS

# Apache error logs are configured in the VirtualHosts section of each website (default from apache2.conf)
sudo touch     /var/log/apache2/error.log
sudo chmod g+w /var/log/apache2/error.log
ln -s          /var/log/apache2/error.log                $LOGS/apache-error.log
# This file catches any unconfigured log info for virtualhosts (default from apache2.conf)
sudo touch     /var/log/apache2/other_vhosts_access.log
sudo chmod g+w /var/log/apache2/other_vhosts_access.log
ln -s          /var/log/apache2/other_vhosts_access.log  $LOGS/apache-access.log
# php error logs are configured in php.ini  (changed in install-3-lamp.sh)
sudo touch     /var/log/php-error.log
sudo chmod g+w /var/log/php-error.log
ln -s          /var/log/php-error.log                    $LOGS/php-error.log
# MySQL error and slow query logs (changed in install-2-lamp.sh)
sudo touch     /var/log/mysql/error.log
sudo chmod g+w /var/log/mysql/error.log
ln -s          /var/log/mysql/error.log                  $LOGS/mysql-error.log
sudo touch     /var/log/mysql/mysql-slow.log
sudo chmod g+w /var/log/mysql/mysql-slow.log
ln -s          /var/log/mysql/mysql-slow.log             $LOGS/mysql-slow.log



# ################################################################################ Config Files
CONFIGS=$QS_WEBROOT/config
mkdir $CONFIGS
sudo chmod -R g+w /etc/apache2
ln -s /etc/apache2/apache2.conf      $CONFIGS/apache2.conf
ln -s /etc/apache2/httpd.conf        $CONFIGS/httpd.conf
ln -s /etc/apache2/ports.conf        $CONFIGS/ports.conf
ln -s /etc/apache2/sites-enabled/    $CONFIGS/apache-sites-enabled
sudo chmod -R g+w /etc/php5
ln -s /etc/php5/apache2/php.ini      $CONFIGS/php-apache.ini
ln -s /etc/php5/cli/php.ini          $CONFIGS/php-cli.ini
sudo chmod -R g+w /etc/mysql
ln -s /etc/mysql/my.cnf              $CONFIGS/mysql.cnf
sudo chmod g+w /etc/hosts
ln -s /etc/hosts                     $CONFIGS/hosts

echo "This folder contains links (shortcuts) to LAMP configuration files located around
quickstart.  To see the links, and where they point to, start a terminal and type:

ll

This will list the files and where they link to." > $CONFIGS/README.txt

# ###### Restart Servers
sudo service mysql restart
sudo apache2ctl restart

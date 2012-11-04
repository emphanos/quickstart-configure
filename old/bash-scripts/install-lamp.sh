#!/bin/bash

# ##### Install LAMP packages

# Define package names, and debconf config values.  Keep package names in sync.
LAMP_APACHE="libapache2-mod-php5"

LAMP_MYSQL="mysql-server libmysqlclient18 mysql-common"
echo mysql-server-5.5 mysql-server/root_password        password quickstart | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again  password quickstart | sudo debconf-set-selections

LAMP_PHP="php5 php-apc php5-cli php5-curl php5-gd php5-imap php5-mysql php5-mcrypt php5-sqlite php5-xdebug php5-xsl php-pear"

LAMP_TOOLS="phpmyadmin"
echo phpmyadmin       phpmyadmin/reconfigure-webserver  text     apache2    | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/dbconfig-install       boolean  true       | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/app-password-confirm   password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/admin-pass       password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/password-confirm       password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/setup-password         password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/app-pass         password quickstart | sudo debconf-set-selections

# Now install the packages.  debconf shouldn't need to ask so many questions.
sudo apt-get -yq install $LAMP_APACHE $LAMP_MYSQL $LAMP_PHP $LAMP_TOOLS


# ###### Configure APACHE

sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2dismod cgi
sudo a2dismod autoindex
# configure default site
echo "<VirtualHost *:80>
  DocumentRoot /var/www
  <Directory /var/www/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
  </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/000-default  > /dev/null
sudo a2ensite 000-default

# Fix ssl for easier virtual hosting
echo "NameVirtualHost *:80
Listen 80
<IfModule mod_ssl.c>
    NameVirtualHost *:443
    Listen 443
</IfModule>" | sudo tee /etc/apache2/ports.conf > /dev/null

echo "<IfModule mod_ssl.c>
<VirtualHost *:443>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www
  <Directory />
    Options FollowSymLinks
    AllowOverride None
  </Directory>
  <Directory /var/www/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride None
    Order allow,deny
    allow from all
  </Directory>
  SSLEngine on
  SSLCertificateFile    /etc/ssl/certs/ssl-cert-snakeoil.pem
  SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
</VirtualHost>
</IfModule>" | sudo tee /etc/apache2/sites-available/default-ssl > /dev/null
sudo a2ensite default-ssl


# ################################################################################ Configure MYSQL

sudo sed -i 's/#log_slow_queries/log_slow_queries/g'          /etc/mysql/my.cnf
sudo sed -i 's/#long_query_time/long_query_time/g'            /etc/mysql/my.cnf


# ################################################################################ Configure PHP
# FIXME haven't checked for unnecessary code since 9.10
# sudo sed -i 's/find_this/replace_with_this/g' infile1 infile2 etc
sudo sed -i 's/magic_quotes_gpc = On/magic_quotes_gpc = Off/g'                       /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/short_open_tag = On/short_open_tag = Off/g'                           /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/max_execution_time = 30/max_execution_time = 300/g'                   /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/memory_limit = 16M/memory_limit = 64M/g'                              /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/memory_limit = 32M/memory_limit = 64M/g'                              /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g'                 /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/post_max_size = 8M/post_max_size = 50M/g'                             /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/;error_log = filename/error_log = \/var\/log\/php-error.log/g'        /etc/php5/apache2/php.ini /etc/php5/cli/php.ini # php 5.2
sudo sed -i 's/;error_log = php_errors.log/error_log = \/var\/log\/php-error.log/g'  /etc/php5/apache2/php.ini /etc/php5/cli/php.ini # php 5.3
sudo sed -i 's/display_errors = Off/display_errors = On/g'                           /etc/php5/apache2/php.ini /etc/php5/cli/php.ini
sudo sed -i 's/display_startup_errors = Off/display_startup_errors = On/g'           /etc/php5/apache2/php.ini /etc/php5/cli/php.ini

# Fix comment bug that will show warning on command line
sudo sed -i 's/# /\/\/ /g'            /etc/php5/cli/conf.d/mcrypt.ini
sudo sed -i 's/# /\/\/ /g'            /etc/php5/cli/conf.d/imap.ini

# Install upload progress (warning in D7)
sudo pecl -q install uploadprogress
echo "extension=uploadprogress.so" | sudo tee /etc/php5/apache2/conf.d/uploadprogress.ini > /dev/null


# ################################################################################ Restart Servers
sudo service mysql restart
sudo apache2ctl restart

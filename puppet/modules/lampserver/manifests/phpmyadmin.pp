class lampserver::phpmyadmin ( $username, $mode ) {

	exec { "phpmyadmin_config":
		command => "cat << EOF | debconf-set-selections
echo phpmyadmin       phpmyadmin/reconfigure-webserver  text     apache2    | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/dbconfig-install       boolean  true       | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/app-password-confirm   password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/admin-pass       password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/password-confirm       password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/setup-password         password quickstart | sudo debconf-set-selections
echo phpmyadmin       phpmyadmin/mysql/app-pass         password quickstart | sudo debconf-set-selections
EOF",
		require => Class[ [apache, php, mysql] ],
	}

	package { "phpmyadmin": 
		require => Exec["phpmyadmin_config"],
	}
}

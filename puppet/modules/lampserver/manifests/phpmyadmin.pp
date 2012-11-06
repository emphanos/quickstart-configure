class lampserver::phpmyadmin ( $username, $mode ) {

	exec { "phpmyadmin_config":
		command => "cat << EOF | debconf-set-selections
mysql-server-5.0 mysql-server/root_password password $username
mysql-server-5.0 mysql-server/root_password_again password $username
mysql-server-5.0 mysql-server/root_password seen true
mysql-server-5.0 mysql-server/root_password_again seen true
EOF",
		require => Class[ [apache, php, mysql] ],
	}

	package { "phpmyadmin": 
		require => Exec["phpmyadmin_config"],
	}
}

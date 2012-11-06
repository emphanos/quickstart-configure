class lampserver::lamp ( $username, $mode ) {

	/* apache */

	class { "apache": }
	apache::module { 'ssl': }
	apache::module { 'rewrite': }
	apache::module { 'cgi': ensure => absent}
	apache::module { 'autoindex': ensure => absent}

	file { "apache_default":
		path    => "/etc/apache2/sites-available/000-default",
		content => template("lampserver/000-default.erb"),
		require => Class[apache],
		notify => Service[apache],
	}
	file { "apache_default_ssl":
		path    => "/etc/apache2/sites-available/default-ssl",
		content => template("lampserver/default-ssl.erb"),
	}
	file { "apache_ports_conf":
		path    => "/etc/apache2/ports.conf",
		content => template("lampserver/ports.conf.erb"),
	}



	/* mysql */

	exec { "mysql_config":
		command => "cat << EOF | debconf-set-selections
mysql-server-5.0 mysql-server/root_password password $username
mysql-server-5.0 mysql-server/root_password_again password $username
mysql-server-5.0 mysql-server/root_password seen true
mysql-server-5.0 mysql-server/root_password_again seen true
EOF",
	}
	class { "mysql": 
		require => Exec["mysql_config"],
	}


	/* php */

	class { 'php': }
	php::module { "apc": module_prefix => "php-" }
	php::module { "cli": }
	php::module { "curl": }
	php::module { "gd": }
	php::module { "imap": }
	php::module { "mcrypt": }
	php::module { "mysql": }
	php::module { "pear": module_prefix => "php-" }
	php::module { "sqlite": }
	php::module { "xsl": }
}

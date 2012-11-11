/* install a LAMP stack */
class lampserver::lamp ( $username, $mode ) {


/* apache */
	class { "apache": }
	apache::module { 'ssl': }
	apache::module { 'rewrite': }
	apache::module { 'cgi': ensure => absent}
	apache::module { 'autoindex': ensure => absent}

	file { "/var/www/index.html":
		ensure => absent,
		require => Class[apache],
	}
	file { "/var/www/index.php":
		content => template("lampserver/index.php.erb"),
		require => Class[apache],
	}

	apache::vhost { "default":
		template => "lampserver/000-default.erb",
	}
	apache::vhost { "default_ssl":
		template => "lampserver/default-ssl.erb",
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
	/* augeas didn't work here with my.cnf */
	exec { "mysql_config_test":
		command => "sed -i 's/#log_slow_queries/log_slow_queries/g' /etc/mysql/my.cnf; sed -i 's/#long_query_time/long_query_time/g' /etc/mysql/my.cnf",
		require => Class[mysql],
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

	/* configure uploadprogress */
	exec { "uploadprogress":
		command => "pecl install uploadprogress",
		require => Php::Module[pear],
		unless => "pecl list | grep uploadprogress",
	}
	file { "/etc/php5/apache2/conf.d/uploadprogress.ini": 
		content => "extension=uploadprogress.so",
		require => Class[php],
		notify => Service[apache],
	}

	/* setup email logging */
	file { "/var/quickstart/logs/mail":
		ensure => directory,
		owner => $username,
		group => $username,
		require => Class["lampserver::lamp_logs"],
	}
	file { "/var/quickstart/logs/mail/email.php":
		content => template("lampserver/email.php.erb"),
		mode => 755,
		require => [ Class["lampserver::lamp_logs"], File['/var/quickstart/logs/mail'] ], 
	}

	/* configure php.ini to test or prod */
	file { "/etc/php5/apache2/conf.d/quickstart.ini": 
		content => template("lampserver/quicktest.php.ini.erb"),
		require => Class[php],
		notify => Service[apache],
	}
	file { "/etc/php5/cli/conf.d/quickstart.ini": 
		content => template("lampserver/quicktest.php.ini.erb"),
		require => Class[php],
		notify => Service[apache],
	}
		
}

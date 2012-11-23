/* setup logs */
class lampserver::lamp_logs ( $username, $mode, $logdir, $configdir ) {


/* Link Logs */
	lampserver::lamp_link { "${logdir}/apache-error.log":
		path=> "${logdir}/apache-error.log",
		target => "/var/log/apache2/error.log",
		owner => $username,
	} ->
	lampserver::lamp_link { "${logdir}/apache-access.log":
		path => "${logdir}/apache-access.log",
		target => "/var/log/apache2/other_vhosts_access.log",
		owner => $username,
	} ->
	lampserver::lamp_link { "${logdir}/php-error.log":
		path => "${logdir}/php-error.log",
		target => "/var/log/php-error.log",
		owner => $username,
	} ->
	lampserver::lamp_link {"${logdir}/mysql-error.log":
		path => "${logdir}/mysql-error.log",
		target => "/var/log/mysql/error.log",
		owner => $username,
	} ->
	lampserver::lamp_link { "${logdir}/mysql-slow.log":
		path => "${logdir}/mysql-slow.log",
		target => "/var/log/mysql/mysql-slow.log",
		owner => $username,
	} ->
	/* FIXME this should be template */
	file { "${logdir}/README.txt":
		content => "This folder contains links (shortcuts) to LAMP log files.
To see the links, and where they point to, start a terminal and type:

ll

This will list the files and where they link to.",
	} ->


/* Link Config */
	lampserver::lamp_link { "${configdir}/apache2.conf":
		path => "${configdir}/apache2.conf",
		target => "/etc/apache2/apache2.conf",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/httpd.conf":
		path => "${configdir}/httpd.conf",
		target => "/etc/apache2/httpd.conf",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/ports.conf":
		path => "${configdir}/ports.conf",
		target => "/etc/apache2/ports.conf",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/apache-sites-enabled":
		path => "${configdir}/apache-sites-enabled",
		target => "/etc/apache2/sites-enabled/",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/php-apache.ini":
		path => "${configdir}/php-apache.ini",
		target => "/etc/php5/apache2/php.ini",
		owner => $username,
	} ->
	lampserver::lamp_link {"${configdir}/php-cli.ini":
		path => "${configdir}/php-cli.ini",
		target => "/etc/php5/cli/php.ini",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/mysql.cnf":
		path => "${configdir}/mysql.cnf",
		target => "/etc/mysql/my.cnf",
		owner => $username,
	} ->
	lampserver::lamp_link { "${configdir}/hosts":
		path => "${configdir}/hosts",
		target => "/etc/hosts",
		owner => $username,
	} ->
	/* FIXME this should be template */
	file { "${confdir}/README.txt":
		content => "This folder contains links (shortcuts) to LAMP configuration files.
To see the links, and where they point to, start a terminal and type:

ll

This will list the files and where they link to.",
	}

}

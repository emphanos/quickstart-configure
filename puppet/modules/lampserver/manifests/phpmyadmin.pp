/* install and configure phpmyadmin */
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
	} ->

	package { "phpmyadmin": 
		require => Exec["phpmyadmin_config"],
	}

	$phpmyadmin_config = "# Show 1000 rows instead of 30 by default
\\\$cfg['MaxRows'] = 1000;
# Show BLOB data as a string not hex.
\\\$cfg['DisplayBinaryAsHex'] = false;
# Show BLOB data in row detail pages.
\\\$cfg['ProtectBinary'] = false;
# Show BLOB data on table browse pages.  Hack to hardcode all requests.
\\\$_REQUEST['display_blob'] = true;

# Prevent timeout for a year at a time.
\\\$cfg['LoginCookieValidity'] = 60*60*24*7*52;
ini_set('session.gc_maxlifetime', \\\$cfg['LoginCookieValidity']);
"

	util::addchunk { "phpmyadmin_config":
		file => "/etc/phpmyadmin/config.inc.php",
		sectionname => "display config",
		lines => $phpmyadmin_config,
		require => Package[phpmyadmin],
	}

}

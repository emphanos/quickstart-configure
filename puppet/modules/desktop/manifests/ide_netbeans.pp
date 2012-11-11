/* install and configure netbeans */
class quickbase::ide_netbeans ($username, $mode) {


	$source_url = 'http://download.netbeans.org/netbeans/7.2.1/final/bundles/netbeans-7.2.1-ml-php-linux.sh'

/* install java */
	package { ['openjdk-6-jdk']: ensure => installed }

	
	file { "/home/${username}/netbeans-install.sh":
		source => $source_url,
	}

}

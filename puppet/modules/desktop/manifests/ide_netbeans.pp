/* install and configure netbeans */
class desktop::ide_netbeans ($username, $mode) {

	$source_url = "http://download.netbeans.org/netbeans/7.2.1/final/bundles/netbeans-7.2.1-ml-php-linux.sh"
	$destination = "/home/${username}/netbeans-install.sh"
	$install_dir = "/home/${username}/netbeans-7.2.1"

/* install java */
	package { ['openjdk-6-jdk']: ensure => installed }

	exec { "netbeans_download":
		command => "wget ${source_url} --output-document=${destination}",
		user => $username,
		creates => $destination,
	}
		
	exec { "netbeans_install":
		command => "chmod 644 ${destination} ; ${destination} --silent --nospacecheck",
		user => $username,
		timeout => 600,
		creates => $install_dir,
		require => [ Exec[netbeans_download], Package[openjdk-6-jdk] ], 
	}

}

/* install and configure netbeans */
class desktop::ide_netbeans ($username, $mode) {

	$source_url = "http://download.netbeans.org/netbeans/7.2.1/final/bundles/netbeans-7.2.1-ml-php-linux.sh"
	$destination = "/home/${username}/netbeans-install.sh"
	$install_dir = "/home/${username}/netbeans-7.2.1"

/* install java */
	package { [openjdk-6-jdk]: ensure => present }

/* Getting the most recent version is very time consuming.  Just getting the package from Ubuntu is older, but fine FIXME */
	package { [netbeans]: ensure => present, }
/*
	exec { "netbeans_download":
		command => "wget ${source_url} --output-document=${destination}",
		user => $username,
		creates => $destination,
		require => Package[openjdk-6-jdk],
	} ->
	exec { "netbeans_install_permissions":
		command => "chmod 755 ${destination}",
		user => $username,
		require => [ Exec[netbeans_download], Package[openjdk-6-jdk] ], 
	} ->
		
	exec { "netbeans_install":
		command => "${destination} --silent --nospacecheck",
		user => $username,
		timeout => 900,
		creates => $install_dir,
		require => [ Exec[netbeans_install_permissions], Package[openjdk-6-jdk] ], 
	}
*/

}

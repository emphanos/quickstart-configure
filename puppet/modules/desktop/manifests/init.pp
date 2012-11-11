/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	include desktop::cinnamon

	package { ['gitg']: ensure => installed, }

	class { "desktop::ide_netbeans": username => $username, mode => $mode, }
	class { "desktop::gedit": username => $username, mode => $mode, }

}

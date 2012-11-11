/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	include desktop::cinnamon

/* install random graphical tools */
	package { ['gitg']: ensure => installed, }

	include desktop::ide_netbeans

}

/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	class { "desktop::cinnamon":
		username => $username,
		mode => $mode,
	}
}

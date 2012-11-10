/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	include desktop::cinnamon
	include desktop::tools
	include desktop::ide_netbeans

}

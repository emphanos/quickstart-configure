/**
 * This should install/configure
 * - Drush
 * - Drush aware shell
 * - Quickstart Drush
 */ 
class drupalserver( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	class lampserver { $username, $mode }

	class drupalserver::drush { $username, $mode }
	class drupalserver::drushawareshell { $username, $mode }
	class drupalserver::quickstartdrush { $username, $mode }
	
}

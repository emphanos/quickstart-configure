/**
 * This should install/configure
 * - Drush
 * - Drush aware shell
 * - Quickstart Drush
 */ 
class drupalserver ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	class { "lampserver":
		username => $username,
		mode => $mode,
	}
/* FIXME
	class { "drupalserver::drush":
		username => $username,
		mode => $mode,
	}
	class { "drupalserver::drushawareshell":
		username => $username,
		mode => $mode,
	}
	class { "drupalserver::quickstartdrush":
		username => $username,
		mode => $mode,
	}
*/
}

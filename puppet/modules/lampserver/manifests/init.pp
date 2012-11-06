/**
 * This should install/configure
 * - lamp packages
 * - phpmyadmin
 * - xdebug.  Turn on $mode=test, off $mode=prod
 * - tools: wget
 * - vcs: git, svn, cvs, merfurial, bazaar
 * - git aware shell
 * - motd: Message based on $mode
 * - configure automatic security updates
 * - configure dns all sites in .dev point to localhost
 */ 
class lampserver( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	include lampserver::update
	class { "lampserver::lamp":
		username => $username,
		mode => $mode,
	}

	class { "lampserver::phpmyadmin":
		username => $username,
		mode => $mode,
	}
/*
	class { "lampserver::xdebug":
		username => $username,
		mode => $mode,
	}
*/
/*	include lampserver::tools  FIXME debug time */

	class { "lampserver::bash_profile":
		username => $username,
		mode => $mode,
	}

	class { "lampserver::motd":
		username => $username,
		mode => $mode,
	}
	include lampserver::autoupdate
	include lampserver::dnsmasq

}


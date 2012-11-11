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

/* Define defaults */
	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	
/* We can assume everything in quickstart-build/QuickBase/puppet/mainifests/quickbase/manifests/init.pp happened
	- server updated
	- user created
	- /var/quickstart created
	- /var/quickstart/quickstart-configure cloned
	*/


/* Install lampserver devops tools */
	package { ['wget', 'git', 'subversion', 'cvs', 'mercurial', 'bzr' ]: ensure => installed, }


/* Install the lampserver::lamp stack */
	class { "lampserver::lamp": username => $username, mode => $mode, }


/* Install phpmyadmin */
	class { "lampserver::phpmyadmin":
		username => $username,
		mode => $mode,
		require => Class["lampserver::lamp"],
	}


/* Install xdebug */
	class { "lampserver::xdebug": username => $username, mode => $mode, }


/* Setup Logs */
	$logdir = "/var/quickstart/logs"
	$configdir = "/var/quickstart/config"
	exec {"log_conf_dirs":
		command => "mkdir -p ${logdir} ; mkdir -p ${configdir}",
		user => $username,
		require => Class["lampserver::lamp"],
	}
	class { "lampserver::lamp_logs":
		username => $username,
		mode => $mode,
		logdir => $logdir,
		configdir => $configdir,
		require => Exec["log_conf_dirs"],
	}


/* Setup user profile for command line fancy */
	class { "lampserver::bash_profile": username => $username, mode => $mode, }


/* Fancy Message at login */
	class { "lampserver::motd": username => $username, mode => $mode, }


/* Automatic security updates */
	include lampserver::autoupdate


/* all .dev domains point to localhost */
	include lampserver::dnsmasq

}


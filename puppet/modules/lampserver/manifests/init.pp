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
	$logdir = "/var/quickstart/logs"
	$configdir = "/var/quickstart/config"

	
/* We can assume everything in quickstart-build/QuickBase/puppet/mainifests/quickbase/manifests/init.pp happened
	- server updated
	- user created
	- /var/quickstart created
	- /var/quickstart/quickstart-configure cloned
	*/


/* Install lampserver devops tools */
	package { ['git', 'subversion', 'cvs', 'mercurial', 'bzr' ]: ensure => installed, }


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

	file { "${logdir}": 
		ensure => directory,
		owner => $username,
		group => "www-data",
	}
	file { "${configdir}": 
		ensure => directory,
		owner => $username,
		group => "www-data",
	}
	class { "lampserver::lamp_logs":
		username => $username,
		mode => $mode,
		logdir => $logdir,
		configdir => $configdir,
		require => [ File["${logdir}"], File["${configdir}"] ],
	}


/* Setup user profile for command line fancy */
	class { "lampserver::bash_profile": username => $username, mode => $mode, }


/* Fancy Message at login */
	class { "lampserver::motd": username => $username, mode => $mode, }


/* Automatic security updates */
	class { "lampserver::autoupdate": }


/* Updates from cache */
	if $params::debug == 'debug' {
		file { "/etc/apt/apt.conf.d/01proxy":
			content => "Acquire::http::Proxy \"http://<IP address or hostname of the apt-cacher server>:3142\";",
		}
	}

/* all .dev domains point to localhost */
	class { "lampserver::dnsmasq": }

}


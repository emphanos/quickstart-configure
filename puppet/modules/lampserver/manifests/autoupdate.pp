class lampserver::autoupdate {

	/* https://help.ubuntu.com/community/AutomaticSecurityUpdates */

	package { ['unattended-upgrades']:
		ensure => installed,
	}

	file { "/etc/apt/apt.conf.d/20auto-upgrades" :
		content => template("lampserver/autoupdate-apt-20auto-upgrades.erb"),
		require => package['unatended-upgrades'],
	}

	file { "/etc/apt/apt.conf.d/50unattended-upgrades" :
		content => template("lampserver/autoupdate-apt-20auto-upgrades.erb"),
		require => package['unatended-upgrades'],
	}

}

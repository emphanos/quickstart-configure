class lampserver::autoupdate {

	/* https://help.ubuntu.com/community/AutomaticSecurityUpdates */
	/* FIXME is this working? */
	package { ['unattended-upgrades']:
		ensure => installed,
	}

	file { "/etc/apt/apt.conf.d/20auto-upgrades" :
		content => template("lampserver/autoupdate-apt-20auto-upgrades.erb"),
		require => Package['unattended-upgrades'],
	}

	file { "/etc/apt/apt.conf.d/50unattended-upgrades" :
		content => template("lampserver/autoupdate-apt-20auto-upgrades.erb"),
		require => Package['unattended-upgrades'],
	}

}

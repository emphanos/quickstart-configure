class drupalserver::drush ( $username, $mode ) {

	package { ['drush']:
		ensure => installed,
	}

	exec { "drushupgrade":
		command => "drush -y dl drush --destination='/usr/share'",
		require => Package[[drush]],
	}

	/* see lampserver:bash_profile for drush command completion */

}


class drupalserver::drush ( $username, $mode ) {

	package { ['drush']:
		ensure => installed,
	}

	exec { "drush update":
		command => "sudo drush -y self-update",
		require => Package[[drush]],
	}

	/* FIXME this isn't adding to the .bash_profile */
	exec { "drush .drush_bashrc":
		command => "echo \"if [ -f ~/.drush_bashrc ] ; then . /usr/share/drush/examples/example.drushrc ; fi\" >> /home/${username}/.bash_profile",
		unless => "grep -q '/usr/share/drush/examples/example.drushrc' /home/${username}/.bash_profile",
		require => Package[[drush]],
		user => $username,
	}

}


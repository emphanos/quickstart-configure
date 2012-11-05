class drupalserver::quickstartdrush ( $username, $mode ) {

	/* Create quickstart configuration code directory */
	/* FIXME is this actually needed? */
	file { "/var/quickstart/quickstart-drupal":
	  ensure => "directory",
	  owner  => $username,
	  group  => "www-data",
	  mode   => 770,
	}

	package { ['git']:
		ensure => installed,
	}

	/* Clone read-only repo for further configuration */
	exec { "quickstart-drush repo": 
	  command => "git clone --recursive git://github.com/quickstart/quickstart-drupal.git /var/quickstart/quickstart-drupal",
	  require => [Package[[git]], File["/var/quickstart/quickstart-drupal"] ],
	  user => $username,
	  unless => "test -d /var/quickstart/quickstart-drupal/.git",
	}

}

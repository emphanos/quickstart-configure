/**
 * This should install/configure
 * - Drush (and Drush aware shell)
 * - Quickstart Drush
 */ 
class drupalserver ( $username, $mode ) {

/* Set defaults */
	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }


/* Install the LAMP Server */
	class { "lampserver": username => $username, mode => $mode, }


/* Install Drush */
	package { ['drush']: ensure => installed, }
	/* Update Drush */
	exec { "drush-upgrade":
		command => "drush -y dl drush --destination='/usr/share'",
		require => Package[drush],
	} ->
	/* see lampserver:bash_profile for drush command completion */


/* Install Quickstart Drush Extensions */
	exec { "quickstart-drush": 
	  command => "git clone --recursive git://github.com/quickstart/quickstart-drupal.git /var/quickstart/quickstart-drupal",
	  user => $username,
	  unless => "test -d /var/quickstart/quickstart-drupal/.git",
	  require => [ Package['git'], Exec['drush-upgrade' ] ],
	} ->
	file { "/home/${username}/.drush":
		ensure => 'directory',
		owner => $username,
		group => $username,
	} ->
	file { "/home/${username}/.drush/quickstart-drush":
		ensure => 'link',
		owner => $username,
		group => $username,
		target => '/var/quickstart/quickstart-drupal',
		require => [File["/home/${username}/.drush"], Exec[quickstart-drush] ],
	}

}

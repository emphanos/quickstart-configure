/* Make links to logs and config files */
define lampserver::lamp_link ($path, $target, $owner, $group="www-data", $mode=644) {

/* FIXME DELETEME 
	exec { "${path}_touch":
		command => "touch ${path}; chmod g+w ${path}",
	}
*/
	file { "${path}":
		path => "${path}",
		target => "${target}",
		owner => $owner,
		group => $group,
		mode => $mode,
		ensure => link,
/*		require => Exec["${path}_touch"],*/
	}

}


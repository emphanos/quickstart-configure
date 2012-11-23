/* Make links to logs and config files */
define lampserver::lamp_link ($path, $target, $owner, $group="www-data", $mode=644) {

	file { "${path}":
		path => "${path}",
		target => "${target}",
		owner => $owner,
		group => $group,
		mode => $mode,
		ensure => link,
	}

}


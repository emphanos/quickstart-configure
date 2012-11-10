class desktop::tools {

	/* install random graphical tools */

	package { ['gitg', '', 'ruby-full', 'rubygems']:
		ensure => installed,
	}
}

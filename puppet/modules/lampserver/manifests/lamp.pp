class lampserver::lamp ( $username, $mode ) {

	class { "apache": }

	class { "mysql": }
	/* FIXME default password */

	class { 'php': }

	php::module { "apc": 
	  module_prefix => "php-"
	}
	php::module { "cli": }
	php::module { "curl": }
	php::module { "gd": }
	php::module { "imap": }
	php::module { "mcrypt": }
	php::module { "mysql": }
	php::module { "pear": 
	  module_prefix => "php-"
	}
	php::module { "sqlite": }
	php::module { "xsl": }
}

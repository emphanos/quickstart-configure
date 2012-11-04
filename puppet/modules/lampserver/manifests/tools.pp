class lampserver::tools {

	package { ['wget']:
		ensure => installed,
	}

	package { ['git', 'subversion', 'cvs', 'mercurial', 'bzr' ]:
		ensure => installed,
	}

}

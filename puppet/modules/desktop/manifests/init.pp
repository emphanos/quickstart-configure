/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	class { "desktop::cinnamon": username => $username, mode => $mode, }

	/* common tools */
	package { ['gitg', 'meld', 'gitk', 'git-gui']: ensure => installed, }
	package { ['synaptic', 'file-roller']: ensure => installed, }
	package { ['gimp', 'gimp-data', 'gimp-plugin-registry', 'gimp-data-extras']: ensure => installed, }
	package { ['unace', 'unrar', 'zip', 'unzip', 'p7zip-full', 'p7zip-rar', 'sharutils', 'rar', 'uudeview', 'mpack', 'lha', 'arj', 'cabextract']: ensure => installed, }

	/* FIXME skip netbeans for now.  So slow! */
	class { "desktop::ide_netbeans": username => $username, mode => $mode, }
	class { "desktop::gedit": username => $username, mode => $mode, }
	class { "desktop::browsers": username => $username, mode => $mode, }

	class { "desktop::examples": username => $username, mode => $mode, }
}

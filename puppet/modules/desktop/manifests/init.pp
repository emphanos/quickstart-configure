/**
 * This should install/configure
 * - The Desktop
 */ 
class desktop ( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

	class { "desktop::cinnamon": }

	/* common tools */
	package { ['gitg', 'synaptic']: ensure => installed, }

	/* disable screen saver */
	exec { "screen_off": 
		command => "gsettings set org.gnome.desktop.screensaver idle-activation-enabled false",
		requires => "ubuntu-desktop",
	}
	exec { "lock_off": 
		command => "gsettings set org.gnome.desktop.lockdown disable-lock-screen true",
		requires => "ubuntu-desktop",
	}

	/* skip netbeans for now.  So slow! */
	/* class { "desktop::ide_netbeans": username => $username, mode => $mode, } */
	class { "desktop::gedit": username => $username, mode => $mode, }
	class { "desktop::browsers": username => $username, mode => $mode, }

}

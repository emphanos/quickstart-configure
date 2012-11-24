/* Install Cinnamon desktop */
class desktop::cinnamon {

	/* install add-apt-repository command */
	package { ['python-software-properties']: }

	/* add the cinnamon PPA */
	exec { "cinnamon_ppa":
		command => "sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable; sudo apt-get -yq update",
		require => Package["python-software-properties"],
	}

	/* Install Ubuntu Desktop first.  Includes Unity and Gnome2.  Startup problems otherwise */
	package { ['ubuntu-desktop', 'gnome-session', 'lightdm', 'unity-greeter']: 
		require => Exec["cinnamon_ppa"],
	}

	/* Install Cinnamon desktop */	
	package { ['cinnamon']:
		require => Package[ubuntu-desktop],
	}

	/* Disable Cinnamon screen saver */
	exec { "screen_off": 
		command => "gsettings set org.gnome.desktop.screensaver idle-activation-enabled false",
		require => Package[cinnamon],
	}
	exec { "lock_off": 
		command => "gsettings set org.gnome.desktop.lockdown disable-lock-screen true",
		require => Package[cinnamon],
	}



}

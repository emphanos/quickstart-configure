/* Install Cinnamon desktop */
class desktop::cinnamon ($username, $mode) {

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

	/* Configure Auto login */
	file { "/etc/lightdm/lightdm.conf":
		content => template("desktop/lightdm.conf.erb"),
		require => Package[lightdm],
	}
		
	/* Install Cinnamon desktop */	
	package { ['cinnamon']:
		require => Package[ [ubuntu-desktop], [gnome-session], [lightdm], [unity-greeter] ],
	}

}

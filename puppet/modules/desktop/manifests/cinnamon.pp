class desktop::cinnamon ( $username, $mode ) {

	package { ['python-software-properties']: }

	exec { "cinnamon_ppa":
		command => "sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable; sudo apt-get -yq update",
		require => Package["python-software-properties"],
	}

	package { ['cinnamon', 'ubuntu-desktop', 'gnome-session', 'lightdm', 'unity-greeter']: 
		require => Exec["cinnamon_ppa"],
	}

}
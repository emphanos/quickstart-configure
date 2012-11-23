/* install and configure firefox and chrome, with any plugins */
class desktop::browsers ($username, $mode) {

/* install java */
	class { "util": }

	package { ['flashplugin-installer']: ensure => installed }

	package { ['chromium-browser', 'firefox']: 
		ensure => installed,
		require => Package[flashplugin-installer],
	}


	/* Download Firefox extensions to /usr/lib/firefox/extensions and they will be installed on next run */
	/* https://addons.mozilla.org/en-US/firefox/collections/Quickstart/ */
	$extensions = "/usr/lib/firefox/distribution/extensions"
	util::fetch { "firebug":
		source => "https://addons.mozilla.org/firefox/downloads/latest/1843/addon-1843-latest.xpi?src=dp-btn-primary",
		destination => "${extensions}/firebug.xpi",
	}
	util::fetch { "drupalforfirebug":
		source => "https://addons.mozilla.org/firefox/downloads/latest/8370/addon-8370-latest.xpi?src=search",
		destination => "${extensions}/drupalforfirebug.xpi",
	}
	util::fetch { "firequery":
		source => "https://addons.mozilla.org/firefox/downloads/latest/12632/addon-12632-latest.xpi?src=dp-btn-primary",
		destination => "${extensions}/firequery.xpi",
	}

	util::fetch { "colorzilla":
		source => "https://addons.mozilla.org/firefox/downloads/latest/271/addon-271-latest.xpi?src=searchy",
		destination => "${extensions}/colorzilla.xpi",
	}
	util::fetch { "dummylipsum":
		source => "https://addons.mozilla.org/firefox/downloads/latest/2064/addon-2064-latest.xpi?src=ss",
		destination => "${extensions}/dummylipsum.xpi",
	}
	util::fetch { "measureit":
		source => "https://addons.mozilla.org/firefox/downloads/latest/539/addon-539-latest.xpi?src=search",
		destination => "${extensions}/measureit.xpi",
	}

	util::fetch { "fireftp":
		source => "https://addons.mozilla.org/firefox/downloads/latest/684/addon-684-latest.xpi?src=search",
		destination => "${extensions}/fireftp.xpi",
	}
	util::fetch { "firessh":
		source => "https://addons.mozilla.org/firefox/downloads/latest/289675/addon-289675-latest.xpi?src=dp-btn-primary",
		destination => "${extensions}/firessh.xpi",
	}

	util::fetch { "yslow":
		source => "https://addons.mozilla.org/firefox/downloads/latest/5369/addon-5369-latest.xpi?src=search",
		destination => "${extensions}/yslow.xpi",
	}

}

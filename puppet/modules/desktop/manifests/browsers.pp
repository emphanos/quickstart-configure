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
	/* These are installed during manualconfig.sh */
	/* looked for better way here https://groups.google.com/d/topic/mozilla.dev.apps.firefox/Wd2XnIF1MaE/discussion */
	$extensions = "/usr/lib/firefox/distribution/extensions"
	util::fetch { "firebug":
		source => "https://addons.mozilla.org/firefox/downloads/latest/1843/addon-1843-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firebug.xpi",
	}
	util::fetch { "fireftp":
		source => "https://addons.mozilla.org/firefox/downloads/latest/684/addon-684-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/fireftp.xpi",
	}
	util::fetch { "colorzilla":
		source => "https://addons.mozilla.org/firefox/downloads/latest/271/addon-271-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/colorzilla.xpi",
	}
	util::fetch { "measureit":
		source => "https://addons.mozilla.org/firefox/downloads/latest/539/addon-539-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/measureit.xpi",
	}
	util::fetch { "yslow":
		source => "https://addons.mozilla.org/firefox/downloads/latest/5369/addon-5369-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/yslow.xpi",
	}
	util::fetch { "codeburner":
		source => "https://addons.mozilla.org/firefox/downloads/latest/10273/addon-10273-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/codeburner.xpi",
	}
	util::fetch { "firephp":
		source => "https://addons.mozilla.org/firefox/downloads/file/148319/firephp-0.7.1-fx.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firephp.xpi",
	}
	util::fetch { "firequery":
		source => "https://addons.mozilla.org/firefox/downloads/latest/12632/addon-12632-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firequery.xpi",
	}
	util::fetch { "firefinder":
		source => "https://addons.mozilla.org/firefox/downloads/latest/11905/addon-11905-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firefinder.xpi",
	}
	util::fetch { "firecookie":
		source => "https://addons.mozilla.org/firefox/downloads/latest/6683/addon-6683-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firecookie.xpi",
	}
	util::fetch { "drupalforfirebug":
		source => "https://addons.mozilla.org/firefox/downloads/latest/8370/addon-8370-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/drupalforfirebug.xpi",
	}
	util::fetch { "css_usage":
		source => "https://addons.mozilla.org/firefox/downloads/latest/10704/addon-10704-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/css_usage.xpi",
	}
	util::fetch { "inline_code":
		source => "https://addons.mozilla.org/firefox/downloads/latest/9641/addon-9641-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/inline_code.xpi",
	}
	util::fetch { "fontinfo":
		source => "https://addons.mozilla.org/firefox/downloads/file/124298/fontinfo-0.1-fx.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/fontinfo.xpi",
	}
	util::fetch { "firerainbow":
		source => "https://addons.mozilla.org/firefox/downloads/latest/9603/addon-9603-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/firerainbow.xpi",
	}
	util::fetch { "dummylipsum":
		source => "https://addons.mozilla.org/firefox/downloads/latest/2064/addon-2064-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/dummylipsum.xpi",
	}
	util::fetch { "dummyimages":
		source => "https://addons.mozilla.org/firefox/downloads/latest/76836/addon-76836-latest.xpi?src=collection&collection_id=66ca3c05-8aaf-44d8-ba37-c4169729ce5d",
		destination => "${extensions}/dummyimages.xpi",
	}


	/* Chromium extensions:

Framework Sniffer
https://chrome.google.com/webstore/detail/homgcnaoacgigpkkljjjekpignblkeae

Lorem Ipsum
https://chrome.google.com/extensions/detail/dmpfoncmmihgkooacnplecaopcefceam

Eye Dropper
https://chrome.google.com/webstore/detail/hmdcmlfkchdmnmnmheododdhjedfccka

Firebub lite
https://chrome.google.com/webstore/detail/bmagokdooijbeehmkpknfglimnifench

Measureit
https://chrome.google.com/webstore/detail/aonjhmdcgbgikgjapjckfkefpphjpgma

Live CSS
https://chrome.google.com/webstore/detail/pcfngkdgaccedbamgamojgomaibafdcg

YSlow
https://chrome.google.com/webstore/detail/ninejjcohidippngpapiilnmkgllmakh

*/

}

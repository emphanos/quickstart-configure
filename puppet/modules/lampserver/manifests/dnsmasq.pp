class lampserver::dnsmasq {

	/* Thanks! http://daniel.hahler.de/easy-dns-wildcard-setup-for-local-domains-using-dnsmasq */

	package { ['dnsmasq']:
		ensure => installed,
	}

	service { "dnsmasq":
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
	}

	exec { "dnsmasq.d":
		command => "echo \"address=/dev/127.0.0.1\" > /etc/dnsmasq.d/dev; chmod 440 /etc/dnsmasq.d/dev",
		creates => "/etc/dnsmasq.d/dev",
		require => Package[[dnsmasq]],
		notify => Service[dnsmasq],
	}

}

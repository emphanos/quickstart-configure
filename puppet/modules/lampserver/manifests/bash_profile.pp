/* Setup command line fanciness */
class lampserver::bash_profile ( $username, $mode ) {

	/* Run .bashrc on ssh logins */
	file { "bash_profile":
		path    => "/home/${username}/.bash_profile",
		owner   => $username,
		group   => $username,
		mode    => 644,
		content => template("lampserver/bash_profile.erb"),
	}

	/* quickstart custom settings */
	file { "bash_quickstart":
		path    => "/home/${username}/.bash_quickstart",
		owner   => $username,
		group   => $username,
		mode    => 644,
		content => template("lampserver/bash_quickstart.erb"),
	}

	/* Add bash_quickstart to bashrc */
	$line = template("lampserver/bashrc_snip.erb")
	exec { "bash_quickstart":
		user => $username,
		command => "/bin/echo '${line}' >> /home/${username}/.bashrc",
		unless => "/bin/grep -qF 'bash_quickstart' /home/${username}/.bashrc",
		require => [ File[bash_quickstart] ],
	}

	/* http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html */
	/* http://blog.fedora-fr.org/bochecha/post/2009/08/A-git-aware-prompt-%28part2%29 */
}




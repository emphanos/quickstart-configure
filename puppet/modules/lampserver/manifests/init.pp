/**
 * This should install/configure
 * - lamp packages
 * - phpmyadmin
 * - xdebug.  Turn on $mode=test, off $mode=prod
 * - tools: wget
 * - vcs: git, svn, cvs, merfurial, bazaar
 * - git aware shell
 * - motd: Message based on $mode
 * - configure automatic security updates
 * - configure dns all sites in .dev point to localhost
 */ 
class lampserver( $username, $mode ) {

	Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }
	
	class lampserver::update
/*	class lampserver::lamp { $username, $mode }
x	class lampserver::phpmyadmin { $username, $mode }
x	class lampserver::xdebug { $username, $mode } */
	class lampserver::tools
	class lampserver::git { $username, $mode }
	class lampserver::motd { $username, $mode }
	class lampserver::autoupdate { $username, $mode }
	class lampserver::dnsmasq
	
}


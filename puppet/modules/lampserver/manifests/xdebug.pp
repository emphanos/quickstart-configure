/* Setup XDebug */
class lampserver::xdebug ( $username, $mode ) {

	php::module { "xdebug": }

	/* for prod mode,             absent => true, */
}

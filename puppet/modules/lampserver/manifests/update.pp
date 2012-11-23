/* download and apply OS updates */
class lampserver::update {

	exec {"sudo apt-get -yq update; sudo apt-get -yq upgrade; sudo apt-get -yq autoremove":}

}


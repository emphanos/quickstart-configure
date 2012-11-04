class quickbase::motd ( $username, $mode ) {

  file { "/etc/motd" :
    content => template("motd/motd.erb")
    mode => 444,
  }
  /* Thank you! http://patorjk.com/software/taag/#p=display&f=Small%20Slant&t=PRODUCTION */
}


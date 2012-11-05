class lampserver::motd ( $username, $mode ) {

  $version = $params::version
  
  file { "/etc/motd" :
    content => template("lampserver/motd.erb"),
    mode => 444,
  }
  /* Thank you! http://patorjk.com/software/taag/ */

}

/** Various Utility functions includeing: 
 *  Fetch files with wget.  Based on https://github.com/maestrodev/puppet-wget/blob/master/manifests/init.pp 
 */

class util {
    package { "wget": ensure => installed }
}

define util::fetch($source,$destination,$timeout="0") {
  include util

  /* using "unless" with test instead of "creates" to re-attempt download
   * on empty files.
   * wget creates an empty file when a download fails, and then it wouldn't try
   * again to download the file
  */
  exec { "wget-$name":
    command => "wget --output-document=$destination $source",
    timeout => $timeout,
    unless => "test -s $destination",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/local/bin",
    require => Class[util],
  }
}

define util::authfetch($source,$destination,$user,$password="",$timeout="0") {
  include util
  
  $wgetrc_content = "password=$password"
  
  file { "/tmp/wgetrc-$name":
    owner => root,
    mode => 600,
    content => $wgetrc_content,
  } ->
  exec { "wget-$name":
    command => "wget --user=$user --output-document=$destination $source",
    timeout => $timeout,
    unless => "test -s $destination",
    environment => $environment,
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/local/bin",
    require => Class[wget],
  }
}

define util::addchunk($file, $sectionname, $lines='', $ensure = 'present') {
  exec { "exec add ${sectionname} $file":
    path => ["/bin", "/usr/bin" ],
    command => "/bin/cat <<EOF >>'${file}'

## PUPPET BEGIN ${sectionname}
${lines}
## PUPPET END ${sectionname}
EOF",
    unless => "grep -qFx '## PUPPET BEGIN ${sectionname}' '${file}'"
  }
}

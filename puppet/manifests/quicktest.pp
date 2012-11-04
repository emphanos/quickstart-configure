/** 
 * Install and configure a drupalserver in test mode
 */

/* Default resource properties */
File { owner => 0, group => 0, mode => 0644 }
Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

/* entry point */
node default {
  include params

  class { "drupalserver":
	username => "$params::username",
	mode => "test",
  }
}


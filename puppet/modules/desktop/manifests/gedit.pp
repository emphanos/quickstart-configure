/* configure gedit for dev */
class desktop::gedit ($username, $mode) {


	package { ["gedit", "gedit-plugins" ]: ensure => installed, }
	
	exec { "gedit_config":
		command => "gconftool-2 -s /apps/gedit-2/preferences/editor/auto_indent/auto_indent --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/bracket_matching/bracket_matching --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/line_numbers/display_line_numbers --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/current_line/highlight_current_line --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/right_margin/display_right_margin --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/wrap_mode/wrap_mode --type=string GTK_WRAP_NONE ;
gconftool-2 -s /apps/gedit-2/preferences/editor/tabs/insert_spaces --type=bool true ;
gconftool-2 -s /apps/gedit-2/preferences/editor/tabs/tabs_size --type=integer 2 ;
gconftool-2 -s /apps/gedit-2/preferences/editor/save/auto_save --type=bool true ;",
		user => $username,
		require => [ Package[gedit], Package[gedit-plugins] ],
	}

}



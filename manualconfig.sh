#!/bin/bash

# Some things that need to be done after user logs into Cinnamon
#disable screensaver and screenlock
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
#setup nautilus
gconftool-2 --type=Boolean --set /apps/nautilus/preferences/always_use_location_entry true
gsettings set org.gnome.nautilus.preferences always-use-location-entry true
#setup gnome terminal to have long scrollback
gconftool-2 -s /apps/gnome-terminal/profiles/Default/scrollback_lines --type=int 8192

# Configure Firefox
echo "^^^ install firefox extensions.  Click 'Install now' for each extension'.  Then close firefox"
firefox /usr/lib/firefox/distribution/extensions/*.xpi

echo "^^^ Close all the tabs.  Edit->Preferences.  Set home page to 'drupalquickstart.org'.  Close firefox"
firefox


echo "

^^^  Done!  Finish by pressing Enter in the build script window (outside the vm)
"

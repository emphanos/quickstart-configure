#!/bin/bash

echo "^^^ install firefox extensions.  Click 'Install now' for each extension'.  Then close firefox"
firefox /usr/lib/firefox/distribution/extensions/*.xpi

echo "^^^ Close all the tabs.  Edit->Preferences.  Set home page to 'drupalquickstart.org'.  Close firefox"
firefox


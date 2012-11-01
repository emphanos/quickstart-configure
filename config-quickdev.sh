#!/bin/bash

QS_WEBROOT=/var/quickstart

# Tools for managing repositories
sudo apt-get -yq install python-software-properties

# Add cinnamon repositor
sudo add-apt-repository -y ppa:gwendal-lebihan-dev/cinnamon-stable

# Update
sudo apt-get -yq update

# Add Ubuntu-Desktop (Unity and etc), Cinnamon, Gnome3, and LightDM/Unity-greeter for graphical login
sudo apt-get -yq install cinnamon ubuntu-desktop gnome-session lightdm unity-greeter

#!/usr/bin/env bash

# This file should be sourced unless when running ubuntu

# If not running fedora, stop
! is_ubuntu && log "[ubuntu-apt] Incompatible source. Stopping." && abort

# Functions -------------------------------------------------------------------

_flatpak_enable() {
	sudo_do "apt-get -y install flatpak"
	sudo_do "apt-get -y install gnome-software-plugin-flatpak"
	flatpak remote-add --if-not-exists flathub \
		https://flathub.org/repo/flathub.flatpakrepo &> /dev/null
}

_install_file() {
	sudo_do "dpkg --install $1"
}

_pm_setup() {
	# NOTE: nothing here yet, havent ubuntu'd in a while
	return 0
}

_pm_update() {
	# TODO: this probably needs some checking with the error code/output?
	sudo_do 'apt-get update'
}

_pm_upgrade() {
	sudo_do 'apt-get -y upgrade'
}

_pm_clean() {
	sudo_do 'apt-get -y autoremove'
}

_pm_is_installed() {
	# TODO: this probably needs some checking with the argument splitting 
	# (or not) also i have forgotten how to debian. leave this here until 
	# i figure it out
	dpkg -s "$1" 2>&1 | grep Status >/dev/null 2>&1
}

_pm_install() {
	sudo_do "apt-get -y install $1"
}

_pm_remove() {
	sudo_do "apt-get -y remove $1"
}

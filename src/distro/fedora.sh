#!/usr/bin/env bash

# This file should be sourced unless when running fedora

# If not running fedora, stop
! is_fedora && log "[fedora] Incompatible source. Stopping." && abort

# Functions -------------------------------------------------------------------

_flatpak_enable() {
	flatpak remote-add --if-not-exists flathub \
		https://flathub.org/repo/flathub.flatpakrepo &> /dev/null
}

_install_file() {
	sudo_do "rpm -i $1"
}

_pm_update() {
	dnf -q check-update 1>> /dev/null
}

_pm_upgrade() {
	sudo_do 'dnf -y upgrade'
}

_pm_clean() {
	sudo_do 'dnf -y autoremove'
}

_pm_is_installed() {
 	rpm -q "$1" &> /dev/null
}

_pm_install() {
	sudo_do "dnf -y install $1"
}

_pm_remove() {
	sudo_do "dnf -y remove $1"
}

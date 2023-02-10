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

_pm_setup() {
	_pm_install \
		"https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
		"https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" \
		&& return 0
}

_pm_update() {
	# DNF exit code will be 100 when there are updates available and a
	# list of the updates will be printed, 0 if not and 1 if an
	# error occurs.
	# Source: dnf man page
	dnf -q check-update 1>> /dev/null
	[ $? -eq 1 ] && return 1
	return 0
}

_pm_upgrade() {
	sudo_do 'dnf -y upgrade'
}

_pm_clean() {
	sudo_do 'dnf -y autoremove'
}

_pm_is_installed() {
	# shellcheck disable=SC2086
	# We *need* items to be split if there are multiple
 	rpm -q $1 &> /dev/null
}

_pm_install() {
	sudo_do "dnf -y install $1"
}

_pm_remove() {
	sudo_do "dnf -y remove $1"
}

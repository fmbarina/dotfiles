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

_ghcli_add() {
	# TODO: man, I wonder if this even works
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		| sudo_do 'dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg' \
	&& sudo_do 'chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg' \
	&& echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
		| sudo_do 'tee /etc/apt/sources.list.d/github-cli.list > /dev/null'
}

_install_file() {
	sudo_do "dpkg --install $*"
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
	# We *need* items to be split if there are multiple
	# shellcheck disable=SC2068
	# FIX: what a crappy check, prob doesn't work with multiple items
	dpkg -s $@ 2>&1 | grep Status >/dev/null 2>&1
}

_pm_install() {
	sudo_do "apt-get -y install $*"
}

_pm_remove() {
	sudo_do "apt-get -y remove $*"
}

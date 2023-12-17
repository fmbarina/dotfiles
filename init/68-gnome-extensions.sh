#!/usr/bin/env bash

! is_gnome && log "[gnome-extension] Not gnome. Skipping." && return

# Var -------------------------------------------------------------------------

gnome_extensions=(
	'https://extensions.gnome.org/extension/615/appindicator-support/'
	'https://extensions.gnome.org/extension/1319/gsconnect/'
	'https://extensions.gnome.org/extension/1460/vitals/'
	'https://extensions.gnome.org/extension/2986/runcat/'
	'https://extensions.gnome.org/extension/3088/extension-list/'
	'https://extensions.gnome.org/extension/3193/blur-my-shell/'
	'https://extensions.gnome.org/extension/4839/clipboard-history/'
	'https://extensions.gnome.org/extension/3843/just-perfection/'
	'https://extensions.gnome.org/extension/5237/rounded-window-corners/'
	'https://extensions.gnome.org/extension/5446/quick-settings-tweaker/'
	'https://extensions.gnome.org/extension/5278/pano/'
	'https://extensions.gnome.org/extension/4481/forge/'
)

# Functions -------------------------------------------------------------------

gnome_id_from_link() {
	echo "$1" | awk -F '/' '{print $5}'
}

gnome_name_from_link() {
	echo "$1" | awk -F '/' '{print $6}'
}

gnome_install_ext() {
	local restart
	! is_wayland && restart='--restart-shell'

	local installer="$DOTFILES/vendor/gnome-shell-extension-installer"
	installer="$installer/gnome-shell-extension-installer"

	bash "$installer" "$1" --yes $restart 1>>"$log_file"
}

# Run -------------------------------------------------------------------------

for ext in "${gnome_extensions[@]}"; do
	gextname=$(gnome_name_from_link "$ext")
	gextid=$(gnome_id_from_link "$ext")

	log "[gnome-extensions] Installing $gextid: $gextname"

	en_arrow "Checking $gextname"
	gnome_install_ext "$gextid"
	er_success "Installed $gextname"
done
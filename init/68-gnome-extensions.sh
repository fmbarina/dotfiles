#!/usr/bin/env bash

! is_gnome && log "[gnome-extension] Not gnome. Skipping." && return

# Var -------------------------------------------------------------------------

gnome_extensions=(
    'https://extensions.gnome.org/extension/615/appindicator-support/'
    'https://extensions.gnome.org/extension/906/sound-output-device-chooser/'
    'https://extensions.gnome.org/extension/1238/time/'
    'https://extensions.gnome.org/extension/1319/gsconnect/'
    'https://extensions.gnome.org/extension/1460/vitals/'
    'https://extensions.gnome.org/extension/2114/order-gnome-shell-extensions/'
    'https://extensions.gnome.org/extension/2986/runcat/'
    'https://extensions.gnome.org/extension/3088/extension-list/'
    'https://extensions.gnome.org/extension/3193/blur-my-shell/'
    'https://extensions.gnome.org/extension/4839/clipboard-history/'
    'https://extensions.gnome.org/extension/4648/desktop-cube/'
    'https://extensions.gnome.org/extension/3843/just-perfection/'
    'https://extensions.gnome.org/extension/5237/rounded-window-corners/'
    'https://extensions.gnome.org/extension/5446/quick-settings-tweaker/'
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
    
    # TODO: if on wayland, maybe don't try restarting, as it will fail
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
    er_success "$gextname installed"
done


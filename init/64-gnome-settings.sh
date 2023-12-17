#!/usr/bin/env bash

! is_gnome && log "[gnome-settings] Not gnome. Skipping." && return

# Made with 'gsettings list-recursively'

gsettings set org.gnome.system.locale region 'pt_BR.UTF-8'

# Clock menu
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date false

# Mouse accel
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'

# Recent/old files
gsettings set org.gnome.desktop.privacy old-files-age 30
gsettings set org.gnome.desktop.privacy recent-files-max-age 1
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files false

# Usability
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 5
gsettings set org.gnome.mutter dynamic-workspaces false

# Screen
gsettings set org.gnome.desktop.screensaver lock-delay 30
gsettings set org.gnome.desktop.session idle-delay 900

# Power
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600

# Nautilus
gsettings set org.gnome.nautilus.icon-view captions "['size', 'none', 'none']"
gsettings set org.gnome.nautilus.list-view use-tree-view true
gsettings set org.gnome.nautilus.preferences show-create-link true
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Hope this helps
gsettings set org.gnome.desktop.privacy report-technical-problems true

# Custom shortcuts
dconf load / <"$DOTFILES/misc/gnome/keybinds.conf"

# Assuming that if the last command was successfull, then all must have been
# TODO: how do I evaluate this more carefully
if [ $? ]; then
	log "[gnome-settings] configured gnome"
	e_success "GNOME configured"
else
	log "[gnome-settings] failed to configure gnome"
	e_error "GNOME configuration failed"
fi

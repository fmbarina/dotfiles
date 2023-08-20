#!/usr/bin/env bash

! is_gnome && log "[gnome-install] Not gnome. Skipping." && return

# Var -------------------------------------------------------------------------

gnome_distro_packages=(
	baobab
	foliate
	easyeffects
	gnome-builder
)

gnome_flatpak_packages=(
    extension-manager
	eyedropper
	identity
	videotrimmer
	rnote
	avvie
	amberol
	lollypop
)

# Run -------------------------------------------------------------------------

for pkg in "${gnome_distro_packages[@]}"; do
	en_arrow "Checking $pkg"

	if pm_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pm_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done

for pkg in "${gnome_flatpak_packages[@]}"; do
	en_arrow "Checking $pkg"

	if flatpak_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation flatpak_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done

#!/usr/bin/env bash

! is_kde && log "[kde-install] Not KDE. Skipping." && return

# Var -------------------------------------------------------------------------

kde_distro_packages=(
	filelight
	elisa
	xournalpp
)

kde_flatpak_packages=(
	
)

# Run -------------------------------------------------------------------------

# Install package manager packages
for pkg in "${kde_distro_packages[@]}"; do
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

for pkg in "${kde_flatpak_packages[@]}"; do
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
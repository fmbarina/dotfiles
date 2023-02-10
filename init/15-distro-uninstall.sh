#!/usr/bin/env bash

! is_known_distro && log "[distro-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

pm_packages=(
    
)

# Run -------------------------------------------------------------------------

# Install package manager packages
for pkg in "${pm_packages[@]}"; do
	en_arrow "Checking $pkg"

	if ! pm_is_installed "$pkg"; then
		er_success "$pkg was not installed"
		continue
	fi

	ern_arrow "Uninstalling $pkg "
	if exec_with_animation pm_remove "$pkg" ; then
		er_success "$pkg uninstalled"
	else
		er_error "$pkg could not be uninstalled"
	fi
done

pm_clean

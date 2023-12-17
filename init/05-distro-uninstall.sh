#!/usr/bin/env bash

! is_known_distro && log "[distro-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

pm_packages=(
	cheese # Maybe useful? But I don't use my webcam all that much
	gnome-tour # I don't need the tour
	libreoffice # I don't want this as a native package
	rhythmbox # I'm sorry, I really prefer other music software.
	yelp # I don't need the help
)

fedora_pm_packages=(
	ffmpeg-free # Nope! Give the me real ffmpeg!
	libswscale-free # See above
	libswresample-free # God, these package conflicts
)

# Run -------------------------------------------------------------------------

for pkg in "${pm_packages[@]}"; do
	en_arrow "Checking $pkg"

	if ! pm_is_installed "$pkg" --any; then
		er_success "(was not installed) $pkg"
		continue
	fi

	ern_arrow "Uninstalling $pkg "
	if exec_with_animation pm_remove "$pkg" ; then
		er_success "Uninstalled $pkg"
	else
		er_error "$pkg could not be uninstalled"
	fi
done

# FIX: Eww, leaky abstraction! Bad!!
if [ "$distro" == "fedora" ]; then
	for pkg in "${fedora_pm_packages[@]}"; do
		en_arrow "Checking $pkg"

		if ! rpm -q "$pkg" &>/dev/null; then
			er_success "(was not installed) $pkg"
			continue
		fi

		ern_arrow "Uninstalling $pkg "
		if exec_with_animation sudo_do "dnf remove -y $pkg"; then
			er_success "Uninstalled $pkg"
		else
			er_error "$pkg could not be uninstalled"
		fi
	done
fi

pm_clean
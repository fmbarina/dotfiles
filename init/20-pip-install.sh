#!/usr/bin/env bash

command -v pip >/dev/null && log "[pip] Pip not installed. Skipping." && return

# Var -------------------------------------------------------------------------

pip_packages=(
	yt-dlp      # Video download tool
	bdfr        # Reddit dowload tool 
	gallery-dl  # Gallery download tool
	#############
	requests
	numpy
	autopep8
	pyyaml
)

# Run -------------------------------------------------------------------------

# TODO: pip upgrade all?

for pkg in "${pip_packages[@]}"; do
	en_arrow "Checking $pkg"

	if pip_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pip_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done

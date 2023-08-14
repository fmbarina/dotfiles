#!/usr/bin/env bash

! command -v pip >/dev/null && log "[pipx] Pip not installed. Skipping." && \
	return

# Var -------------------------------------------------------------------------

pipx_packages=(
	yt-dlp      # Video download tool
	bdfr        # Reddit dowload tool
	gallery-dl  # Gallery download tool
	tldr        # For when man is excessive
	pipenv      # Python virtualenv management
	pulsemixer  # CLI and curses mixer for PulseAudio
	vermin      # Check python project version compatibility
)

# Run -------------------------------------------------------------------------

if command -v pipx &>/dev/null ; then
	e_success 'pipx already installed'
else
	ern_arrow 'Installing pipx '
	if exec_with_animation pipx_base_install ; then
		er_success 'installed pipx'
	else
		er_error 'pipx could not be installed'
	fi
fi

for pkg in "${pipx_packages[@]}"; do
	en_arrow "Checking $pkg"

	if pipx_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pipx_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done


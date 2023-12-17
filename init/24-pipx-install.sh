#!/usr/bin/env bash

! command -v pip >/dev/null && log "[pipx] Pip not installed. Skipping." && \
	return

# Var -------------------------------------------------------------------------

pipx_packages=(
	bdfr        # Reddit dowload tool
	beets       # Swiss knife with the kitchen sink of music tools
	black       # Python formatter
	gallery-dl  # Gallery download tool
	pipenv      # Python virtualenv management
	pulsemixer  # CLI and curses mixer for PulseAudio
#	ranger-fm   # TUI file manager
	tldr        # For when man is excessive
	vermin      # Check python project version compatibility
	yt-dlp      # Video download tool
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
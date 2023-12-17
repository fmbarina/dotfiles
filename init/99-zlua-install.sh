#!/usr/bin/env bash

! command -v luver >/dev/null && \
	log "[zlua] luver not found. Skipping." && return

# Var -------------------------------------------------------------------------

prerequisites=(
	musl-gcc
)

# Run -------------------------------------------------------------------------

for pkg in "${prerequisites[@]}"; do
	en_arrow "Checking prerequisite $pkg"

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

# Actual z.lua is installed by zsh plugin manager
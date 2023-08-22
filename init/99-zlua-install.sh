#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

prerequisites=(
	luajit
	musl-gcc
)

# Run -------------------------------------------------------------------------

for pkg in "${prerequisites[@]}"; do
	en_arrow "Checking prerequisite $pkg"

	if pm_is_installed "$pkg"; then
		er_success "$pkg was already installed"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pm_install "$pkg" ; then
		er_success "$pkg installed"
	else
		er_error "$pkg could not be installed"
	fi
done

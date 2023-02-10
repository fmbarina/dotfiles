#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

pm_packages=(
	npm
)

pip_packages=(
	pynvim # dependency: rnvimr
)

# Run -------------------------------------------------------------------------

en_arrow 'Checking dependencies'

for pkg in "${pm_packages[@]}"; do
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

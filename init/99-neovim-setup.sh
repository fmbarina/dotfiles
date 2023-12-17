#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

pm_packages=(
	# both required for mason packages
	npm
	golang
)

pipx_packages=(
	ranger-fm # dependency of rnvimr
)

luarocks_install=(
	luacheck
	lanes # luacheck optional dep
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

# rnvimr needs pynvim. Since we installed ranger with pipx, it's isolated from
# other pip packages and will need its own copy installation of pynvim
en_arrow "Checking pynvim"
# TODO: pipx_is_injected and pipx_inject?
ern_arrow "Installing pynvim "
if exec_with_animation pipx inject ranger-fm "pynvim" &>/dev/null; then
	er_success "installed pynvim"
else
	er_error "pynvim could not be installed"
fi

for rock in "${luarocks_install[@]}"; do
	en_arrow "installing rock $pkg"
	if exec_with_animation luarocks install "$rock" &>/dev/null; then
		er_success "installed rock $rock"
	else
		er_error "Could not install rock $rock"
	fi
done
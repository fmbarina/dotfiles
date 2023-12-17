#!/usr/bin/env bash

! command -v curl >/dev/null && log "[rust] curl not installed. Skipping." &&
	return

# Var -------------------------------------------------------------------------

cargo_packages=(
	difftastic
	du-dust
	dua-cli
	eza # exa, but hopefully not dead
	flavours
	git-delta
	hyperfine
	onefetch
	oxipng
	stylua
	tokei
)

# Run -------------------------------------------------------------------------

# rustc --version &>/dev/null
if command -v rustup &>/dev/null ; then
	e_success 'rust already installed'
else
	ern_arrow 'Installing rust toolchain'
	if exec_with_animation rust_base_install ; then
		er_success 'installed rust toolchain'
	else
		er_error 'rust toolchain could not be installed'
	fi
fi

for pkg in "${cargo_packages[@]}"; do
	en_arrow "Checking $pkg"

	if rust_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation rust_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done
#!/usr/bin/env bash

# FIX: wait for: https://github.com/cli/cli/issues/2680
if true; then return; fi # just so shellcheck doesn't complain

! command -v gh >/dev/null && log "[wezterm] gh not found. Skipping." && return

# NOTE: nautilus extension requires nautilus-python. Maybe auto install that?

# Function --------------------------------------------------------------------

install_wezterm() {
	local pat
	if is_fedora; then
		pat='*fedora38*.rpm'
	elif is_ubuntu; then
		pat='*Ubuntu22*.deb'
	fi
	gh release download 'nightly' >/dev/null \
		--repo 'wez/wezterm' \
		--dir "$DOTFILES/tmp/wez" \
		--pattern "$pat"
	install_file "$DOTFILES/tmp/wez/*"
}

# Run -------------------------------------------------------------------------

en_arrow 'Checking wezterm... '

if command -v wezterm >/dev/null; then
	er_success 'Wezterm was already installed'
	return 0
fi

# I just want to download public releases...
GH_TOKEN=#Or put token here
export GH_TOKEN
mkdir -p "$DOTFILES/tmp/wez"

ern_arrow 'Installing wezterm... '
if exec_with_animation install_wezterm; then
	er_success "Wezterm installed"
else
	er_error "Wezterm could not be installed"
fi

delete "$DOTFILES/tmp/wez"
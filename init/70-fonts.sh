#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

font_src_dir="$DOTFILES/misc/fonts"
font_dst_dir="$HOME/.local/share/fonts"

# Run -------------------------------------------------------------------------

mkdir -p "$font_dst_dir"
mkdir -p "$DOTFILES/tmp/extract"

for obj in "$font_src_dir"/* ; do
	font=$(remove_extension "$(basename "$obj")")

	if [ -e "$font_dst_dir/$font" ]; then
		e_success "$font was already installed"
		continue
	fi

	if [[ "$obj" == *'.tar' ]]; then
		xtr_tar "$obj" "$DOTFILES/tmp/extract"
		obj="$DOTFILES/tmp/extract/$font"
	fi

	log "[fonts] Installing $font"
	copy "$obj" "$font_dst_dir/$font"

	if [ -e "$font_dst_dir/$font" ]; then
		log "[fonts] $font installed"
		e_success "$font installed"
		font_installed=y
	else
		log "[fonts] Failed to install $font"
		e_error "$font could not be installed"
	fi
done

if [ -n "$font_installed" ]; then
	en_arrow 'Refreshing font cache'
	if exec_with_animation sudo_do 'fc-cache -f'; then
		er_success 'Font cache refreshed'
	else
		er_error 'Could not refresh font cache'
	fi
fi

delete "$DOTFILES/tmp/extract"

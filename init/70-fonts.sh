#!/usr/bin/env bash

if ! [ -d "$font_src_dir" ] || ! [ "$(ls "$font_src_dir")" ]; then
	log "[fonts] No fonts to install. Skipping." && return
fi

# Var -------------------------------------------------------------------------

font_src_dir="$DOTFILES/misc/fonts"
font_dst_dir="$HOME/.local/share/fonts"

# Run -------------------------------------------------------------------------

e_header "Installing fonts"

mkdir -p "$font_dst_dir"
mkdir -p "$font_src_dir/extract"

for obj in "$font_src_dir"/*; do
	font="$(basename "$obj")"

	if [[ "$font" == *."tar" ]]; then
		font="$(remove_extension "$font")"
	fi

	if ! [ -e "$font_dst_dir/$font" ]; then
		if [[ "$font" == *."tar" ]]; then
			xtr_tar "$obj" "$font_src_dir/extract"
			obj="$font_src_dir/extract/$font"
		fi

		log "[fonts] Installing $font"
		copy "$obj" "$font_dst_dir/$font"
	fi

	if [ -e "$font_dst_dir/$font" ]; then
		log "[fonts] $font installed"
		e_success "$font installed"
	else
		log "[fonts] Failed to install $font"
		e_error "$font could not be installed"
	fi
done

en_arrow 'Refreshing font cache'
if exec_with_animation sudo_do 'sudo fc-cache -f' ; then
	er_success 'Font cache refreshed'
else
	er_error 'Could not refresh font cache'
fi

delete "$font_src_dir/extract"
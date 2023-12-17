#!/usr/bin/env bash

# Run -------------------------------------------------------------------------

for dir in "$HOME/.mozilla/firefox"/*; do
	# We *should* try to put the user.js in our profile
	# I don't want to bother trying to find my profile
	# Just put it in every directory there, screw it

	if ! [ -d "$dir" ]; then
		continue
	fi

	en_arrow "Checking $(basename "$dir")"

	if [ -e "$dir/user.js" ]; then
		er_success "user.js was already copied to $(basename "$dir")"
		continue
	fi

	if copy "$DOTFILES/misc/firefox/user.js" "$dir"; then
		er_success "Copied user.js to $(basename "$dir")"
	else
		er_error "Could not copy user.js to $(basename "$dir")"
	fi
done

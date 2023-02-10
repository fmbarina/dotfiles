#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

repo_dir="$HOME/Documents/git"

[ -n "$ZDOTDIR" ] || ZDOTDIR="$HOME/.zsh.d"

# Run -------------------------------------------------------------------------

mkdir -p "$repo_dir"

### Prezto ###

en_arrow 'Checking Prezto'

if [ -d "$ZDOTDIR/.zprezto" ] ; then
	er_success "Already cloned Prezto"
else
	ern_arrow "Cloning Prezto "
	if git_clone 'https://github.com/sorin-ionescu/prezto.git' \
        "$ZDOTDIR/.zprezto" ;
    then
		er_success 'Sucessfully cloned Prezto'
	else
		er_error 'Could not clone Prezto'
	fi
fi


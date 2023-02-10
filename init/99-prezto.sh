#!/usr/bin/env bash

# Run -------------------------------------------------------------------------

### Prezto ###

en_arrow 'Checking Prezto'

if [ -d "$ZDOTDIR/.zprezto" ] ; then
	er_success "Already cloned Prezto"
else
	ern_arrow "Cloning Prezto "
	mkdir -p "$ZDOTDIR"
	if git_clone 'https://github.com/sorin-ionescu/prezto.git' \
		"$ZDOTDIR/.zprezto" '--recursive' ;
	then
		er_success 'Sucessfully cloned Prezto'
	else
		er_error 'Could not clone Prezto'
	fi
fi


#!/usr/bin/env bash

# Function --------------------------------------------------------------------

install_gh_cli() {
	ghcli_add && pm_update && pm_install 'github-cli'
}

# Run -------------------------------------------------------------------------

en_arrow 'Checking github-cli... '

if command -v gh >/dev/null; then
	er_success 'Github-cli was already installed'
	return 0
fi

ern_arrow 'Installing github cli... '
if exec_with_animation install_gh_cli; then
	er_success 'Installed github-cli'
else
	er_error 'Could not install github-cli'
fi

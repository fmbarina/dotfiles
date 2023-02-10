#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

prerequisites=(
    dkms
    curl
    cabextract
)

repo_dir="$DEV_HOME"

# Functions -------------------------------------------------------------------

xone_install() {
    git_clone 'https://github.com/medusalix/xone.git' "$repo_dir/xone" && \
        sudo_do "$repo_dir/xone/install.sh --release" && \
        sudo_do "$repo_dir/xone/xone-get-firmware.sh --skip-disclaimer"
}

# Run -------------------------------------------------------------------------

mkdir -p "$repo_dir"

### Prezto ###

en_arrow 'Checking Xone'

if [ -d "$repo_dir/xone" ] ; then
	er_success "Already installed xone"; return
fi
er_arrow "Proceeding to install xone"

for pkg in "${prerequisites[@]}"; do
	en_arrow "Checking prerequisite $pkg"

	if pm_is_installed "$pkg"; then
		er_success "$pkg was already installed"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pm_install "$pkg" ; then
		er_success "$pkg installed"
	else
		er_error "$pkg could not be installed"
	fi
done

ern_arrow "Installing xone "
if exec_with_animation xone_install ; then
    er_success 'Sucessfully installed xone'
else
    er_error 'Could not install xone'
fi

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
	sudo_do "./install.sh --release" &>/dev/null && \
	sudo_do "xone-get-firmware.sh --skip-disclaimer" &>/dev/null
}

# Run -------------------------------------------------------------------------

if [ -d "$repo_dir/xone" ] ; then
	e_success "Already installed xone"; return 0
fi

mkdir -p "$repo_dir"

for pkg in "${prerequisites[@]}"; do
	en_arrow "Checking prerequisite $pkg"

	if pm_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pm_install "$pkg"; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"; return 1
	fi
done

ern_arrow "Downloading xone "
if exec_with_animation
	git_clone 'https://github.com/medusalix/xone.git' "$repo_dir/xone"
then
	er_success 'Sucessfully downloaded xone'
else
	er_error 'Could not download xone'; return 1
fi

ern_arrow "Installing xone "
if exec_with_animation cd_and_back "$repo_dir/xone" xone_install; then
	er_success 'Sucessfully installed xone'
else
	er_error 'Could not install xone'; return 1
fi

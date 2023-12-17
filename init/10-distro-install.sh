#!/usr/bin/env bash

! is_known_distro && log "[distro-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

pm_packages=(
	7zip
	bash
	bat
	bfs
	bind-utils
	btop
	clang-format
	cloc
	cmake # Many toolchains depend on cmake. You WILL use it, even if indirectly
	cowsay
	curl
	fd-find
	ffmpeg
	ffmpegthumbnailer
	fzf
	ghostscript
	imagemagick
	inotify-tools
	jq
	mpd
	ncdu
	ncmpcpp
	neovim
	netcat
	npm # Just... just give up, you can't run from npm forever
	nvtop
	openssl
	pandoc
	perl
	pkg-config
	python3
	python3-pip
	radeontop
	ripgrep
	shellcheck
	tmux
	trash-cli
	unzip
	util-linux
	valgrind
	webp-pixbuf-loader
	wget
	x264
	zathura
	zathura-extra
	zsh
	######
	vlc
	mpv
	inkscape
	gimp
	godot
	firefox
	qbittorrent
	pdfarranger
)

# Run -------------------------------------------------------------------------

# Run setup
action_set_echo_loading "Preparing"
action_set_echo_success "Setup finished successfully"
action_set_echo_error "Setup did not finish successfully"
action_with_echos pm_setup

# Update the package list
action_set_echo_loading "Updating information"
action_set_echo_success "Updated package information"
action_set_echo_error "Could not update information"
action_with_echos pm_update

# Upgrade everything with package manager
if [ -n "$up_pkgs" ] ; then
	action_set_echo_loading "Upgrading packages"
	action_set_echo_success "Packages upgraded"
	action_set_echo_error "Could not upgrade packages"
	action_with_echos pm_upgrade
fi

for pkg in "${pm_packages[@]}"; do
	en_arrow "Checking $pkg"

	if pm_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation pm_install "$pkg" ; then
		er_success "Installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done

# Cleanup
pm_clean
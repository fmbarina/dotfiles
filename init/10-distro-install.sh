#!/usr/bin/env bash

! is_known_distro && log "[distro-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

pm_packages=(
	7zip
	bash
	btop
	nvtop
	clang-format
	cowsay
	exa
	fd-find
	ripgrep
	ffmpeg
	ffmpegthumbnailer
	fzf
	imagemagick
	jq
	mpd
	ncdu
	ncmpcpp
	neovim
	netcat
	openssl
	perl
	pkg-config
	python3
	python3-pip
	radeontop
	shellcheck
	steam-devices
	tmux
	trash-cli
	unzip
	util-linux
	valgrind
	webp-pixbuf-loader
	curl
	wget
	x264
	zsh
	######
	libreoffice
	blender
	godot
	vlc
	mpv
	inkscape
	kdenlive
	krita
	gimp
	thunderbird
	firefox
	qbittorrent
	easytag
	pdfarranger
)

# Run -------------------------------------------------------------------------

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

# Cleanup
pm_clean

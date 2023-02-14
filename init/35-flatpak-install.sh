#!/usr/bin/env bash

! is_known_distro && log "[flatpak-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

flatpak_packages=(
	libreoffice
	blender
	godot
	kdenlive
	krita
	flatseal
	obsidian
	czkawka
	handbrake
	calibre
	logisim-evolution
	bottles
	obs-studio
	discord
	prism-launcher
	ryujinx
	yuzu
	steam
)

# Run -------------------------------------------------------------------------

for pkg in "${flatpak_packages[@]}"; do
	en_arrow "Checking $pkg"

	if flatpak_is_installed "$pkg"; then
		er_success "(already installed) $pkg"
		continue
	fi

	ern_arrow "Installing $pkg "
	if exec_with_animation flatpak_install "$pkg" ; then
		er_success "installed $pkg"
	else
		er_error "$pkg could not be installed"
	fi
done

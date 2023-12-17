#!/usr/bin/env bash

! is_known_distro && log "[flatpak-install] Unkown distro. Skipping." && return

# Var -------------------------------------------------------------------------

flatpak_packages=(
	blender
	bottles
	calibre
	czkawka
	discord
	flatseal
	gnome-builder
	handbrake
	helvum
	kdenlive
	krita
	libreoffice
	logisim-evolution
	obs-studio
	obsidian
	prism-launcher
	ryujinx
	steam
	thunderbird
	upscaler
	yuzu
)

# Run -------------------------------------------------------------------------

# TODO: Add flatpak_is_enabled() to check and use appropriate logic here
flatpak_enable

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

# For development
if ! flatpak info 'org.flatpak.Builder' &>/dev/null ; then
	en_arrow 'Installing org.flatpak.Builder'
	if exec_with_animation flatpak install -y org.flatpak.Builder >/dev/null
	then
		er_success 'installed org.flatpak.Builder'
	else
		er_error 'org.flatpak.Builder could not be installed'
	fi
else
	e_success '(already installed) org.flatpak.Builder'
fi
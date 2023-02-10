#!/usr/bin/env bash

# Functions -------------------------------------------------------------------

### File interaction ###

delete() {
	! [ -e "$1" ] && log "[delete] File/dir does not exist: $1" && return 1
	log "[delete] Deleting $1"
	if command -v trash-put >/dev/null 2>&1 ; then 
		trash-put "$1" 
	else
		rm -rf "$1"
	fi
}

backup() {
	# FIXME: causes problem when backing up same-name items
	# Ex: .config/<softwareA>/config | .config/<softwareB>/config
	
	if ! [ -e "$1" ]; then
		log "[backup] Can not backup nonexistent target: $1"
		abort "Could not backup nonexistent target: $1"
	fi

	if [ -e "$BKP_DIR/$(basename "$1")" ]; then
		log "[backup] $1 already exists, stopped. Please remove or rename it."
		abort "$1 was already backed up, stopped. Please remove or rename it."
	fi

	mkdir -p "$BKP_DIR"

	# FIXME: shitballs fix this fuck
	log "[backup] Backing up: $1"
	mkdir -p "$(dirname "$(readlink -f "$1")")"
	
	cp -r  "$1" "$BKP_DIR$(dirname "$(readlink -f "$1")")" \
		&& [ -z "$dotbkp" ] && dotbkp=yes
}

rsymlink() {
	# Read link with stopper if function was not used with a link
	! [ -L "$1" ] && log "[rsymlink] Not a link: $1. Stopping." && abort
	readlink -f "$1"
}

_symlink() {
	local link
	local tgt
	
	link="$1"
	tgt="$2"

	if [ -L "$link" ] && [ "$(rsymlink "$link")" == "$tgt" ]; then
		log "[link] Already linked: $link" && return 0
	fi

	if [ -e "$link" ]; then
		log "[link] File already exists: $link"
		backup "$link" && delete "$link"
	fi

	# If at this point it exists, there has been a mistake
	[ -e "$link" ] && return 1

	log "[link] Creating link: $link To: $tgt"

	# this command confuses me greatly!
	# shellcheck disable=SC2154
	ln -sv 1>>"$log_file" 2>&1 "$tgt" "$link" && return 0
	return 1
}

symlink() {
	# We don' want to symlink entire directories, because we might want to do
	# other things with them, that symlinking would create an issue with. Only
	# actual files will be symlinked, directories will be created if needed.
	local link
	local tgt
	
	link="$1"
	tgt="$2"

	# Early return for the actual link creation
	if ! [ -d "$tgt" ]; then
		_symlink "$link" "$tgt"; return $?
	fi
	
	# Else go down directories recursively
	log "[link] $tgt is a directory, descending."

	mkdir -p "$link"
	for new_tgt in "$tgt"/* ; do
		symlink "$(sed 's/\/$//' <<<"$link")/$(basename "$new_tgt")" "$new_tgt"
	done
}

copy() {
	log "[copy] Copying recursively: $1 To: $2"
	cp >> "$log_file" --verbose --recursive --update -p "$1" "$2"
}

check_has_service() {
	systemctl list-units --full -all | \
		grep --fixed-strings --quiet "$1.service"
}

xtr_tar() {
	local compacted
	local dest
	compacted="$1"
	dest="$2"

	log "[xtr_tar] Extracting $compacted to $dest"
	tar --directory "$dest" \
		--extract --overwrite --file "$compacted" 1>"$LOG_OTH_FILE"
}

run_script() {
	log "[run] Running: $1"
	# shellcheck source=/dev/null
	source "$1"
}

clean_initfile_name() {
	# From /path/to/NNN-initfile-name.sh
	# Returns initfile-name
	basename "$1" | sed 's/.sh//' | sed 's/^[0-9]*\-//'
}

remove_extension() {
	local file_name
	file_name="$(basename "$1")"
	echo "${file_name%.*}"
}

### Web ###

download() {
	log "[download] Downloading $1 to $2"
	wget -q -P "$2" "$1"
}

### Python ###

pip_is_installed() {
	log "[pip] Checking if pip package installed: $1"

	if pip show "$1" &> /dev/null ; then
		log "[pip] $1 installed" ; return 0
	else
		log "[pip] Could not find $1" ; return 1
	fi
}

pip_install() {
	log "[pip] Installing $1"

	if python -m pip install "$1" >/dev/null ; then
		log "[pip] Installed $1" ; return 0
	else
		log "[pip] Failed to install $1" ; return 1
	fi
}

pipx_base_install() {
	log "[pipx] installing base pipx"
	if python3 -m pip install --user pipx >/dev/null ; then
		log "[pipx] pipx installed" ; return 0
	else
		log "[pipx] Could not install pipx" ; return 1
	fi
	# NOTE: This just adds some lines in your shell rc? I can do that myself.
	# python3 -m pipx ensurepath
}

pipx_is_installed() {
	log "[pipx] Checking if pipx package installed: $1"

	if pipx list --short | grep "^$1 " &>/dev/null ; then
		log "[pipx] $1 installed" ; return 0
	else
		log "[pipx] Could not find $1" ; return 1
	fi
}

pipx_install() {
	log "[pipx] Installing $1"

	if pipx install &>/dev/null "$1" ; then
		log "[pipx] Installed $1" ; return 0
	else
		log "[pipx] Failed to install $1" ; return 1
	fi
}

### git ###

git_clone() {
	local repo dest args
	repo="$1"
	dest="$2"
	args="$3"

	if [ -e "$dest" ]; then
		log "[git_clone] $dest already exists."
		return
	fi

	log "[git_clone] Cloning $repo to $dest with $args"
	eval "git clone --quiet $args $repo $dest"
}

git_dirname_from_url() {
	echo "$1" | awk -F '/' '{print $5}' | sed 's/.git//'
}

### Desktop enviroment ###

# Thanks to
# https://unix.stackexchange.com/questions/116539/
get_de() {
	# Get desktop environment
	local denv

	if [ "$XDG_CURRENT_DESKTOP" = "" ]; then
		denv=$(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/')
	else
		denv=$XDG_CURRENT_DESKTOP
	fi
	
	denv=${denv,,}  # convert to lower case
	echo "$denv"
}

is_gnome() {
	[[ "$(get_de)" = *"gnome"* ]]
}

is_kde() {
	[[ "$(get_de)" = *"kde"* ]]
}

is_wayland() {
	[ "$XDG_SESSION_TYPE" == "wayland" ]
}

### Flatpak ###

flatpak_enable() {
	# shellcheck disable=SC2154
	log "[flatpak] Enabling flatpak in [$distro]"
	_flatpak_enable
}

flatpak_is_installed() {
	local package origin

	[ -z "$2" ] && origin="$2"
	[ -z "$origin" ] && origin=flathub
	package=$(bash "$DOTFILES/src/pkg/get_pkg.sh" "$1" "$origin")

	log "[flatpak] Checking if flatpak package installed: $package"
	# FIXME: this devnull doesn't work??
	if flatpak info "$package" &>/dev/null ; then
		log "[flatpak] $package installed" ; return 0
	else
		log "[flatpak] Could not find $package" ; return 1
	fi
}

flatpak_install() {
	local package origin

	[ -z "$2" ] && origin="$2"
	[ -z "$origin" ] && origin=flathub
	package=$(bash "$DOTFILES/src/pkg/get_pkg.sh" "$1" "$origin")

	log "[flatpak] Installing $package"
	if flatpak install --assumeyes --noninteractive "$origin" "$package" \
		1>>"$log_file"
	then
		log "[flatpak] Installed $package" ; return 0
	else
		log "[flatpak] Failed to install $package"; return 1
	fi
}

### rust ###

rust_base_install() {
	log "[rustup] Oxidizing system (insert crab here)"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
		sh -s &>>"$log_file" -- -y --quiet --no-modify-path
}

rust_is_installed() {
	log "[cargo] Checking if cargo package installed: $1"

	if cargo install --list | grep "^$1 " &>/dev/null ; then
		log "[cargo] $1 installed" ; return 0
	else
		log "[cargo] Could not find $1" ; return 1
	fi
}

rust_install() {
	log "[cargo] Installing $1"

	if cargo install "$1" &>/dev/null ; then
		log "[cargo] Installed $1" ; return 0
	else
		log "[cargo] Failed to install $1" ; return 1
	fi
}

### Distro-specific functions ###

# These themselves do little but log, the actual implementation per distro
# is provided by the distro-specific files src/(distro-name).sh.

install_file() {
	log "[$distro] Installing by file: $1"
	if _install_file "$1"; then
		log "[$distro] Installed $1" ; return 0
	else
		log "[$distro] Could not install $1" ; return 1
	fi
}

pm_setup() {
	log "[$distro] Running setup function"
	if _pm_setup; then
		log "[$distro] Setup success" ; return 0
	else
		log "[$distro] Setup failure" ; return 1
	fi
}

pm_update() {
	log "[$distro] Updating packages information"
	if _pm_update ; then
		log "[$distro] Updated packages information" ; return 0
	else
		log "[$distro] Could not update packages information" ; return 1
	fi
}

pm_upgrade() {
	log "[$distro] Upgrading packages"
	if _pm_upgrade ; then
		log "[$distro] Upgraded packages" ; return 0
	else
		log "[$distro] Could not upgrade packages" ; return 1
	fi
}

pm_clean() {
	log "[$distro] Cleaning up system packages"
	if _pm_clean ; then
		log "[$distro] Cleaned up packages" ; return 0
	else
		log "[$distro] Could not clean up packages" ; return 1	
	fi
}

pm_is_installed() {
	local package
	package=$(bash "$DOTFILES/src/pkg/get_pkg.sh" "$1" "$distro")

	log "[$distro] Checking if package installed: $package"
	if _pm_is_installed "$package"; then
		log "[$distro] Found package: $package" ; return 0
	else
		log "[$distro] Could not find package: $package" ; return 1
	fi
}

pm_install() {
	local package
	package=$(bash "$DOTFILES/src/pkg/get_pkg.sh" "$1" "$distro")
	
	log "[$distro] Installing $package"
	if _pm_install "$package"; then
		log "[$distro] Sucessfully installed $package" ; return 0
	else
		log "[$distro] Could not install $package" ; return 1
	fi
}

pm_remove() {
	local package
	package=$(bash "$DOTFILES/src/pkg/get_pkg.sh" "$1" "$distro")
	
	log "[$distro] Uninstalling $package"
	if _pm_remove "$package"; then
		log "[$distro] Sucessfully uninstalled $package" ; return 0
	else
		log "[$distro] Could not uninstall $package" ; return 1
	fi
}


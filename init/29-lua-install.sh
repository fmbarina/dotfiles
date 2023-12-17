#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

pm_prerequisites=(
	readline-dev
)

luver_url='https://github.com/MunifTanjim/luver.git'
if [[ -z $LUVER_DIR ]]; then
	export LUVER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/luver"
fi

# Function --------------------------------------------------------------------

install_luas() {
	luver install lua 5.3.6 >/dev/null || return 1
	luver alias 5.3.6 default >/dev/null || return 1
	luver use default || return 1
	if ! command -v luarocks >/dev/null; then
		luver install luarocks 3.9.2 >/dev/null
	fi
}

# Run -------------------------------------------------------------------------

if [[ -d $LUVER_DIR ]]; then
	e_success 'luver was already installed'
fi

for pkg in "${pm_prerequisites[@]}"; do
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

mkdir -p "$LUVER_DIR"

en_arrow 'Installing luver... '
if exec_with_animation git_clone "$luver_url" "$LUVER_DIR/self"; then
	er_success "Installed luver"
else
	er_error "luver could not be installed"
	return 1
fi

# shellcheck source=/dev/null
source "$LUVER_DIR/self/luver.bash" >/dev/null

# Bash completions
if ! [ -e "${XDG_DATA_HOME:-"$HOME/.local/share"}/bash-completion/completions/luver" ]; then
	mkdir -p "${XDG_DATA_HOME:-"$HOME/.local/share"}/bash-completion/completions" >/dev/null
	luver completion bash >| \
		"${XDG_DATA_HOME:-"$HOME/.local/share"}/bash-completion/completions/luver"
fi

# Zsh completions
if ! [ -e "${XDG_DATA_HOME:-"$HOME/.local/share"}/zsh/functions/_luver" ]; then
	mkdir -p "${XDG_DATA_HOME:-"$HOME/.local/share"}/zsh/functions" >/dev/null
	luver completion zsh >| \
		"${XDG_DATA_HOME:-"$HOME/.local/share"}/zsh/functions/_luver"
fi

en_arrow 'Installing lua/luarocks... '
if exec_with_animation install_luas; then
	er_success 'installed lua/luarocks'
else
	er_error 'Could not install lua/luarocks versions'
fi
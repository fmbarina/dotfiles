# shellcheck disable=2155,1091

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export VISUAL="$(command -v nvim || command -v vim || command -v vi)"
export EDITOR="$(command -v vi) -e"
export PAGER="$(command -v less || command -v more)"

export DOTFILES="$HOME/.dotfiles"
export DEV_HOME="$(xdg-user-dir DOCUMENTS)/git"

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.dotfiles/bin"

# shell
export MY_BASH_DIR="$XDG_CONFIG_HOME/bash"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$PATH:$CARGO_HOME/bin"

# Android dev
[ -f "$HOME/.common/extra_android_path.sh" ] && \
	source "$HOME/.common/extra_android_path.sh"

# Misc
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export FZF_DEFAULT_COMMAND='fd --type f --follow --hidden \
  --exclude .git \
  --exclude node_modules \
  --exclude Trash'

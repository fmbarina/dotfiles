# shellcheck disable=SC2034,SC1091

# Multiple sourcing guard -- wasn't happening last I checked,
# but we might as well remove the risk of it ever being an issue.
[ -n "$COMMON_ENV_SOURCED" ] && return
COMMON_ENV_SOURCED='Y'

# From here on, everything that is set is to be exported
set -a

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"

VISUAL="$(command -v nvim || command -v vim || command -v vi)"
EDITOR="$(command -v vi) -e"
PAGER="$(command -v less || command -v more)"

DOTFILES="$HOME/.dotfiles"
DEV_HOME="$HOME/Dev"

# shell
BASH_DIR="$XDG_CONFIG_HOME/bash"
ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# languages and other programming stuff
_JAVA_OPTIONS="-Djava.util.prefs.userRoot='$XDG_CONFIG_HOME/java'"
GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
RUSTUP_HOME="$XDG_DATA_HOME/rustup"
CARGO_HOME="$XDG_DATA_HOME/cargo"

if [[ -s $HOME/.common/android_env.sh ]]; then
	source "$HOME/.common/android_env.sh"
fi

# software specific
_ZL_DATA="${ZDOTDIR:-$HOME}/.zlua"
LESSHISTFILE="$XDG_STATE_HOME/less/history"
XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
W3M_DIR="$XDG_DATA_HOME/w3m"
FZF_DEFAULT_COMMAND='fd --hidden \
  --exclude .git \
  --exclude node_modules \
  --exclude Trash'

# the big lad

# If no system provided PATH for some(?) reason get basic PATH
if [[ -z $PATH ]]; then
	PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
fi

# Get my PATH stuff
if [[ $PATH != *"$HOME"* ]]; then
	PATH="$PATH:$HOME/.local/bin:$HOME/.dotfiles/bin"
	
	if [[ -n $CARGO_HOME ]]; then
		PATH="$PATH:$CARGO_HOME/bin"
	fi

	if [[ -s $HOME/.common/extra_android_path.sh ]]; then
		source "$HOME/.common/extra_android_path.sh"
	fi
fi

# Stop exporting stuff
set +a

# shellcheck disable=SC2034,SC1091

# Multiple sourcing guard -- wasn't happening last I checked,
# but we might as well remove the risk of it ever being an issue.
[ -n "$COMMON_ENV_SOURCED" ] && return
COMMON_ENV_SOURCED='y'

# From here on, everything that is set is to be exported
set -a

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"

VISUAL="$(command -v nvim || command -v vim || command -v vi)"
EDITOR="$(command -v vi) -e"
PAGER="$(command -v less || command -v more)"

DOTFILES="$HOME/.dot"
DEV_HOME="$HOME/Code"

# shell
BASH_DIR="$XDG_CONFIG_HOME/bash"
ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# languages and other programming stuff
CARGO_HOME="$XDG_DATA_HOME/cargo"
GOPATH="$XDG_DATA_HOME/go"
GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
LUVER_DIR="$XDG_DATA_HOME/luver"
NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
PUB_CACHE="$XDG_CACHE_HOME/pub" # NOTE: fix is apparently a wip, check back soon
PYENV_ROOT="$XDG_DATA_HOME/pyenv"
RUSTUP_HOME="$XDG_DATA_HOME/rustup"
_JAVA_OPTIONS="-Djava.util.prefs.userRoot='$XDG_CONFIG_HOME/java'"

if [[ -s $HOME/.common/android_env.sh ]]; then
	source "$HOME/.common/android_env.sh"
fi

# software specific
RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
GNUPGHOME="$XDG_DATA_HOME/gnupg"
LESSHISTFILE="$XDG_STATE_HOME/less/history"
XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
W3M_DIR="$XDG_DATA_HOME/w3m"
FZF_DEFAULT_COMMAND='fd --hidden \
  --exclude .git \
  --exclude node_modules \
  --exclude Trash'

# zlua - magical cd on steroids
_ZL_CMD='z'
_ZL_DATA="${ZDOTDIR:-$HOME}/.zlua"
_ZL_ADD_ONCE=1
_ZL_MAXAGE=10000
_ZL_MATCH_MODE=1

# multiples nvim profiles helper script
if [[ -s $HOME/.common/nvims.sh ]]; then
	source "$HOME/.common/nvims.sh"
fi

# the big lad

# If no system provided PATH for some(?) reason get basic PATH
if [[ -z $PATH ]]; then
	PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin
fi

# Get my PATH stuff
if [[ $PATH != *"$HOME"* ]]; then
	PATH="$PATH:$HOME/.local/bin:$HOME/.dot/bin"

	if [[ -n $CARGO_HOME ]]; then
		PATH="$PATH:$CARGO_HOME/bin"
	fi

	if [[ -n $PYENV_ROOT ]]; then
		PATH="$PATH:$PYENV_ROOT/bin"
	fi
fi

# Messes with PATH, so do it at the end
if [[ -s $HOME/.common/android.sh ]]; then
	source "$HOME/.common/android.sh"
fi

# Stop exporting stuff
set +a
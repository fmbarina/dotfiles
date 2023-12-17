# Reference:
# https://zsh.sourceforge.io/Doc/Release/Files.html
# .zshenv → [.zprofile @login] → [.zshrc @interactive] → [.zlogin @login]

# zsh does a lot of the work for us. Actually, the real order is more like:
# /etc/X → ZDOTDIR/X, and so on, except logout. ZDOTDIR/.zlogout → /etc/zlogout

# NOTE: maybe try out zinit? https://github.com/zdharma-continuum/zinit

fpath=("$XDG_DATA_HOME/zsh/functions" $fpath)

# Get module loader
ZIM_HOME="${ZDOTDIR:-$HOME}/.zim"
if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
	echo 'Getting Zim, hang tight...'
	curl -fsSL --create-dirs -o "$ZIM_HOME/zimfw.zsh" \
		https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
if [[ ! $ZIM_HOME/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source $ZIM_HOME/zimfw.zsh init -q
fi

# p10k instant prompt - things that require input must go above!
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set module configs, then call loader
[[ -s $ZDOTDIR/.zmodrc ]] && source "$ZDOTDIR/.zmodrc"
[[ -s $ZIM_HOME/init.zsh ]] && source "$ZIM_HOME/init.zsh"

# Source common interactive stuff (shell agnostic)
if [[ -s $HOME/.common/shell.sh ]]; then
	source "$HOME/.common/shell.sh"
fi

# Zsh specific stuff
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
source "${LUVER_DIR}/self/luver.plugin.zsh"
ZSH_EVALCACHE_DIR="${ZDOTDIR:-$HOME}/.zsh_evalcache"
_evalcache _PIPENV_COMPLETE=zsh_source pipenv
_evalcache pyenv init -

# To customize prompt, run 'p10k configure' or edit $ZDOTDIR/.p10k.zsh
source "$ZDOTDIR/.p10k.zsh"

# Ew, ew, conda, messy, slow, fat, fuck
# __conda_setup="$('/home/fmbarina/Desktop/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# eval "$__conda_setup"
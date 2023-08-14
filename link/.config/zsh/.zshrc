# p10k instant prompt - things that require input must go above!
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto
if [[ -s "${ZDOTDIR}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR}/.zprezto/init.zsh"
fi

# Source global definitions
if [[ -s /etc/zshrc ]]; then
	source /etc/zshrc
fi

# User specific environment
if [ -f "$HOME/.common/env.sh" ]; then
	source "$HOME/.common/env.sh"
fi

# Source shell aliases and functions
if [ -f "$HOME/.common/shell.sh" ]; then
  source "$HOME/.common/shell.sh"
fi

eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"

# To customize prompt, run `p10k configure` or edit ~/.zsh.d/.p10k.zsh.
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"


# p10k instant prompt - things that require input must go above!
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s /etc/zshrc ]]; then
	source /etc/zshrc
fi

# User specific environment
if [ -f "$HOME/.common_env" ]; then
	source "$HOME/.common_env"
fi

# Source shell aliases and functions
if [ -f "$HOME/.common_shell" ]; then
  source "$HOME/.common_shell"
fi

# To customize prompt, run `p10k configure` or edit ~/.zsh.d/.p10k.zsh.
[[ ! -f ~/.zsh.d/.p10k.zsh ]] || source ~/.zsh.d/.p10k.zsh

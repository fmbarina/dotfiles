# Source common environment (shell agnostic)
if [[ -s $HOME/.common/env.sh ]]; then
	source "$HOME/.common/env.sh"
fi

# zsh works a little differently from bash. We don't have to manually source
# our zshrc in zprofile or zlogin to make sure it's sourced in login shells;
# zsh will automatically do it, if it finds one in ZDOTDIR (which we defined
# earlier, probably in our zshenv).

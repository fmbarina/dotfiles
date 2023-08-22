# Source common environment (shell agnostic)
if [[ -s $HOME/.common/env.sh ]]; then
	source "$HOME/.common/env.sh"
fi

# An interactive bash login shell may not automatically source bashrc
# which is why, conventionally, we do something like this at the end.
if [[ -s $HOME/.bashrc ]]; then
	source "$HOME/.bashrc"
fi

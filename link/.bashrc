# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# User specific environment
if [ -f "$HOME/.common/env.sh" ]; then
	source "$HOME/.common/env.sh"
fi

# Source shell aliases and functions
if [ -f "$HOME/.common/shell.sh" ]; then
	source "$HOME/.common/shell.sh"
fi

# User specific aliases and functions
if [ -d "$MY_BASH_DIR" ]; then
	for rc in "$MY_BASH_DIR"/*; do
		source "$rc"
	done
fi

unset rc


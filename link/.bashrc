# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# User specific environment
if [ -f "$HOME/.common_env" ]; then
	source "$HOME/.common_env"
fi

# Source shell aliases and functions
if [ -f "$HOME/.common_shell" ]; then
  source "$HOME/.common_shell"
fi

# User specific aliases and functions
if [ -d "$HOME/.bashrc.d" ]; then
	for rc in "$HOME/.bashrc.d"/*; do
		if [ -f "$rc" ]; then
			source "$rc"
		fi
	done
fi

unset rc
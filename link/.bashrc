# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

if [ -d "$HOME/.common" ] ; then
	for rc in "$HOME/.common"/* ; do
		source "$rc"
	done
fi

# User specific aliases and functions
if [ -d "$MY_BASH_DIR" ]; then
	for rc in "$MY_BASH_DIR"/*; do
		source "$rc"
	done
fi

eval "$(_PIPENV_COMPLETE=bash_source pipenv)"

unset rc


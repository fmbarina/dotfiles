# Reference:
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
# [.bash_profile (.bash_login (.profile)) @login] OR [.bashrc @interactive]

# Source global definitions
if [[ -s /etc/bashrc ]]; then
	source /etc/bashrc # Fedora
elif [[ -s /etc/bash.bashrc ]]; then
	source /etc/bash.bashrc # Debian
fi

# Source common interactive stuff (shell agnostic)
if [[ -s $HOME/.common/shell.sh ]]; then
	source "$HOME/.common/shell.sh"
fi

# Bash specific stuff / source my hidden mess
if [[ -n $BASH_DIR && -d $BASH_DIR ]]; then
	for rc in "$BASH_DIR"/*; do
		source "$rc"
	done
	unset rc
fi

eval "$(_PIPENV_COMPLETE=bash_source pipenv)"

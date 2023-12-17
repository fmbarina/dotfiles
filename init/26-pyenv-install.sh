#!/usr/bin/env bash

! command -v git >/dev/null && log "[pyenv] Git not found. Skipping." && return

# Var -------------------------------------------------------------------------

pyenv_git='https://github.com/pyenv/pyenv.git'
pyenv_dir="${PYENV_ROOT:-${XDG_DATA_HOME:-$HOME/.local/share}/pyenv}"

# Run -------------------------------------------------------------------------

en_arrow 'Checking pyenv...'

if [[ -d $pyenv_dir ]]; then
	er_success 'Pyenv already installed'
	return 0
fi

ern_arrow 'Installing pyenv... '
if exec_with_animation git_clone "$pyenv_git" "$pyenv_dir"; then
	er_success 'Pyenv installed'
else
	er_error 'Could not install pyenv'
fi

#!/usr/bin/env bash

# NOTE: $HISTFILE is a variable used by multiple shells to store history.
# Doesn't mean we want to share their history files if we switch between them
# (ex: bash/zsh) so let them set their own paths when they run.
export HISTFILE="$MY_BASH_DIR/.bash_history"

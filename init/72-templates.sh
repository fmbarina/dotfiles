#!/usr/bin/env bash

# NOTE: This script points an issue in the current copy/link/init cycle. Any
# minimally complex task, even if still focused on copying/linking, is
# delegated to init. This 'templates' task should be, at worst, files in a
# directory and some declarative form of telling the dotfiles system how to
# figure out their destination. There should not be a unique script for every
# trivial copy operation that doesn't fit the dumbest mold.
# To be fixed: when I go crazy and decide to rewrite/refactor the entire repo.

# Var -------------------------------------------------------------------------

template_dir="$(xdg-user-dir TEMPLATES)"

# Run -------------------------------------------------------------------------

mkdir -p "$template_dir"

for t in "$DOTFILES/misc/templates"/* ; do
	copy "$t" "$template_dir"
done


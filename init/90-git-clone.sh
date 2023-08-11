#!/usr/bin/env bash

# Var -------------------------------------------------------------------------

repo_dir="$DEV_HOME"

git_repos=(
	'https://github.com/fmbarina/multicolumn.nvim'
	'https://github.com/b3nj5m1n/xdg-ninja.git'
	'https://github.com/sudofox/shell-mommy.git'
	# I'm gonna find a funny use for the last one, just give me time
)

# Run -------------------------------------------------------------------------

mkdir -p "$repo_dir"

for repo_url in "${git_repos[@]}"; do
	repo_name="$(git_dirname_from_url "$repo_url")"
	
	en_arrow "Checking $repo_name"

	if [ -d "$repo_dir"/"$repo_name" ] ; then
		er_success "Already cloned $repo_name"
		continue
	fi

	ern_arrow "Cloning $repo_name "
	if exec_with_animation git_clone "$repo_url" "$repo_dir/$repo_name" ; then
		er_success "Sucessfully cloned $repo_name"
	else
		er_error "Could not clone $repo_name"
	fi
done

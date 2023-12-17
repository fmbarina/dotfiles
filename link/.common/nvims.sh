# Thanks to:
# https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b

# Me to zsh editing this: why can't you just be normal!?

declare -A items
items=(
	['default']=''
	['Base']='nvim-base'
	['Multi']='nvim-multi'
)

# Create fast aliases
for i in "${items[@]}"; do
	[[ -z $i ]] && continue # skip default
	eval "alias $i='NVIM_APPNAME=$i nvim'"
done

# If fzf not found, function won't work. Stop here.
! command -v fzf &>/dev/null && return

function nvims() {
	choices=
	if [ -n "$ZSH_VERSION" ]; then
		# shellcheck disable=SC2296
		choices=${(j:\n:)${(k)items}}
		# )} The line above me breaks syntax highlighting. I have to add this
		# weird comment to make the rest of the file not crap. Thanks, zsh.
	else
		choices=$(printf '%s\n' "${!items[@]}")
	fi

	config=$(echo "$choices" | fzf --prompt=' Neovim Config ≫ ' \
		--height=~50% --layout=reverse --border --exit-0)

	if [ -z "$config" ]; then
		echo 'Nothing selected'
		return 0
	fi

	# I fkng swear, it stops working in zsh if I add quotes around config
	config="${items[$config]}"

	NVIM_APPNAME="$config" nvim "$@"
}
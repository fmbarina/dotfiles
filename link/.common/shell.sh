# Aliases

# Shorten
alias pp="ncmpcpp"

# "Custom" commands / Stuff I can't remember so I write it down
alias loop='for_loop'
alias frequencies='count_frequencies'
alias filetypes='count_filetypes'
alias scrape='scrape_url'

# I have a hoarding problem
alias bdfr='alias_bdfr'
alias yt-dlp='alias_yt_dlp'
alias gallery-dl='alias_gallery_dl'
alias gs-compress='alias_gs_compress'

# Trash
alias tt='trash-put'
alias rm="prompt_and_repeat 'Maybe try using trash-put (tt)' rm"
alias wreckmyeditor="tt ~/.cache/nvim ~/.config/nvim ~/.local/share/nvim \
	~/.local/state/nvim"

# Classics
alias cl='clear'
alias ls='ls --color=auto'
alias ll='ls -haAlF'
alias ..='cd ../..'
alias ...='cd ../../..'
alias ....='cd ../../../..'
alias pls='sudo'
alias please='sudo'
alias fucking='sudo'

# Dumb crap for the dumb
alias sshperm='alias_sshperm'
alias sshadd='ssh-add ~/.ssh/id_rsa'

# Clean up $HOME
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# Functions

prompt_and_repeat() {
	# Created to be used as a way to learn new commands, 
	# but without making the old ones impossible to use.
	# Prompt if the user really wants to do something, with: 
	# - $1 being a message
	# - $2 to $n being the something
	if prompt_yn "Are you sure about this? $1"; then
		# shellcheck disable=SC2068
		${@:2}
	else
		echo 'Canceled' && return 0
	fi
}

prompt_yn() {
	# This function will print a message ($1), prompt the user for [y/N], and
	# will stay in that line without more output until it receives either:
	# y/Y     - and returns 0
	# n/N     - and returns 1
	# <enter> - and returns the default (checks '' for bash, $'\n' for zsh)
	printf '%s [y/N] ' "$1"
	while true; do
		# Limit to one character, raw, no echo back
		[ -n "${BASH_VERSION}" ] && read -n 1 -r -s input_res
		[ -n "${ZSH_VERSION}" ] && read -k 1 -r -s input_res
		case ${input_res} in
			[Yy]*) printf "\n" && return 0 ;;
			[Nn]*) printf "\n" && return 1 ;;
			'')    printf "\n" && return 1 ;; # Bash
			$'\n') printf "\n" && return 1 ;; # Zsh
		esac
	done
	# I refuse to write two separate files for doing this in bash<->zsh
}

for_loop() {
	# Loop from $1 to $2, by $3. Executes remaining args as command in loop.
	# Handy for one-liners, '_i' in input cmd is replaced by the integer
	_i=$1
	_cmd="${*:4}"
	_cmd="${_cmd//_i/\$_i}"

	# shellcheck disable=2016 # $_i mustn't expand yet. 2016 is a bit annoying
	# _cmd="$(echo "$@" | cut -d ' ' -f 1,2,3 --complement | \
	# 	sed 's/_i/$_i/g')" # POSIX compatible(?)

	if [ "$_i" -le "$2" ]; then
		while [ "$_i" -le "$2" ]; do
			eval "$_cmd"
			_i=$((_i + $3))
		done
	else
		while [ "$_i" -ge "$2" ]; do
			eval "$_cmd"
			_i=$((_i - $3))
		done
	fi
}

count_frequencies() {
	sort | uniq --count | sort --numeric-sort --reverse
}

count_filetypes() {
	local tool
	tool='find . -maxdepth 1 -type f '

	command -v 'fd' 1> /dev/null 2>&1 && tool='fd . --max-depth=1 --type f -H'

	# NOTE: behold, this perl command I stole from stackoverflow
	eval "${tool}" | perl -ne 'print $1 if m/\.([^.\/]+)$/' | count_frequencies
}

scrape_url() {
	if [ -z "$4" ]; then
		echo "Usage: scrape <directory-prefix> <depth> <accept> URL"
		echo
		echo "accept: img = jpeg,jpg,jxl,bmp,gif,png,webp"
		echo "        vid = mp4,m4v,webm"
		echo "        doc = pdf,doc,docx,odt,html,ppt,pptx"
		return
	fi
	
	local accept

	accept=''
	[ "$3" = "img" ] && accept="${accept}jpeg,jpg,jxl,bmp,gif,png,webp,"
	[ "$3" = "vid" ] && accept="${accept}mp4,m4v,webm,"
	[ "$3" = "doc" ] && accept="${accept}pdf,doc,docx,odt,html,ppt,pptx,"
	[ -z "${accept}" ] && accept="$3"

	wget --no-directories --recursive --level="$2" --directory-prefix="$1" \
		--accept "${accept}" --user-agent="Mozilla/5.0 (X11; Linux x86_64; \
		rv:109.0) Gecko/20100101 Firefox/109.0" "$4"
}

alias_bdfr() {
	local bdfr_dir
	bdfr_dir="$(xdg-user-dir DOWNLOAD)"/'0-bdfr'
	mkdir -p "${bdfr_dir}"
 	local scheme
 	scheme=''
 	if [ "$1" = 'download' ]; then
 	 	scheme="--file-scheme={UPVOTES}_{DATE}_{REDDITOR}_{TITLE}_{POSTID}"
 	fi
	\bdfr "$1" "${bdfr_dir}" "${scheme}" "${@:2}"
	# We are actually including paths even in --help, which doesn't make sense,
	# but it works. That's good enough for me in most cases.
}

alias_yt_dlp() {
	local yt_dlp_dir
	yt_dlp_dir="$(xdg-user-dir DOWNLOAD)"/'0-yt-dlp'
	mkdir -p "${yt_dlp_dir}"
	\yt-dlp -P "${yt_dlp_dir}" "$@"
}

alias_gallery_dl() {
	local gallery_dl_dir
	gallery_dl_dir="$(xdg-user-dir DOWNLOAD)"/'0-gallery-dl'
	mkdir -p "${gallery_dl_dir}"
 	# TODO: format --filename?
	# https://github.com/mikf/gallery-dl/blob/master/docs/formatting.md
	\gallery-dl -d "${gallery_dl_dir}" "$@"
}

alias_gs_compress() {
	# Thanks to:
	# https://gist.github.com/ahmed-musallam/27de7d7c5ac68ecbd1ed65b6b48416f9
	gs \
		-q -dNOPAUSE -dBATCH -dSAFER \
		-sDEVICE=pdfwrite \
		-dCompatibilityLevel=1.4 \
		-dPDFSETTINGS=/screen \
		-dEmbedAllFonts=true -dSubsetFonts=true \
		-dColorImageDownsampleType=/Bicubic \
		-dColorImageResolution=144 \
		-dGrayImageDownsampleType=/Bicubic \
		-dGrayImageResolution=144 \
		-dMonoImageDownsampleType=/Bicubic \
		-dMonoImageResolution=144 \
		-sOutputFile="${1%.*}.compressed.pdf" \
		"$@"
}

alias_sshperm() {
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	[ -e ~/.ssh/id_rsa ] && chmod 600 ~/.ssh/id_rsa*
	[ -e ~/.ssh/config ] && chmod 644 ~/.ssh/config
}


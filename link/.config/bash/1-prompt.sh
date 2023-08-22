#!/usr/bin/env bash

is_git() {
	[ -d '.git' ] && return
	[ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]
}

git_branch() {
	local branch
	branch=$(git branch --show-current)
	[ -z "$branch" ] && branch="NONE" # Else it would just be empty "[]"
	echo "$branch"
}

git_untracked() {
	git status | grep --quiet 'Untracked files'
}

git_modified() {
	git status | grep --quiet 'Changes not staged for commit'
}

git_staged() {
	git status | grep --quiet 'Changes to be committed'
}

git_ahead() {
	git status | grep --quiet 'Your branch is ahead'
}


set_prompt() {
	# Store the exit code so it doesn't get overwritten
	local exitcode=$?

	PS1=''

	# Git information if in repository directory
	if is_git ; then
		PS1+="[${BO}${BRO}${BT}$(git_branch)${ET}"

		local git_status

		# Fill git_status information to add it to the prompt
		git_untracked && git_status+='u'
		git_modified  && git_status+='m'
		git_staged    && git_status+='s'
		git_ahead     && git_status+='a'

		# Add git_status only if not empty
		if [ -n "$git_status" ] ; then
			PS1+="${BO}${RED}${BT}:${ET}${git_status}"
		fi

		PS1+="]"
	fi

	# Main part of the prompt eg [user@host]path/to/dir
	PS1+="[${BO}${CYA}${BT}\u${ET}@${BO}${GRE}${BT}\h${ET}]" # user@host
	PS1+="${BO}${BT}\w${ET}\n" # working directory
	
	# Add number of jobs (running+stopped) before prompt $ if there are any
	if [ -n "$(jobs -sr | awk 'END {print $NR}')" ]; then
		PS1+="|${BO}${BT}\j${ET}| "
	fi	

	# Show exit code if it's non-zero - Note this doesn't always imply an error
	if (( exitcode != 0 )); then
		PS1+="${BO}${RED}${BT}|${ET}${BO}${BT}${exitcode}${ET}${BO}${RED}${BT}|${ET} "
	fi

	PS1+="\$ "

	# Immediatly write history instead of waiting for the shell to exit
	history -a
}

PROMPT_COMMAND=set_prompt

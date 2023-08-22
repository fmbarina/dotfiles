#!/usr/bin/env bash
# shellcheck disable=SC2034

# HISTFILE is a variable used by multiple shells to store their history.
# Doesn't mean we want to share their history files if we switch between them
# (ex: bash/zsh) so let them set their own paths when they run.
HISTFILE="$BASH_DIR/.bash_history"

# Formatting stuff
# These aren't really for saving characters as much as they're for making this
# stuff actually readable. Seriously, you start chaining these, it's a pita.

# Text modifiers
NO='\[\033[0' # Normal
BO='\[\033[1' # Bold
IT='\[\033[3' # Italic
UN='\[\033[4' # Underline
BL='\[\033[5' # Blinking

# Text colors
BLA=';30' # Black
RED=';31' # Red
GRE=';32' # Green
BRO=';33' # Brown / Yellow
BLU=';34' # Blue
PUR=';35' # Purple
CYA=';36' # Cyan
GRA=';37' # Gray

# Background colors
BGBLA=';40' 
BGRED=';41'
BGGRE=';42'
BGBRO=';43'
BGBLU=';44'
BGPUR=';45'
BGCYA=';46'
BGGRA=';47'

# Structure
BT='m\]' # Begin text / This feels silly, two characters for three.
ET='\[\033[0m\]' # End text


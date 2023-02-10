#!/usr/bin/env bash

# Formatting ------------------------------------------------------------------

# Text modifiers
NOR='\[\033[0' # Normal
BOL='\[\033[1' # Bold
ITA='\[\033[3' # Italic
UND='\[\033[4' # Underline
BLI='\[\033[5' # Blinking

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
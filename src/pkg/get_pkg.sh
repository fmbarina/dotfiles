#!/usr/bin/env bash

# $1 package base name
# $2 translated name source

tool='grep --line-number'
command -v 'rg' 1> /dev/null 2>&1 && tool='rg --line-number'

# Thanks to https://stackoverflow.com/questions/59895/
pkg_dir="$(dirname "$(readlink -f "$0")")"/list

# Arguments check

if [ -z "$1" ]; then
    echo "No arguments provided."
    exit 1
fi

if [ -z "$2" ]; then
    echo "Base name provided but translation source wasn't provided."
    exit 1
fi

if [ -n "$3" ]; then
    echo "Unknown third argument: $3"
    exit 1
fi

# List check
if ! [ -e "${pkg_dir}/$2.txt" ]; then
    echo "Could not find package list '$2' (source)." 
    exit 2
fi

# Execute command "tool" searching pattern 
# "(start of line)(package base name)(end of line)"
# in file 'packages.txt', then extract the line number from the output (N:term)
line=$(eval "${tool}" "^$1$" < "${pkg_dir}/packages.txt" | \
    awk -F ':' '{print $1}')

if [ -z "$line" ]; then
    echo "Could not find '$1' in the base package list."
    exit 3
fi

# Retrieve second col item in
# "(desired source of translated name).txt"
# in the specific $line
ret=$(awk -F ',' 'NR=='"$line"' {print $2}' "${pkg_dir}/$2.txt")

[ -z "$ret" ] && exit 4

echo "$ret"

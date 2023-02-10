#!/usr/bin/env bash

# $1 package base name

tool='grep --line-number'
command -v 'rg' 1> /dev/null 2>&1 && tool='rg --line-number'

# Thanks to https://stackoverflow.com/questions/59895/
pkg_dir="$(dirname "$(readlink -f "$0")")"/list

# Arguments check

if [ -z "$1" ]; then
    echo "No arguments provided."
    exit 1
fi

if [ -n "$2" ]; then
    echo "Unknown second argument: $2"
    exit 1
fi

# Execute command "tool" searching pattern 
# "(start of line)(package base name)(end of line)"
# in file 'packages.txt', then extract the line number from the output (N:term)
line=$(eval "${tool}" "^$1$" < "${pkg_dir}/packages.txt" | \
    awk -F ':' '{print $1}')

if [ -z "$line" ]; then
    echo "Could not find package '$1'."
    exit 3
fi

# Remove line from every package list
for list in "${pkg_dir}"/* ; do
    LC_COLLATE=C sed --in-place "/^$1,/d" "$list"
done

#!/usr/bin/env bash

# $1 package base name
# $2 translated name destination
# $3 translated name
# if $2 is present, $3 is expected to be as well

tool='grep --line-number'
command -v 'rg' 1> /dev/null 2>&1 && tool='rg --line-number'

# Thanks to https://stackoverflow.com/questions/59895/
pkg_dir="$(dirname "$(readlink -f "$0")")"/list

# Arguments check

if [ -z "$1" ]; then
    echo "No arguments provided."
    exit 1
fi

if [ -n "$2" ] && [ -z "$3" ]; then
    echo "Destination provided but translated name wasn't provided."
    exit 1
fi

if [ -n "$4" ]; then
    echo "Unknown fourth argument: $4"
    exit 1
fi

# List check
if [ -n "$2" ] && ! [ -e "${pkg_dir}/$2.txt" ]; then
    echo "Could not find package list '$2' (destination)." 
    exit 2
fi

# Execute command "tool" searching pattern 
# "(start of line)(package base name)(end of line)"
# in file 'packages.txt', then set 'is_in_base' if match found
eval "${tool}" "^$1$" < "${pkg_dir}/packages.txt" >/dev/null 2>&1 && \
    is_in_base='yes'

# If package was found in the base list, we must...
if [ -n "$is_in_base" ] ; then

    # Get line of package
    line=$(eval "${tool}" "^$1$" < "${pkg_dir}/packages.txt" | \
        awk -F ':' '{print $1}')

    # Check if not adding to any list
    if [ -z "$2" ]; then
        echo "Package '$1' already added."
        exit 3
    fi

    # Try getting translated package name in list $2
    name="$(awk -F ',' 'NR=='"$line"'{print $2}' "${pkg_dir}/$2.txt")"

    # Check if adding to a list, but package already in it
    if [ -n "$name" ]; then
        echo "Package '$1' already exists in the '$2' list as '$name'."
        exit 4
    fi

    # If none of these are the case, it's fine to proceed
fi

# Add basename to lists
if [ -z "$is_in_base" ] ; then
    echo "$1" >>"${pkg_dir}/packages.txt"
    LC_COLLATE=C sort -o "${pkg_dir}/packages.txt" "${pkg_dir}/packages.txt"

    for list in "${pkg_dir}"/* ; do
        [ "$(basename "$list")" == "packages.txt" ] && continue
        echo "$1," >>"$list"
        LC_COLLATE=C sort -o "$list" "$list"
    done
fi

if [ -n "$2" ]; then
    sed --in-place "s/$1,/$1,$3/" "${pkg_dir}/$2.txt"
fi

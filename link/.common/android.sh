#!/bin/bash
# shellcheck disable=SC2034

[ -n "$ANDROID_ENV_SOURCED" ] && return
ANDROID_ENV_SOURCED='y'

# NOTE: sadly, adb will always generate "$HOME/.android/adbkeys"

# Made with help of:
# https://developer.android.com/tools/variables
# https://wiki.archlinux.org/title/XDG_Base_Directory

set -a

# Android SDK

# Sets the path to the SDK installation directory
ANDROID_HOME="$XDG_DATA_HOME/android"

# Deprecated, replaced by ANDROID_HOME. If set, newer android studio versions
# will check that both variables are consistent
ANDROID_SDK_ROOT="$ANDROID_HOME"

# Sets the path to the user preferences directory for tools that are part of
# the Android SDK. Defaults to $HOME/.android/
ANDROID_USER_HOME="$ANDROID_HOME/.android"

# Some older tools, such as Android Studio 4.3 and earlier, do not read
# ANDROID_USER_HOME. To override the user preferences location for those older
# tools, set ANDROID_SDK_HOME to the parent directory you would like the
# .android directory to be created under.
# export ANDROID_SDK_HOME="$(cd "$ANDROID_USER_HOME/.." && pwd)"
ANDROID_SDK_HOME="$ANDROID_HOME"

# Emulator

# Sets the path to the user-specific emulator configuration directory.
# Defaults to $ANDROID_USER_HOME
# Older tools, such as Android Studio 4.3 and earlier, do not read
# ANDROID_USER_HOME. For those, the default value is $ANDROID_SDK_HOME/.android
# export ANDROID_EMULATOR_HOME=

# Sets the path to the directory that contains all AVD-specific files, which
# mostly consist of very large disk images.
# The default location is $ANDROID_EMULATOR_HOME/avd/
# export ANDROID_AVD_HOME=

# Path

PATH="$PATH:$ANDROID_HOME/tools"
PATH="$PATH:$ANDROID_HOME/tools/bin"
PATH="$PATH:$ANDROID_HOME/platform-tools"
PATH="$PATH:$ANDROID_HOME/emulator"
PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools/bin"
PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

# Flutter

FLUTTER="$DEV_HOME/flutter"
PATH="$PATH:$FLUTTER/bin"

# Java pains

if [ -z "$JAVA_HOME" ] && command -v java &>/dev/null ; then
	JAVA_HOME=$(dirname "$(dirname "$(readlink -f "$(which java)")")")
fi

# Make directories

if ! [ -e "$ANDROID_HOME" ]; then
	mkdir -p "$ANDROID_HOME"
fi

# What if we kept the user preferences with all the rest...?
# if ! [ -L "$ANDROID_HOME/.android" ]; then
# 	ln -s "$ANDROID_HOME" "$ANDROID_HOME/.android"
# fi

set +a

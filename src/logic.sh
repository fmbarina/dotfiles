#!/usr/bin/env bash

# shellcheck source=../vendor/bash_animations/bash_loading_animations.sh
source "$DOTFILES/vendor/bash_animations/bash_loading_animations.sh"

# Var -------------------------------------------------------------------------

ae_arrow=
ae_success=
ae_error=

# Functions -------------------------------------------------------------------

exec_with_animation() {
    # $1: Command
    # ${@:2} Arguments
    BLA::start_loading_animation "${BLA_classic[@]}"
    if "$@" ; then
        BLA::stop_loading_animation ; return 0
    else
        BLA::stop_loading_animation ; return 1
    fi
}

action_set_echo_loading() {
    ae_arrow="$1"
}

action_set_echo_success() {
    ae_success="$1"
}

action_set_echo_error() {
    ae_error="$1"
}

action_with_echos() {
    # Set start, success and fail messages before with
    # action_start_set_echo_*
    # $1: Command
    # ${@:2} Arguments
    en_arrow "$ae_arrow "
    if exec_with_animation "$@" ; then
        er_success "$ae_success"
    else
        er_error "$ae_error"
    fi
}

#!/usr/bin/env bash

# XXX: this sucks if not on Linux, use 'uname -s' to check if ever needed

if [ -e /etc/sysctl.d/reisub-active.conf ]; then
    log '[reisub] already activated'
    e_success 'REISUB already activated'
    return
fi

if [ -d /etc/sysctl.d ]; then
    # TODO: Could not find a way to write to file in sudo command with current
    # sudo_do implementation. Maybe reconsider this bit in the future
    sudo_do "cp $DOTFILES/misc/sysctl.d/reisub-active.conf \
        /etc/sysctl.d/reisub-active.conf"
    
    if [ -e /etc/sysctl.d/reisub-active.conf ]; then
        log '[reisub] activated'
        e_success 'Activated REISUB'
        return
    fi
fi

log '[reisub] could not be activated'
e_error 'Could not activate REISUB'
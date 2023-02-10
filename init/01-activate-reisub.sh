#!/usr/bin/env bash

# XXX: this sucks if not on Linux, use 'uname -s' to check if ever needed

if [ -d /etc/sysctl.d ] && ! [ -e /etc/sysctl.d/reisub-active.conf ]; then
    sudo_do 'echo "kernel.sysrq=1" > /etc/sysctl.d/reisub-active.conf'
    return
fi

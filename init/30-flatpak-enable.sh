#!/usr/bin/env bash

! is_known_distro && log "[flatpak-install] Unkown distro. Skipping." && return

# Run -------------------------------------------------------------------------

flatpak_enable

#!/usr/bin/env bash

return 0 # TODO: this maybe

! command -v flavours >/dev/null && \
	log "[flavours] flatours not found. Skipping." && return

# Run -------------------------------------------------------------------------

en_arrow 'Updating schemes and templates... '
if exec_with_animation flavours update all >/dev/null; then
	er_success 'Schemes and templates updated'
else
	er_error 'Failed to updated flavours'
	return 1
fi
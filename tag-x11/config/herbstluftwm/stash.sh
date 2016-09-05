#!/bin/bash

# Stashes a tag's windows and clears current, to be loaded back later.

if [[ "$(herbstclient tag_status)" != *"!stash"* ]]; then
    herbstclient add "!stash"
fi

stashlayout=$(herbstclient dump "!stash")
herbstclient load "!stash" "$(herbstclient dump)"
herbstclient load "$stashlayout"


#!/usr/bin/env bash
# packages.sh — stow packages
# Add/remove entries here to control which configs get symlinked.

PACKAGES=(
    fish        # shell
    git         # git config
    nvim        # editor
    bash        # bash config + local scripts
    starship    # prompt
    tmux        # terminal multiplexer
    tms         # tmux sessionizer config
    tmate       # tmux session sharing config
    alacritty   # terminal emulator config
    ptpython    # Python REPL config
    pudb        # Python debugger config
    pypoetry    # Poetry config
)

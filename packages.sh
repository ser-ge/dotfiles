#!/usr/bin/env bash
# packages.sh — what gets stowed.
#
# Edit freely: move packages between MIN/MAX, or remove them entirely.
# bootstrap.sh reads this and installs the corresponding system tools
# automatically — no other files need to change.

# ── min: core shell + editor ──────────────────────────────────────────────────
PACKAGES_MIN=(
    fish        # shell
    git         # git config
    nvim        # editor (core plugins only)
    bash        # bash config + local scripts
    starship    # prompt
)

# ── max: full workstation setup ───────────────────────────────────────────────
PACKAGES_MAX=(
    "${PACKAGES_MIN[@]}"
    nvim-max    # extra nvim plugins (AI, obsidian, jupyter, slime, database, etc.)
    tmux        # terminal multiplexer
    tms         # tmux sessionizer config
    tmate       # tmux session sharing config
    alacritty   # terminal emulator config
    ptpython    # Python REPL config
    pudb        # Python debugger config
    pypoetry    # Poetry config
)

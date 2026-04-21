#!/usr/bin/env bash
# Editor bindings and preferences

export EDITOR='vim'
export SUDO_EDITOR="$HOME/.local/bin/vim"
export PAGER="less -RFX"

[[ "$-" != *i* ]] && return

set -o vi # Vi editing mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
# export MANPAGER="/bin/sh -c \"sed -e 's/\x1B\[[[:digit:]]\+m//g' | col -b | vim --appimage-extract-and-run --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
export MANPAGER="vim --appimage-extract-and-run +MANPAGER --not-a-term -c 'set ts=8 nolist number' -"
alias cat=/usr/local/bin/vimcat

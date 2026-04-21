#!/usr/bin/env bash
# General shell configuration
# use `2>/dev/null` for prevent fail when on old bash

shopt -s expand_aliases
export GPG_TTY=$(tty)
shopt -s globstar 2>/dev/null || true # Recursive globbing

[[ "$-" != *i* ]] && return
# Auto-correct
shopt -s cdspell
shopt -s dirspell 2>/dev/null || true

[[ -x /usr/bin/neofetch ]] && neofetch

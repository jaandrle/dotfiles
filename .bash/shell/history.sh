#!/usr/bin/env bash
[[ "$-" != *i* ]] && return

export HISTCONTROL="ignoreboth:erasedups"
shopt -s histappend cmdhist
export HISTFILESIZE=10000
export HISTSIZE="$HISTFILESIZE"
export HISTIGNORE="?? :but:but rub *:but commit:but ?? ?? :tree:vim:git info:git i:git lazy:git l"

bind '"\C-@": "\e^I history | grep '\''\e\e^A'\''\e\ei"'

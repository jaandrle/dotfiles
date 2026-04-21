#!/usr/bin/env bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[[ "$-" != *i* ]] && return

if type brew &>/dev/null
then
	HOMEBREW_PREFIX="$(brew --prefix)"
	if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
	then
		PS1='force' source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
	else
		for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
		do
			[[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
		done
	fi
fi

#!/usr/bin/env bash

export BASH_DOTFILES="$HOME/.bash"
[[ -f "$BASH_DOTFILES/shell/index.sh" ]] \
	&& source "$BASH_DOTFILES/shell/index.sh"
[[ -f "$BASH_DOTFILES/toolchains/index.sh" ]] \
	&& source "$BASH_DOTFILES/toolchains/index.sh"

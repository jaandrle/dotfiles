#!/usr/bin/env bash
# System configuration index
# Source all system-related configuration files

declare dir="$BASH_DOTFILES/system"
for file in "$dir"/*.sh; do
	[[ -f "$file" && "$file" != "$dir/index.sh" ]] && source "$file"
done
unset dir

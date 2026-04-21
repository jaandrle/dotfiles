#!/usr/bin/env bash
# Shell configuration index
# Source all shell-related configuration files

declare dir="$BASH_DOTFILES/shell"
for file in "$dir"/*.sh; do
	[[ -f "$file" && "$file" != "$dir/index.sh" ]] && source "$file"
done
unset dir

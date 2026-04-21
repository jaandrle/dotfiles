#!/usr/bin/env bash
# Toolchains configuration index
# Source all toolchain-related configuration files

declare dir="$BASH_DOTFILES/toolchains"

source "$dir/cross-session/index.sh"

for file in "$dir"/*.sh; do
	[[ -f "$file" && "$file" != "$dir/index.sh" ]] && source "$file"
done

unset dir

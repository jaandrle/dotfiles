#!/usr/bin/env bash
[[ "$-" != *i* ]] && return

declare -r store_all=/dev/shm/bash
declare -r store_pid="$store_all/$BASHPID/"
declare -r hooks="$BASH_DOTFILES/hooks"

shm() {
	local -r hook="$hooks/onfirst"

	if [[ ! -d "$store_all" && -f "$hook" ]]; then
		source "$hook"
	fi
	mkdir -p "$store_pid"
	trap "source '$hooks/onexit'" EXIT
}
shm
unset -f shm

ON() {
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		echo "Manage bash hooks"
		echo "Usage: ON <hook> [pid|all]"
		return 0
	fi
	if [[ -z "$1" ]]; then
		tree "$hooks"
		tree "$store_pid"
		return 0
	fi
	if [[ ! -f "$hooks/on$1" ]]; then
		echo "No such hook: '$1'" >&2
		return 1
	fi
	local -r name="on$1"
	local -r where="${2:-pid}" # pid or all
	local target="$hooks/$name"
	if [[ "$where" == "pid" ]]; then
		target="$store_pid/$name"
		if [[  ! -f "$target" ]]; then
			echo "#!/usr/bin/env bash" > "$target"
			chmod u+x "$target"
		fi
	fi
	vim "$target"
}
__ON_complete() {
	if [[ "$COMP_CWORD" == 1 ]]; then
		COMPREPLY=($(compgen -W "$(for f in "$hooks"/on*; do echo "${f##*/on}"; done)" -- "${COMP_WORDS[COMP_CWORD]}"))
		return 0
	fi
	if [[ "$COMP_CWORD" == 2 ]]; then
		COMPREPLY=($(compgen -W "pid all" -- "${COMP_WORDS[COMP_CWORD]}"))
		return 0
	fi
}
complete -F __ON_complete ON

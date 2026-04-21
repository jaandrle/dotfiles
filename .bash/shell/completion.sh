#!/usr/bin/env bash

[[ "$-" != *i* ]] && return

if ! shopt -oq posix; then # Enable programmable completion features
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion
	fi
fi


SCRIPT_DIR=$(builtin cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source "$SCRIPT_DIR/complete-alias/complete_alias"

complete -F _complete_alias gitdotfiles

source <(bs .completion bash)
source <(gh completion -s bash)
source <(roxy completions bash)
source <(node --completion-bash)
source <(npm completion)
source <(nodejsscript --completion bash)

# NPX completion
_npx() {
	local cur="${COMP_WORDS[COMP_CWORD]}"

	if [[ $COMP_CWORD != 1 ]]; then
		case "${COMP_WORDS[1]}" in
			gulp)
				local compls=$(npx gulp --tasks-simple)
				if [[ $compls == *"__autocomplete_bash"* ]]; then
						compls="$compls $(npx gulp -L __autocomplete_bash --_l=$COMP_CWORD --_c=$cur)"
				fi
			;;
		esac
		COMPREPLY=($(compgen -W "$compls" -- "$cur"))
		return 0;
	fi

	local dir=$(pwd -P)
	while [[ -n "$dir" ]]; do
		if [[ ! -d $dir/node_modules/.bin ]]; then
			dir=${dir%/*}
			continue
		fi
		local execs=( $(cd $dir/node_modules/.bin; find -L . -type f -executable) )
		execs=( ${execs[@]/#.\//} )
		COMPREPLY=( $(compgen -W "${execs[*]} serve" -- "$cur" ) )
		break
	done
}
complete -F _npx npx

# On demand
alias C--pnpm='source "$BASH_DOTFILES/shell/completion/pnpm.completion"'
alias C--cordova='source "$BASH_DOTFILES/shell/completion/cordova.completion"'
alias C--uu='source <($HOME/.local/bin/uu --completion-bash)'
alias C--jc='source <(jc -B)'
alias C--but='source <(but completions bash)'

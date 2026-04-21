#!/usr/bin/env bash
# UI/UX configuration

# Check window size after each command
shopt -s checkwinsize

# Color support for ls and other tools
if [ -x /usr/bin/dircolors ]; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")" 2>/dev/null || true
	else
		eval "$(dircolors -b)" 2>/dev/null || true
	fi
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)" # make less more friendly for non-text input files, see lesspipe(1)
export LS_COLORS="$LS_COLORS:tw=01;04;34:ow=01;04;34:"
alias ls='ls --color=auto -pQFh --group-directories-first'

[[ "$-" != *i* ]] && return

updatePrompt() {
	local -r prev_exit="$?"
	# color_helper_>>color<< (Note: \[\]= escaping)
	local -r chR="\[\033[1;91m\]"  #red
	local -r chW="\[\033[00m\]"  #white
	local -r chG="\[\033[01;32m\]"	 #green
	local -r chB="\[\033[0;34m\]"  #blue
	local -r chP="\[\033[0;35m\]"  #purple
	local -r chY="\[\033[0;33m\]"  #yellow
	PS1=""
	if [ "$prev_exit" -eq 0 ]; then
		PS1+="$chG✓ $chW"
	else
		PS1+="$chR✗ $chW"
	fi
	local jobs
	jobs=$(jobs -p | wc -w)
	[[ "$jobs" -ne 0 ]] && PS1+="${chY}≡${jobs}${chW}"
	PS1+="${debian_chroot:+($debian_chroot)}"
	PS1+=" At ${chG}\A${chW}"
	PS1+=" by ${chP}\u${chW}"
	if sudo -n true 2>/dev/null; then
		PS1+="${chR} (sudo)${chW}"
	fi
	PS1+=" in "
	if \git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		local branch
		branch="$(\git symbolic-ref -q HEAD)"
		PS1+="[${branch#refs/heads/}"
		local status
		status="$(git for-each-ref --format='%(upstream:trackshort)' "$branch" 2>/dev/null | awk '!seen[$1]++ {printf $1}')"
		status+="$(git status --porcelain 2>/dev/null | awk '!seen[$1]++ {printf $1}')"
		[ "$status" != "" ] && \
			PS1+="|$chY$status$chW"
		PS1+="] "
	fi
	PS1+="${chB}\w${chW}"
	PS1+="\n${PS1_jaaENV:-:}"

	local -r hook="$BASH_DOTFILES/hooks/onprompt"
	if [[ -f "$hook" ]]; then
		source "$hook"
	fi
}
[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] \
	&& debian_chroot=$(cat /etc/debian_chroot)
setPrompt() {
	local color_prompt
	[[ $TERM == "xterm-color" ]] || [[ $TERM == *-256color ]] \
		&& color_prompt=yes
	which tput >&/dev/null && ! tput setaf 1 >&/dev/null \
		&& color_prompt=
	if [[ "$color_prompt" != yes ]]; then
		PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND}"
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
		return
	fi
	case "$TERM" in
		xterm*|rxvt*)
			;;
		*)
			PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
			return
			;;
	esac
	PROMPT_COMMAND="updatePrompt${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
	PS2="|"
}
setPrompt
unset -f setPrompt

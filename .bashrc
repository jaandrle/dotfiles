#### BASH Config file
### Jan Andrle
## Info:
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples
export EDITOR='vim'
BASH_DOTFILES=$HOME/.bash
[ -f $BASH_DOTFILES/.bash_aliases ] && . $BASH_DOTFILES/.bash_aliases
shopt -s expand_aliases

[ -f $BASH_DOTFILES/.bash_jaaENV ] && . $BASH_DOTFILES/.bash_jaaENV
[ -f $BASH_DOTFILES/.bash_sdkman ] && . $BASH_DOTFILES/.bash_sdkman
[ -f $BASH_DOTFILES/.bash_nvm ] && . $BASH_DOTFILES/.bash_nvm
export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache # https://nolanlawson.com/2024/10/20/why-im-skeptical-of-rewriting-javascript-tools-in-faster-languages/
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -f $BASH_DOTFILES/.bash_completions ] && . $BASH_DOTFILES/.bash_completions # for Vim

[[ $- != *i* ]] && return					# If not running interactively, don't do anything

## General
set -o vi									# VIM mode for bash
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
# export MANPAGER="/bin/sh -c \"sed -e 's/\x1B\[[[:digit:]]\+m//g' | col -b | vim --appimage-extract-and-run --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
export MANPAGER="vim --appimage-extract-and-run +MANPAGER --not-a-term -c 'set ts=8 nolist' -"
export PAGER=/usr/bin/vimpager
alias less=$PAGER
alias cat=/usr/bin/vimcat
vhead() {
	if [[ -t 1 && -n $1 ]]; then
		command head "$@" | command vimcat
	else
		command head "$@"
	fi
}
vtail() {
	if [[ -t 1 && -n $1 ]]; then
		command tail "$@" | command vimcat
	else
		command tail "$@"
	fi
}

## History
export HISTCONTROL=ignoreboth:erasedups		# No duplicate entries and started with spaces. See bash(1) for more options
shopt -s histappend cmdhist					# saving multiline + append
export HISTFILESIZE=10000					# increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}				# increase history size (default is 500)
export HSTR_CONFIG=hicolor,prompt-bottom
export HSTR_PROMPT='?: '

## UI/UX
									# clors for .inputrc (set colored-stats On)
export LS_COLORS=$LS_COLORS:'tw=01;04;34:ow=01;04;34:'
									# set variable identifying the chroot you work in (used in the prompt below)
[ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
									# Set a fancy prompt (non-color, unless we know we "want" color)
[[ $TERM == "xterm-color" ]] || [[ $TERM == *-256color ]] && color_prompt=yes
[ ! -x /usr/bin/tput ] || ! tput setaf 1 >&/dev/null && color_prompt=

[ -f $BASH_DOTFILES/.bash_promt ] && . $BASH_DOTFILES/.bash_promt

# Add an "alert" alias for long running commands.  Use like so:
#	sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
  fi
fi
export GPG_TTY=$(tty)

shopt -s cdspell # autocorrects cd misspellings
shopt -s dirspell 2>/dev/null || true	# bash >= 4

# HSTR configuration - add this to ~/.bashrc
# if this is interactive shell, then bind hstr to Ctrl-space
# if [[ $- =~ .*i.* ]]; then bind '"\C-@": "\e^ihstr -- \C-j"'; fi
if [[ $- =~ .*i.* ]]; then bind '"\C-@": "\e^I history | grep '\''\e\e^A'\''\e\ei"'; fi

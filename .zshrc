#compdef devbox

# zsh completion for devbox								  -*- shell-script -*-

__devbox_debug()
{
	local file="$BASH_COMP_DEBUG_FILE"
	if [[ -n ${file} ]]; then
		echo "$*" >> "${file}"
	fi
}

_devbox()
{
	local shellCompDirectiveError=1
	local shellCompDirectiveNoSpace=2
	local shellCompDirectiveNoFileComp=4
	local shellCompDirectiveFilterFileExt=8
	local shellCompDirectiveFilterDirs=16

	local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
	local -a completions

	__devbox_debug "\n========= starting completion logic =========="
	__devbox_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"

	# The user could have moved the cursor backwards on the command-line.
	# We need to trigger completion from the $CURRENT location, so we need
	# to truncate the command-line ($words) up to the $CURRENT location.
	# (We cannot use $CURSOR as its value does not work when a command is an alias.)
	words=("${=words[1,CURRENT]}")
	__devbox_debug "Truncated words[*]: ${words[*]},"

	lastParam=${words[-1]}
	lastChar=${lastParam[-1]}
	__devbox_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"

	# For zsh, when completing a flag with an = (e.g., devbox -n=<TAB>)
	# completions must be prefixed with the flag
	setopt local_options BASH_REMATCH
	if [[ "${lastParam}" =~ '-.*=' ]]; then
		# We are dealing with a flag with an =
		flagPrefix="-P ${BASH_REMATCH}"
	fi

	# Prepare the command to obtain completions
	requestComp="${words[1]} __complete ${words[2,-1]}"
	if [ "${lastChar}" = "" ]; then
		# If the last parameter is complete (there is a space following it)
		# We add an extra empty parameter so we can indicate this to the go completion code.
		__devbox_debug "Adding extra empty parameter"
		requestComp="${requestComp} \"\""
	fi

	__devbox_debug "About to call: eval ${requestComp}"

	# Use eval to handle any environment variables and such
	out=$(eval ${requestComp} 2>/dev/null)
	__devbox_debug "completion output: ${out}"

	# Extract the directive integer following a : from the last line
	local lastLine
	while IFS='\n' read -r line; do
		lastLine=${line}
	done < <(printf "%s\n" "${out[@]}")
	__devbox_debug "last line: ${lastLine}"

	if [ "${lastLine[1]}" = : ]; then
		directive=${lastLine[2,-1]}
		# Remove the directive including the : and the newline
		local suffix
		(( suffix=${#lastLine}+2))
		out=${out[1,-$suffix]}
	else
		# There is no directive specified.	Leave $out as is.
		__devbox_debug "No directive found.  Setting do default"
		directive=0
	fi

	__devbox_debug "directive: ${directive}"
	__devbox_debug "completions: ${out}"
	__devbox_debug "flagPrefix: ${flagPrefix}"

	if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
		__devbox_debug "Completion received error. Ignoring completions."
		return
	fi

	local activeHelpMarker="_activeHelp_ "
	local endIndex=${#activeHelpMarker}
	local startIndex=$((${#activeHelpMarker}+1))
	local hasActiveHelp=0
	while IFS='\n' read -r comp; do
		# Check if this is an activeHelp statement (i.e., prefixed with $activeHelpMarker)
		if [ "${comp[1,$endIndex]}" = "$activeHelpMarker" ];then
			__devbox_debug "ActiveHelp found: $comp"
			comp="${comp[$startIndex,-1]}"
			if [ -n "$comp" ]; then
				compadd -x "${comp}"
				__devbox_debug "ActiveHelp will need delimiter"
				hasActiveHelp=1
			fi

			continue
		fi

		if [ -n "$comp" ]; then
			# If requested, completions are returned with a description.
			# The description is preceded by a TAB character.
			# For zsh's _describe, we need to use a : instead of a TAB.
			# We first need to escape any : as part of the completion itself.
			comp=${comp//:/\\:}

			local tab="$(printf '\t')"
			comp=${comp//$tab/:}

			__devbox_debug "Adding completion: ${comp}"
			completions+=${comp}
			lastComp=$comp
		fi
	done < <(printf "%s\n" "${out[@]}")

	# Add a delimiter after the activeHelp statements, but only if:
	# - there are completions following the activeHelp statements, or
	# - file completion will be performed (so there will be choices after the activeHelp)
	if [ $hasActiveHelp -eq 1 ]; then
		if [ ${#completions} -ne 0 ] || [ $((directive & shellCompDirectiveNoFileComp)) -eq 0 ]; then
			__devbox_debug "Adding activeHelp delimiter"
			compadd -x "--"
			hasActiveHelp=0
		fi
	fi

	if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
		__devbox_debug "Activating nospace."
		noSpace="-S ''"
	fi

	if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
		# File extension filtering
		local filteringCmd
		filteringCmd='_files'
		for filter in ${completions[@]}; do
			if [ ${filter[1]} != '*' ]; then
				# zsh requires a glob pattern to do file filtering
				filter="\*.$filter"
			fi
			filteringCmd+=" -g $filter"
		done
		filteringCmd+=" ${flagPrefix}"

		__devbox_debug "File filtering command: $filteringCmd"
		_arguments '*:filename:'"$filteringCmd"
	elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
		# File completion for directories only
		local subdir
		subdir="${completions[1]}"
		if [ -n "$subdir" ]; then
			__devbox_debug "Listing directories in $subdir"
			pushd "${subdir}" >/dev/null 2>&1
		else
			__devbox_debug "Listing directories in ."
		fi

		local result
		_arguments '*:dirname:_files -/'" ${flagPrefix}"
		result=$?
		if [ -n "$subdir" ]; then
			popd >/dev/null 2>&1
		fi
		return $result
	else
		__devbox_debug "Calling _describe"
		if eval _describe "completions" completions $flagPrefix $noSpace; then
			__devbox_debug "_describe found some completions"

			# Return the success of having called _describe
			return 0
		else
			__devbox_debug "_describe did not find completions."
			__devbox_debug "Checking if we should do file completion."
			if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
				__devbox_debug "deactivating file completion"

				# We must return an error code here to let zsh know that there were no
				# completions found by _describe; this is what will trigger other
				# matching algorithms to attempt to find completions.
				# For example zsh can match letters in the middle of words.
				return 1
			else
				# Perform file completion
				__devbox_debug "Activating file completion"

				# We must return the result of this command, so it must be the
				# last command, or else we must store its result to return it.
				_arguments '*:filename:_files'" ${flagPrefix}"
			fi
		fi
	fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_devbox" ]; then
	_devbox
fi

# activate gls colors
export ZSH_DIRCOLORS="$ZSH_CONFIG/dircolors-solarized/dircolors.256dark"
if [[ -a $ZSH_DIRCOLORS ]]; then
	if [[ "$TERM" == *256* ]]; then
		which gdircolors > /dev/null && eval "`gdircolors -b $ZSH_DIRCOLORS`"
	else
		# standard colors for non-256-color terms
		which gdircolors > /dev/null && eval "`gdircolors -b`"
	fi
else
	which gdircolors > /dev/null && eval "`gdircolors -b`"
fi
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
alias myls='ls -pFhA'
alias myrm='rm -vi'
alias mycp='cp -vi'
alias mymv='mv -vi'
alias mydf='df -Th'
alias myless='less -R -S'

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export ANDROID_HOME=$HOME/Library/Android/sdk && export PATH=$PATH:$ANDROID_HOME/emulator && export PATH=$PATH:$ANDROID_HOME/platform-tools
alias ctags='/usr/local/bin/ctags'
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/Users/janandrle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Make zsh autocomplete with up arrow
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
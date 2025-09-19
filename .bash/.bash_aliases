alias gitdotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi
alias ls='ls --color=auto -pQFh --group-directories-first'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

alias §df='df -Th'
§du(){
	[[ "$1" == '--help' ]] && echo "§du; §du '../*'" && return 0
	du -h -x -s -- ${1:-*} | sort -r -h;
}

CROSS_SESSION="$BASH_DOTFILES/.bash_cross_session"
[ -f "$CROSS_SESSION" ] && . "$CROSS_SESSION"
crossSession() {
	if [[ '--help' == "${1:---help}"  ]]; then
		echo 'crossSession [--help]'
		echo ' Print this help.'
		echo 'crossSession [--list]'
		echo ' Lists all cross session variables or print this help.'
		echo 'crossSession <name> [<value>]'
		echo ' Sets cross session variable <name> to <value> (or empty for unset).'
		return 0
	fi
	if [[ '--list' == "$1"	]]; then
		cat "$CROSS_SESSION"
		return 0
	fi
	local name="$1"
	local value="$2"

	# Check if the variable already exists in the file
	if grep -q "^export $name=" "$CROSS_SESSION"; then
		if [ -z "$value" ]; then
			# If new value is empty, remove the variable from the file
			sed -i "/^export $name=/d" "$CROSS_SESSION"
		else
			# If it exists, replace the old value with the new value
			sed -i "s|^export $name=.*|export $name=\"$value\"|" "$CROSS_SESSION"
		fi
	else
		if [ -n "$value" ]; then
			# If it doesn't exist and new value is not empty, append the new variable to the file
			echo "export $name=\"$value\"" >> "$CROSS_SESSION"
		fi
	fi
}
cd(){
	builtin cd "$@" || return $?
	crossSession 'OLDPWD' "$(pwd)"
}

§(){
	[[ -z "$1" ]] && clear && return 0
	echo "$ [--help]= clear or [print this text]"
	alias | grep "alias §" --color=never
	declare -F | grep 'declare -f §' --color=never
	\ls ~/.local/bin | grep -P "^§" | xargs -I{} echo '~/.local/bin/'{}
	printenv | grep -e '^l' | xargs -I{} echo \${}
}

alias pdftk='java -jar $HOME/bin/pdftk-all.jar'
bw-session(){
	bw logout
	# login=`kwallet-query kdewallet -f accounts -r Bitwarden 2> /dev/null`
	login=$(§kwallet.mjs --wallet kdewallet readPassword accounts bw-json)
	export BW_CLIENTSECRET=`echo "$login" | jq -r .secret`
	export BW_CLIENTID=`echo "$login" | jq -r .id`
	bw login --apikey --raw
	export BW_SESSION=`bw unlock --raw $(echo "$login" | jq -r .pass)` && echo "Bitwarden session ON" ||  echo "Bitwarden session FAILED"
	unset BW_CLIENTSECRET
	unset BW_CLIENTID
}

export lps_mem='-eo pid,ppid,cmd,%mem,%cpu --sort=-%mem'
export lps_cpu='-eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu'
export llsoft_all='-P -i -n'
export lgrep_compose='-i /usr/share/X11/locale/en_US.UTF-8/Compose ~/.XCompose'

§ping-test(){ # Pings ip address of noip.com and www.google.com.
  ping -c 1 -q 8.23.224.107 | grep --color=never -A 1 -i '\---'
  ping -c 1 -q www.google.com | grep --color=never -A 1 -i '\---'
}
§whoami(){
	[[ "$1" == '--help' ]] && echo '§whoami; §whoami --ip' && return 0
	local ip=$(curl -s ifconfig.me)
	[[ "$1" == '--ip' ]] && echo "$ip" && return 0
	local L="	%s\n"
	printf "\n"
	printf "$L" "USER: $(echo $USER)"
	printf "$L" "IP ADDR: $ip"
	printf "$L" "HOSTNAME: $(hostname -f)"
	printf "$L" "KERNEL: $(uname -rms)"
	printf "\n"
}
§cmdfu(){ curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"; }
aai(){
	[[ "$1" == '--help' ]] && ai ask --help && return 0;
	#echo "ai ask \"$*, thanks for your help\""; ai ask "\"$*, thanks for your help\"";
	aipick -m "hi, would like to ask for help: $*\n…please response only with plain text to be used in terminal command without any explanation, thanks for your help";
}

alias npx-wca='npx -y web-component-analyzer'
alias npx-qnm='npx -y qnm'
alias npx-hint='npx -y hint'
alias npx-markdown='npx -y markserv'
§interfaces() {
	node <<-EOF
	var os = require('os');
	var i = os.networkInterfaces();
	Object.keys(i).forEach(function(name) {
		i[name].forEach(function(int) {
			if (int.family === 'IPv4') {
				console.log('%s: %s', name, int.address);
			}
		});
	});
	EOF
}

alias smerge='/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=sublime_merge --file-forwarding com.sublimemerge.App @@u %u @@'
kommit(){
	if flatpak info org.kde.kommit > /dev/null 2>&1; then
		flatpak run \
			--branch=stable --arch=x86_64 \
			--file-forwarding \
			--command=kommit org.kde.kommit @@u $* @@ > /dev/null 2>&1 & disown;
	else 
		command kommit $* > /dev/null 2>&1 & disown;
	fi
}

§url-curl(){ curl --silent -I "$1" | grep -i location; }

rpg(){
	rpg-cli "$@"
	if ( [[ "$1" == "cd" ]] || [[ "$1" == "ls" ]] ); then
		[[ "$2" == "" ]] && $1 . && return 0
		[[ "$2" == ".." ]] && $1 .. && return 0
		[[ "-1" != "$(nodejsscript --print "s.ls().findIndex(e=> e==='$2'.replace(/\/$/, ''))")" ]] && $1 "$2" && return 0
	fi
	return 0

	# [[ "$(rpg-cli pwd)" == "$(pwd)" ]] && return 0
	# cd "$(rpg-cli pwd)"
}
rpg-dungeon(){
	current=$(basename $PWD)
	number_re='^[0-9]+$'

	if [[ $current =~ $number_re ]]; then
		next=$(($current + 1))
		command mkdir -p $next && cd $next && rpg ls
	elif [[ -d 1 ]] ; then
		cd 1 && rpg ls
	else
		command mkdir -p dungeon/1 && cd dungeon/1 && rpg ls
	fi
}

# alias adb-device='adb devices | tail -n +2 | head -n 1 | §awk 1'
# make-completion-wrapper, see https://gdhnotes.blogspot.com/2014/02/alias-bash-completion.html

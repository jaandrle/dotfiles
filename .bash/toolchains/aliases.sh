#!/usr/bin/env bash
export PATH="$PATH:$HOME/.local/share/soar/bin"

cd() {
	builtin cd "$@" || return $?
	crossSession 'OLDPWD' "$(pwd)"
	local -r hook="$BASH_DOTFILES/hooks/oncd"
	[[ -f "$hook" ]] && source "$hook"
}

alias gitdotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

alias §df='df -Th'

git(){
	if [[ -z "$1" ]]; then
		git-i
		return $?
	fi
	command git "$@"
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
export SVN_CONFIG_DIR="$HOME/.config/subversion"
alias svn='svn --config-dir "$SVN_CONFIG_DIR"'

§(){
	[[ -z "$1" ]] && clear && return 0
	echo "$ [--help]= clear or [print this text]"
	alias | grep "alias §" --color=never
	declare -F | grep 'declare -f §' --color=never
	\ls ~/.local/bin | grep -P "^§" | xargs -I{} echo '~/.local/bin/'{}
	printenv | grep -e '^l' | xargs -I{} echo \${}
}

bw-session(){
	bw logout
	login=$(§kwallet.mjs --wallet kdewallet readPassword accounts bw-json)
	export BW_CLIENTSECRET=`echo "$login" | jq -r .secret`
	export BW_CLIENTID=`echo "$login" | jq -r .id`
	bw login --apikey --raw
	export BW_SESSION=`bw unlock --raw $(echo "$login" | jq -r .pass)` && echo "Bitwarden session ON" || echo "Bitwarden session FAILED"
	unset BW_CLIENTSECRET
	unset BW_CLIENTID
}

alias §ps-mem='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem'
alias §ps-cpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu'
alias §lsoft-all='lsoft -P -i -n'
§ping-test() {
	ping -c 1 -q 8.23.224.107 | grep --color=never -A 1 -i '\---'
	ping -c 1 -q www.google.com | grep --color=never -A 1 -i '\---'
}
§whoami(){
	[[ "$1" == '--help' ]] && echo '§whoami; §whoami --ip' && return 0
	local ip=$(curl -s ifconfig.me)
	[[ "$1" == '--ip' ]] && echo "$ip" && return 0
	local L="\t%s\n"
	printf "\n"
	printf "$L" "USER: $(echo $USER)"
	printf "$L" "IP ADDR: $ip"
	printf "$L" "HOSTNAME: $(hostname -f)"
	printf "$L" "KERNEL: $(uname -rms)"
	printf "\n"
}
§curl-location() { curl --silent -I "$1" | grep -i location; }
§interfaces() {
	node <<-JAVASCRIPT
var os = require('os');
var i = os.networkInterfaces();
Object.keys(i).forEach(function(name) {
	i[name].forEach(function(int) {
		if (int.family === 'IPv4') {
			console.log('%s: %s', name, int.address);
		}
	});
});
JAVASCRIPT
}
§speedtest() {
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
}
portkiller(){
	"$BASH_DOTFILES/portkiller/portkiller.sh" $*
}
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

§cmdfu() { curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"; }

alias npx-wca='npx -y web-component-analyzer'
alias npx-qnm='npx -y qnm'
alias npx-hint='npx -y hint'
alias npx-markdown='npx -y markserv'
alias npx-toon='npx -y @toon-format/cli'

rpg(){
	rpg-cli "$@"
	if ( [[ "$1" == "cd" ]] || [[ "$1" == "ls" ]] ); then
		[[ "$2" == "" ]] && $1 . && return 0
		[[ "$2" == ".." ]] && $1 .. && return 0
		[[ "-1" != "$(nodejsscript --print "s.ls().findIndex(e=> e==='$2'.replace(/\/$/, ''))")" ]] && $1 "$2" && return 0
	fi
	return 0
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

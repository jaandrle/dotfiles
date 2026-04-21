#!/usr/bin/env bash
# jaaENV - Environment management system
function jaaENV {
	if [[ "$1" = "--help" ]]; then
		echo "jaaENV - Environment Management System"
		echo "Utility to manage multiple tool versions in one config file '.jaaENV'"
		echo "Replaces: 'nvm use 16 && sdk use java 11 && ...'"
		echo ""
		echo "Usage:"
		echo "	jaaENV					  # Load settings from .jaaENV or compose.yaml"
		echo "	jaaENV --help			  # Show this help"
		echo "	jaaENV --ls				  # List available versions (nvm, sdk, php, java)"
		echo "	jaaENV --save nodejs php  # Save current versions to .jaaENV"
		echo ""
		echo "Example .jaaENV file:"
		echo "	nodejs=16.13.0"
		echo "	php=8.1"
		echo "	java=11"
		echo "	gradle=7.4"
		echo ""
		echo "Supported options:"
		echo "	android_home  # Use ANDROID_HOME instead of ANDROID_SDK_ROOT"
		echo "	jdk			  # Set JAVA_HOME for Android Studio (9+)"
		echo "	nodejs|php	   # Node.js/PHP version management"
		echo "	java		  # Java version switching"
		echo "	gradle		  # Gradle version management"
		echo ""
		echo "Requirements:"
		echo "	NVM:	https://github.com/nvm-sh/nvm (Node.js)"
		echo "	SDKMAN: https://sdkman.io (Java, Gradle, etc.)"
		echo "	PHP:	update-alternatives + https://deb.sury.org/"
		echo "	Java:	update-alternatives"
		echo ""
		echo "Quick setup:"
		echo "	sudo update-alternatives --set php /usr/bin/php8.1"
		return 0
	fi

	if [[ "$1" == "--save" ]]; then
		shift
		rm -vi .jaaENV
		while [[ $# -gt 0 ]]; do
			case "$1" in
				nodejs|node)
					echo "nodejs=$(node --version | cut -c2-)" >> .jaaENV
					;;
				gradle)
					echo "gradle=$(gradle --version | awk '/Gradle/ {print $2}')" >> .jaaENV
					;;
				php)
					echo "php=$(php --version | awk '/^PHP/ {print $2}')" >> .jaaENV
					;;
				java)
					local java_version
					java_version=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
					if [[ "$java_version" == 1.8* ]]; then
						java_version="8"
					else
						java_version=$(echo "$java_version" | cut -d'.' -f1)
					fi
					echo "java=$java_version" >> .jaaENV
					;;
				*)
					echo "Unknown '$1' – skipped"
					;;
			esac
			shift
		done
		return 0
	fi

	if [[ "$1" == "--ls" ]]; then
		echo ":: nvm ls --no-alias ::"
		nvm ls --no-alias
		echo ":: update-alternatives --list php ::"
		update-alternatives --list php
		echo ":: update-alternatives --list java ::"
		update-alternatives --list java
		echo ":: sdk ls gradle | grep -E '\*|>' ::"
		sdk ls gradle | grep -E '\*|>'
		return 0
	fi
	
	if [[ -f "compose.yaml" ]]; then
		jdk=$(grep -Po 'VERSION_JAVA=\K.*' compose.yaml)
		nodejs=$(grep -Po 'VERSION_NODEJS=\K.*' compose.yaml)
	elif [[ -f ".jaaENV" ]]; then
		source ./.jaaENV
	else
		echo 'No env file `compose.yaml` or `.jaaENV`'
		return 1
	fi
	
	local chP="\[\033[0;35m\]"	#purple
	local chW="\[\033[00m\]"  #white
	export PS1_jaaENV="${chP}¦${chW}"
	
	if [[ -n "${ANDROID_SDK_ROOT_BAK+x}" ]]; then
		export ANDROID_SDK_ROOT="$ANDROID_SDK_ROOT_BAK"
		echo "\$ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT_BAK"
		unset ANDROID_SDK_ROOT_BAK
	fi
	if [[ -n "${unset_android_sdk+x}" ]]; then
		export ANDROID_SDK_ROOT_BAK="$ANDROID_SDK_ROOT"
		unset ANDROID_SDK_ROOT
	fi
	if [[ -n "${java+x}" ]]; then
		if [[ "$java" == "8" ]]; then
			java="1.8"
		fi
		local java_local
		java_local=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
		if [[ "$java_local" != "$java"* ]]; then
			if [[ "$java" == "1.8" ]]; then
				java="8"
			fi
			echo "Switching Java version: $java ← $java_local"
			local java_path="/usr/lib/jvm/java-$java-openjdk-amd64/"
			if [[ "$java" == "8" ]]; then
				java_path+="jre/"
			fi
			sudo update-alternatives --set java "${java_path}bin/java"
			local javac
			javac=$(update-alternatives --list javac | grep "java-$java")
			if [[ -n "$javac" ]]; then
				sudo update-alternatives --set javac "$javac"
			fi
			sudo -k
		fi
		export JAVA_HOME=$(readlink -f "$(which java)" | cut -d '/' -f1-5)/
		echo "\$JAVA_HOME=$JAVA_HOME"
	fi
	if [[ -n "${android_home+x}" ]]; then
		export ANDROID_HOME="$ANDROID_HOME_BAK"
		echo "\$ANDROID_HOME=$ANDROID_HOME"
	else
		unset ANDROID_HOME
		echo "\$ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
	fi
	if [[ -n "${android_home_is_sdk+x}" ]]; then
		export ANDROID_HOME="$ANDROID_SDK_ROOT"
		echo "\$ANDROID_HOME=$ANDROID_HOME"
	fi
	if [[ -n "${JAVA_HOME_BAK+x}" ]]; then
		export JAVA_HOME="$JAVA_HOME_BAK"
		unset JAVA_HOME_BAK
	fi
	if [[ -n "${jdk+x}" ]]; then
		if (( $(echo "$jdk > 9" | bc -l) )); then
			export JAVA_HOME_BAK="$JAVA_HOME"
			export JAVA_HOME="/snap/android-studio/current/android-studio/jre"
		fi
		echo "\$JAVA_HOME=$JAVA_HOME"
	fi
	if [[ -n "${nodejs+x}" ]]; then
		if [[ "$(which node)" == *linuxbrew* ]]; then
			brew unlink node
		fi
		nvm use "$nodejs"
	fi
	if [[ -n "${gradle+x}" ]]; then
		sdk use gradle "$gradle" | tr -d '\n'
		echo
	fi
	if [[ -n "${php+x}" ]]; then
		local php_local
		php_local=$(php --version | awk '/^PHP/ {print $2}')
		if [[ "$php_local" == "$php"* ]]; then
			echo "PHP version: $php"
		else
			echo "Switching PHP version: $php ← $php_local"
			sudo update-alternatives --set php "/usr/bin/php$php"
			sudo -k
		fi
	fi
	
	# Cleanup variables
	unset android_home unset_android_sdk nodejs gradle php java
}

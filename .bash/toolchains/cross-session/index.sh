#!/usr/bin/env bash
declare -r CROSS_SESSION="$BASH_DOTFILES/toolchains/cross-session/store.sh"
[[ -f "$CROSS_SESSION" ]] && \
    source "$CROSS_SESSION"

# Cross session management function
crossSession() {
    if [[ '--help' == "${1:---help}" ]]; then
        echo 'crossSession [--help]'
        echo ' Print this help.'
        echo 'crossSession [--list]'
        echo ' Lists all cross session variables or print this help.'
        echo 'crossSession <name> [<value>]'
        echo ' Sets cross session variable <name> to <value> (or empty for unset).'
        return 0
    fi
    if [[ '--list' == "$1" ]]; then
        cat "$CROSS_SESSION"
        return 0
    fi
    local name="$1"
    local value="$2"

    # Check if the variable already exists in the file
    if grep -q "^export $name=" "$CROSS_SESSION"; then
        if [[ -z "$value" ]]; then
            # If new value is empty, remove the variable from the file
            sed -i "/^export $name=/d" "$CROSS_SESSION"
        else
            # If it exists, replace the old value with the new value
            sed -i "s|^export $name=.*|export $name=\"$value\"|" "$CROSS_SESSION"
        fi
    else
        if [[ -n "$value" ]]; then
            # If it doesn't exist and new value is not empty, append the new variable to the file
            echo "export $name='$value'" >> "$CROSS_SESSION"
        fi
    fi
}

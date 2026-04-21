#!/usr/bin/env bash
# SDKMAN! - Software Development Kit Manager

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Usage: sdk install java 11.0.12-open, sdk use java 11.0.12-open

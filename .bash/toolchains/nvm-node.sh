#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
eval "$([[ -s "$NVM_DIR/nvm.sh" ]] && echo "source '$NVM_DIR/nvm.sh'")"
eval "$([[ -s "$NVM_DIR/bash_completion" ]] && echo "source '$NVM_DIR/bash_completion'")"

export NODE_COMPILE_CACHE="$HOME/.cache/nodejs-compile-cache" # https://nolanlawson.com/2024/10/20/why-im-skeptical-of-rewriting-javascript-tools-in-faster-languages/

# Bash Configuration

This directory contains the bash configuration files organized by responsibility.

## Structure

```
.bash/
```
- [`system/`](./system/README.md): System-level configurations for `.profile`
- [`shell/`](./shell/README.md): Shell-specific configurations
- [`toolchains/`](./toolchains/README.md): (Development) toolchain configurations
- [`hooks/`](./hooks/README.md): hooks scripts

## Usage

The main `.bashrc` and `.profile` files source the appropriate index files from each category:

```bash
# In .bashrc:
[ -f "$BASH_DOTFILES/system/index.sh" ] && . "$BASH_DOTFILES/system/index.sh"
[ -f "$BASH_DOTFILES/shell/index.sh" ] && . "$BASH_DOTFILES/shell/index.sh"
[ -f "$BASH_DOTFILES/toolchains/index.sh" ] && . "$BASH_DOTFILES/toolchains/index.sh"
```

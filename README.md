[![git3moji–v1.0](https://img.shields.io/badge/git3moji–v1.0-%E2%9A%A1%EF%B8%8F%F0%9F%90%9B%F0%9F%93%BA%F0%9F%91%AE%F0%9F%94%A4-fffad8.svg?style=flat-square)](https://robinpokorny.github.io/git3moji/)
 · [source code on Gitea](https://gitea.jaandrle.cz/jaandrle/dotfiles)
 · [*mirrored* on GitHub](https://github.com/jaandrle/dotfiles)
 · [older version on GitHub](https://github.com/jaandrle/dotfiles-old)

# dotfiles **(WIP)**
This repository contains my dotfiles. They are managed by using `git clone --bare`,
see for example [How to Store Dotfiles - A Bare Git Repository \| Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

## Quick links
- [On a new machine](#on-a-new-machine)
- [Files overview](#files-overview)

## Files overview
- [Bash](./.bash/README.md)
- [Vim](./.vim/README.md)
- [Geany](./.config/geany/README.md)
- [Vifm](./.config/vifm/README.md)
- [SSH](./.ssh/README.md)
- [Newsboat](./.newsboat/README.md)
- [git](./.config/git/config), [gh](./.config/gh/config.yml)
- [KDE Neon](#kde-neon)
- [Mozilla Firefox](./.mozilla/firefox/README.md)
- [Bin – scripts and executables](./.local/bin/README.md)

## On a new machine
1. install git
1. `cd ~`
1. `gd_branch=main` (see also variants `main-termux`)
1. `git clone --bare --branch $gd_branch --depth 1 --recurse-submodules --shallow-submodules git@jaandrle.cz:jaandrle/dotfiles.git ~/.dotfiles`
1. `alias gitdotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'`
1. `gitdotfiles config --local status.showUntrackedFiles no`
1. you may also need to use
	1. `gitdotfiles reset` (`git-dotfiles reset --hard HEAD`)
	1. `gitdotfiles checkout -f`
	1. `gitdotfiles submodule update --init --recursive`

## PC log (cs)
Sekce obsahuje log změn v Tuxedo laptopu s KDE Neon.

### TUXEDO OS (24.04.4 LTS / 2026-03-20)
- [ ] installed tv
    - [television/cable/unix at main · alexpasmantier/television](https://github.com/alexpasmantier/television/tree/main/cable/unix)
    - https://github.com/omerxx/dotfiles/tree/master
### TUXEDO OS (24.04.3 LTS / 2025-09-12)
- [ ] git new setup (fresh install)
- [ ] nextcloud (issue with multiple users)
    - [x] Celleste sync non-recursive
    - [ ] rclone?
- [x] https://github.com/simonw/llm-llamafile/issues/2 (`/home/linuxbrew/.linuxbrew/Cellar/llm/0.27.1/libexec/lib/python3.13/site-packages/`)
- [ ] To uninstall, run '~/.local/share/vdhcoapp/vdhcoapp uninstall' and remove '~/.local/share/vdhcoapp'.

```terminal
>_: brew upgrade
…
Bash completion has been installed to:
  /home/linuxbrew/.linuxbrew/etc/bash_completion.d
==> rclone
Homebrew's installation does not include the `mount` subcommand on macOS which depends on FUSE, use `nfsmount` instead.
==> docker-compose
Compose is a Docker plugin. For Docker to find the plugin, add "cliPluginsExtraDirs" to ~/.docker/config.json:
  "cliPluginsExtraDirs": [
      "/home/linuxbrew/.linuxbrew/lib/docker/cli-plugins"
  ]
```

### Old device
- ended up with TUXEDO OS (24.04.2 LTS / 2025-07-15)
	- [ ] :zap: disabled (`Hiden`) for `/home/jaandrle/.config/autostart/re.sonny.Eloquent.desktop`
	- [Aloxaf/silicon: Create beautiful image of your source code.](https://github.com/Aloxaf/silicon) {DONE <2024-03-07> *utils* agenda}$
	- [x] no need anymore: !!! Event calendar widget (in progress [ALikesToCode/plasma-applet-eventcalendar at plasma-6](https://github.com/ALikesToCode/plasma-applet-eventcalendar/tree/plasma-6))
	- [x] ended up with Tiler: tilling → try to use native, try to use [zeroxoneafour/polonium: Tiling window manager for KWin 5.27](https://github.com/zeroxoneafour/polonium) (when there will be a new release)
	- [ ] [`npx npmkill` — Why are node_modules SO BIG 🤦‍♂️ #javascript #software #technology #code #webdev - YouTube](https://www.youtube.com/shorts/VgPNtow7fNM?app=desktop&si=Kl7CH3vCoyH7tqFU)
	- [ ] `brew install fabric-ai`
- prev (KDE Neon)
	- [x] G'MIC - GREYC's Magic for Image Computing: A Full-Featured Open-Source Framework for Image Processing - Main](https://gmic.eu/)
	- [x] [PSA: How to re-enable LibreOffice integration in Plasma 6 : r/kde](https://www.reddit.com/r/kde/comments/1b9k755/psa_how_to_reenable_libreoffice_integration_in/)
	- [x] `sudo apt install $(check-language-support)`, see [Popup Language support is incomplete](http://unix.stackexchange.com/questions/421066/ddg#421079)

<details>
<summary>`{… cmd}$` explanation</summary>

This is [mdexpr](https://github.com/jaandrle/mdexpr) syntax. This document uses:
- {use [agenda](https://github.com/jaandrle/mdexpr-agenda) with states=TODO,NEXT|DONE mdexpr}$

</details>

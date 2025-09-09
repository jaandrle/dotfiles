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

- [Aloxaf/silicon: Create beautiful image of your source code.](https://github.com/Aloxaf/silicon) {DONE <2024-03-07> *utils* agenda}$

### TUXEDO OS (24.04.2 LTS / 2025-07-15)
- [ ] (temporaly created new) `~/.config/plasma-org.kde.plasma.desktop-appletsrc.bak` see below
- [x] fixed by update (2025-07-17) — :bug: kwallet6 (pam) autounlock
- [ ] :zap: disabled (`Hiden`) for `/home/jaandrle/.config/autostart/re.sonny.Eloquent.desktop`


```terminal
plasmashell --replace

kf.plasma.quick: Applet preload policy set to 1
file:///usr/share/plasma/plasmoids/org.kde.desktopcontainment/contents/ui/main.qml:178:25: QML FolderView
DropArea (parent or ancestor of QQuickLayoutAttached): Binding loop detected for property "minimumWidth":
file:///usr/share/plasma/plasmoids/org.kde.desktopcontainment/contents/ui/main.qml:201:9
Toolbox not loading, toolbox package is either invalid or disabled.
```

### TUXEDO OS (24.04.1 LTS)
- [x] no need anymore: !!! Event calendar widget (in progress [ALikesToCode/plasma-applet-eventcalendar at plasma-6](https://github.com/ALikesToCode/plasma-applet-eventcalendar/tree/plasma-6))
- [x] ended up with Tiler: tilling → try to use native, try to use [zeroxoneafour/polonium: Tiling window manager for KWin 5.27](https://github.com/zeroxoneafour/polonium) (when there will be a new release)
- [x] see ↓: hud ([uszie/plasma-hud), in KDE Plasma.](https://github.com/uszie/plasma-hud)/[Zren/plasma-hud](https://github.com/Zren/plasma-hud) still works on X11), but maybe Ctrl+Alt+i and so on is OK?
	- testing to use command palletes in programs and sets shortcuts to `ctr+;` (✓ kde programs, ✓ gimp, ✓ libreoffice, ✓ inkscape, ✓ vscode)
- [ ] [Fingerprint reader support : r/tuxedocomputers](https://www.reddit.com/r/tuxedocomputers/comments/176fscp/fingerprint_reader_support/), still receiving “no match”
- [ ] [`npx npmkill` — Why are node_modules SO BIG 🤦‍♂️ #javascript #software #technology #code #webdev - YouTube](https://www.youtube.com/shorts/VgPNtow7fNM?app=desktop&si=Kl7CH3vCoyH7tqFU)
- [ ] `brew install fabric-ai`

### KDE Neon (staré)
- [x] KDE Plasma5 Fixes](https://zren.github.io/kde/)
- [x] `sudo apt install $(check-language-support)`, see [Popup Language support is incomplete](http://unix.stackexchange.com/questions/421066/ddg#421079)
- [x] kde plasma 5 - How to use miracast as an extended desktop on Linux? - Super User](https://superuser.com/questions/1160078/how-to-use-miracast-as-an-extended-desktop-on-linux)
- [x] Setup git on the CLI to use 2FA with GitHub](https://gist.github.com/ateucher/4634038875263d10fb4817e5ad3d332f)
- [x] G'MIC - GREYC's Magic for Image Computing: A Full-Featured Open-Source Framework for Image Processing - Main](https://gmic.eu/)
- [x] [PSA: How to re-enable LibreOffice integration in Plasma 6 : r/kde](https://www.reddit.com/r/kde/comments/1b9k755/psa_how_to_reenable_libreoffice_integration_in/)

### Konsolidace klíčenek správce hesel
{DONE <2022-07-14 20:40> *cli* *hesla* agenda}$

- [x] cli pro KWalletManager
	1. `keyring get imap centrumCZ`
	1. `kwalletcli -f imap -e centrumCZ`
- [x] Firefox
	- `nss-password -d ~/.mozilla/firefox/ezjfn8hg.default-release NAME`
	- [infinity0/mozilla-gnome-keyring: A firefox extension that enables Gnome Keyring integration](https://github.com/infinity0/mozilla-gnome-keyring)
- [x] [Bitwarden CLI](https://bitwarden.com/help/cli/)

### Varování v python scriptech
{DONE <2022-07-09 20:37> *python* *workaround* agenda}$

Postupováno podle návodu [Rename the `~/.local/lib/python3.8/site-packages/pkg_resources` folder to `pkg_resources_back`](https://askubuntu.com/a/1398073).

<details>
<summary>`{… cmd}$` explanation</summary>

This is [mdexpr](https://github.com/jaandrle/mdexpr) syntax. This document uses:
- {use [agenda](https://github.com/jaandrle/mdexpr-agenda) with states=TODO,NEXT|DONE mdexpr}$

</details>

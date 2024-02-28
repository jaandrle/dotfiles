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
- [Vifm](./.config/vifm/README.md)
- [SSH](./.ssh/README.md)
- [Newsboat](./.newsboat/README.md)
- Git: [.gitconfig](./.gitconfig), [gh](./.config/gh/config.yml)
- [KDE Neon](#kde-neon)
- [Mozilla Firefox](./.mozilla/firefox/README.md)
- [Bin – scripts and executables](./bin/README.md)

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

## KDE Neon
- [KDE Plasma5 Fixes](https://zren.github.io/kde/)
- Using ‘HTML Wallpaper’ (wip)
	- [Bing Image Of The Day](./Obrázky/Bing Image Of The Day/index_template.html)
- [GNOME Keyring in KDE Plasma - JWillikers](https://www.jwillikers.com/gnome-keyring-in-kde-plasma)
- `sudo apt install $(check-language-support)`, see [Popup Language support is incomplete](http://unix.stackexchange.com/questions/421066/ddg#421079)
- [KDE Neon does not have an hibernation option? : kde](https://www.reddit.com/r/kde/comments/6n5m49/kde_neon_does_not_have_an_hibernation_option/dk7hd8v/)
- [kde plasma 5 - How to use miracast as an extended desktop on Linux? - Super User](https://superuser.com/questions/1160078/how-to-use-miracast-as-an-extended-desktop-on-linux)
- [Best tiling extensions for kwin? : kde](https://www.reddit.com/r/kde/comments/qgsv2u/best_tiling_extensions_for_kwin/?sort=new)
- [KDE Plasma5 Fixes](https://zren.github.io/kde/)
- [Setup git on the CLI to use 2FA with GitHub](https://gist.github.com/ateucher/4634038875263d10fb4817e5ad3d332f)
- [G'MIC - GREYC's Magic for Image Computing: A Full-Featured Open-Source Framework for Image Processing - Main](https://gmic.eu/)


## PC log (cs)
Sekce obsahuje log změn v Tuxedo laptopu s KDE Neon.

### KDE neon 5.26 (22.04)
{DONE <2022-10-25 17:21> *mail* *hud* *klíčenka* agenda}$

- Ve směs OK
- HUD ztratil stylování, použito breeze pro celé rofi (vygóglováno)
- mailnag začal zapomínat heslo po příštím spuštění → nakonec: [Bubblemail - Downloads](http://bubblemail.free.fr/downloads)
	- z článku [The 10 Best Mail Notification Tools for Linux System](https://www.ubuntupit.com/best-mail-notification-tools-for-linux/)
	- zkoušen KMail – šlo by s ním žít, jen když už klient tak aby mi vyhovoval/fungoval
	- thunderbird: nemá možnost notifikací na pozadí (celý program musí běžet)
	- himalaya: má `watch`, ale detekuje jen nové (ne nově označené jako nepřečtené – asi OK), ale hl. se nedařilo zprovoznit přihlašování (kombinace s bitwarden)
- `canonical-livepatch` nefunguje
- Gnome klíčenka se neodemyká → přeinstalováno → uvidíme

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

### kwin-tiling
- https://gitlab.com/faho/kwin-tiling/


<details>
<summary>`{… cmd}$` explanation</summary>

This is [mdexpr](https://github.com/jaandrle/mdexpr) syntax. This document uses:
- {use [agenda](https://github.com/jaandrle/mdexpr-agenda) with states=TODO,NEXT|DONE mdexpr}$

</details>

# dotfiles **(WIP)**
This repository contains my dotfiles. They are managed by using `git clone --bare`,
see for example [How to Store Dotfiles - A Bare Git Repository \| Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials/dotfiles).

## On a new machine
1. install git
1. `cd ~`
1. `git clone --bare --depth 1 --recurse-submodules --shallow-submodules git@jaandrle.cz:jaandrle/dotfiles.git ~/.dotfiles`
1. `alias gitdotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'`
1. `gitdotfiles config --local status.showUntrackedFiles no`
1. you may also need to use
	1. `gitdotfiles reset` (`git-dotfiles reset --hard HEAD`)
	1. `gitdotfiles checkout -f`
	1. `gitdotfiles submodule update --init --recursive`

# Kings Dotfiles

# Context

When I started as a Linux user (1996) and became a Sysadmin in 2000, there
were no simple ways to take the config files versioned remotely, equally
we can do now. In the last of +20 years, mostly of my dotfiles were lost,
and reconfigured from scratch.

# Disclaimer

IT WAS NOT PRODUCED TO BE A DISTRIBUTION, use it if you would like to have
an inspiration, fork it in your private, or public repo.

Feel free, to send me suggestions, but not inquiry me if something does work
as you like. Doubts are welcome, I will answer if a have time.

# Objectives

The main objectives of thees repository, as to reduce the wasted time in
recovery, and also, avoiding a misleading config in a complex environment.
Usually, everyone that already has been immersed with an open-source world,
either with a developer or as a user, knows how hard it can be to manage
them - and with me, it would be no different.

# Program files managed

* ZSH
  - More details about and inspiration:
    * https://github.com/zsh-users/zsh
    * https://github.com/ohmyzsh/ohmyzsh
  - Plugins with ZINIT:
    - https://github.com/zdharma/zinit 

* TMUX
  - More details about and inspiration:
    * https://github.com/tmux/tmux/wiki
  - Plugins with TPM:
    - https://github.com/tmux-plugins/tpm

* VIM, the classic editor
  - More details about and inspiration:
    * https://www.vim.org
    * https://github.com/spf13/spf13-vim
    * https://www.reddit.com/r/vim
  - Plugins with Plug:
    - https://github.com/junegunn/vim-plug

# Installation

## Testing inside of a docker container

If would you like to evaluate it, the most simple way is using a docker container.

```sh
docker run -ti ubuntu bash
apt-get update && apt-get install -y file build-essential git subversion curl wget
sudo autoconf pkg-config language-pack-en-base
```

## Cloning the repo

There is some limitations, and actually, the root must be ~/repos/dotfiles.

```sh
mkdir ~/repos ; cd ~/repos
git clone --recurse-submodules https://github.com/ricardoareis/dotfiles
```

Execute the zsh target.     [About the Makefile](https://github.com/ricardoareis/dotfiles/blob/master/Makefile)

```sh
cd ~/repos/dotfiles; make zsh
```

Compile the ZINIT modules.  [About the Modules](https://github.com/zdharma/zinit/blob/master/README.md#zinit-module)

```sh
cd ~/repos/dotfiles; zinit module build
```

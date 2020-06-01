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
sudo autoconf pkg-config language-pack-en-base ncurses-dev zlib1g-dev libreadline-dev
libbz2-dev libssl-dev libsqlite3-dev libffi-dev
```

## Cloning the repo

There is some limitations, and actually, the root must be ~/repos/dotfiles.

```sh
mkdir ~/repos ; cd ~/repos
git clone --recurse-submodules https://github.com/ricardoareis/dotfiles
```

Execute the zsh [target](https://github.com/ricardoareis/dotfiles/blob/master/Makefile#zsh)

```sh
cd ~/repos/dotfiles; make zsh
```

Compile the ZINIT [Module](https://github.com/zdharma/zinit/blob/master/README.md#zinit-module)

```sh
cd ~/repos/dotfiles; zinit module build
```

Compiling Python, needed by [powerline-status (TMUX)](https://github.com/powerline/powerline)

Note: any different output:
  * If pyenv does not work https://github.com/pyenv/pyenv-doctor
  * If pyenv can't compile python https://github.com/pyenv/pyenv/wiki/common-build-problems

```sh
pyenv install 3.8.0
Downloading Python-3.8.0.tar.xz...
-> https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz
Installing Python-3.8.0...
Installed Python-3.8.0 to /root/.pyenv/versions/3.8.0
```

Defining python as a global version

```sh
pyenv global 3.8.0
```

Upgrade the pip version, and install wheel

```sh
pip install --upgrade pip
pip install wheel

```

Install powerline-status with pip

```sh
pip install powerline-status
```

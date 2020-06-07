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

* Vim, the classic editor
  - More details about and inspiration:
    * https://www.vim.org
    * https://github.com/spf13/spf13-vim
    * https://www.reddit.com/r/vim
  - Plugins with Plug:
    - https://github.com/junegunn/vim-plug

# Installation

## Testing inside of a [Docker](https://docs.docker.com/engine/install/) container

If would you like to evaluate it, the most simple way is using a docker container.

```sh
$ docker run -ti ubuntu bash

$ apt-get update

$ apt-get install -y autoconf build-essential curl file git language-pack-en-base    \
                     libbz2-dev libffi-dev libreadline-dev libsqlite3-dev libssl-dev \
                     ncurses-dev pkg-config subversion sudo wget zlib1g-dev
```

## Cloning the repo

There is some limitations, and actually, the root must be ~/repos/dotfiles.

```sh
$ mkdir ~/repos ; cd ~/repos

$ git clone --recurse-submodules https://github.com/ricardoareis/dotfiles
```

## ZSH

1. Compile the ZINIT [Module](https://github.com/zdharma/zinit/blob/master/README.md#zinit-module)

```sh
$ cd ~/repos/dotfiles; zinit module build
```

2. Install ZSH, with [zsh target](https://github.com/ricardoareis/dotfiles/blob/master/Makefile#L36)

```sh
$ cd ~/repos/dotfiles; make zsh
```

3. Make the ZSH the default shell

```sh
$ cd ~/repos/dotfiles; make zsh_default
make[1]: Entering directory '/root/repos/dotfiles'
Would you like to make the zsh the default shell?
Are you sure? [y/N]: y
Adopting ZSH as a default shell
make[1]: Leaving directory '/root/repos/dotfiles'
```

## Python

1. Compiling Python, needed by [powerline-status (TMUX)](https://github.com/powerline/powerline)

Note: any different output:
  * If pyenv does not work https://github.com/pyenv/pyenv-doctor
  * If pyenv can't compile python https://github.com/pyenv/pyenv/wiki/common-build-problems

```sh
$ pyenv install 3.8.0
Downloading Python-3.8.0.tar.xz...
-> https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz
Installing Python-3.8.0...
Installed Python-3.8.0 to /root/.pyenv/versions/3.8.0
```

2. Defining python as a global version

```sh
$ pyenv global 3.8.3
```

3. Upgrade the pip version, and install wheel

```sh
$ pip install --upgrade pip

$ pip install wheel
```

## TMUX

1. Install powerline-status with pip

```sh
$ pip install powerline-status
```

2. Execute [powerline-daemon](https://github.com/erikw/tmux-powerline), if zero is returned everything is ok

```sh
$ $PYENV_ROOT/shims/powerline-daemon -q --replace && echo $?
0
```

3. Install TMUX, with [tmux target](https://github.com/ricardoareis/dotfiles/blob/master/Makefile#L71)

```sh
$ cd ~/repos/dotfiles; make tmux
```

## Vim

1. Build Vim with Python support, with [build.sh](https://github.com/ricardoareis/dotfiles/blob/master/bin/build.sh)

```sh
$ cd ~/repos/dotfiles; bin/build.sh vim
```

2. Install Vim plugins, with [vim target](https://github.com/ricardoareis/dotfiles/blob/master/Makefile#L92)

```sh
$ cd ~/repos/dotfiles; make vim
```

3. Install YCM (code-completion engine for Vim), with [build.sh](https://github.com/ricardoareis/dotfiles/blob/master/bin/build.sh)

```sh
$ cd ~/repos/dotfiles; bin/build.sh ycm
```

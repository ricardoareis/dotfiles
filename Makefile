SHELL	:= /bin/bash
.ONESHELL:

REPOS   := $(HOME)/repos/dotfiles
UNAME_S := $(shell uname -s)
LINUX_D := $(shell test -f /etc/issue && cut -d" " -f1 /etc/issue | grep .)
ZSH_LOGIN := --login

define get-zsh-path
ifeq ($(LINUX_D),Ubuntu)
	$(1) := $(which zsh)
endif
ifeq ($(UNAME_S),Darwin)
	$(1) := $(brew --prefix zsh)/bin/zsh
endif
endef

all: install config

install: dotfiles
	@echo ""
	@echo "NOTES:"
	@echo ""
	@echo "	1. Vim should be configured to has a python3 suport"
	@echo "	2. ZSH use zinit as a plugin manager (verify if you have build-essential)"
	@echo ""
	@echo ""

config: zsh_default
	@echo "Configuring dotfiles"

dotfiles: zsh vim tmux
#
# Use zsh target to configure zsh
#
zsh: install_zsh zshrc install_zsh_plugins

install_zsh:
	@echo "Installing ZSH"
ifeq ($(UNAME_S),Darwin)
	brew install zsh
endif

ifeq ($(LINUX_D),Ubuntu)
	apt-get install -y zsh
else
	@echo "Unsuported Operation System"
endif

zshrc:
	@echo "Linking the $(HOME)/.zshrc"
	ln -sf $(REPOS)/.zshrc $(HOME)/.zshrc

zsh_default: zsh_check_default
	@echo "Adopting ZSH as a default shell"
	$(eval $(call get-zsh-path),ZSH_PATH)
	chsh -s $(ZSH_PATH)
.ONESHEL:

#@echo $(eval $(call get-zsh-path))
install_zsh_plugins:
	@echo "Installing ZSH plugins with ZINIT"
	$(eval $(call get-zsh-path,ZSH_PATH))
	bash -c "$(ZSH_PATH) $(ZSH_LOGIN)"
.ONESHEL:

zsh_check_default:
	@echo "Would you like to make the zsh the default shell?"
	@( read -p "Are you sure?!? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
#
# Use tmux target to configure tmux
#
tmux: install_tmux tmux.conf

install_tmux:
	@echo "Installing TMUX"
ifeq ($(UNAME_S),Darwin)
	brew install tmux
endif

ifeq ($(LINUX_D),Ubuntu)
	apt-get update
	apt-get install -y tmux
else
	@echo "Unsuported Operation System"
endif

tmux.conf:
	@echo "Linking the $(HOME)/.tmux.conf"
	ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf
#
# Use vim target to configure vim
#
vim: vimdir vimrc vimrc.bundles vimBundlesInstall

vimdir:
	@echo "Linking $(HOME)/.vim"
	ln -sf $(CURDIR)/.vim $(HOME)/.vim

vimrc:
	@echo "Linking $(HOME)/.vimrc"
	ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc

vimrc.bundles:
	@echo "Linking $(HOME)/.vimrc.bundle"
	ln -sf $(CURDIR)/.vimrc.bundles $(HOME)/.vimrc.bundles

vimBundlesInstall:
	vim +PlugInstall! +q

REPOS   := $(HOME)/repos/dotfiles
UNAME_S := $(shell uname -s)
LINUX_D := $(shell cut -d\  -f1 < /etc/issue | grep .)

# TODO: needed to be a funtion
ifeq ($(UNAME_S),Darwin)
	ZSH_PATH := $(shell brew --prefix zsh)
else ifeq ($(UNAME_S),Linux)
	ZSH_PATH := $(shell which zsh)
endif

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

dotfiles: tmux zsh vim
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
	chsh -s $(ZSH_PATH)

install_zsh_plugins:
	@echo "Installing ZSH plugins with ZINIT"
	sh -c "$(ZSH_PATH) -l"

zsh_check_default:
	@echo "Would you like to make the zsh the default shell?"
	@( read -p "Are you sure?!? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
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

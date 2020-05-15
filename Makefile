UNAME_S := $(shell uname -s)

all: dotfiles

dotfiles: tmux zsh vim
#
# Use tmux target to configure tmux
#
tmux: tmux.conf install_tmux

tmux.conf:
	@echo "ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf"

install_tmux:
ifeq ($(UNAME_S),Darwin)
	@echo "brew install tmux"
else ifeq ($(UNAME_S),Linux)
	@echo "Unsuported Operation System"
endif
#
# Use zsh target to configure zsh
#
zsh: zshrc install_zsh zsh_default

zshrc:
	@echo "ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc"

install_zsh:
ifeq ($(UNAME_S),Darwin)
	@echo "brew install zsh"
else ifeq ($(UNAME_S),Linux)
	@echo "Unsuported Operation System"
endif

zsh_default: zsh_check_default
	@echo "chsh -s $$(brew --prefix zsh)"

zsh_check_default:
	@echo "Would you like to make the zsh the default shell?"
	@( read -p "Are you sure?!? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )
#
# Use vim target to configure vim
#
vim: vimdir vimrc vimrc.bundle vimBundleInstall

vimdir:
	@echo "ln -sf $(CURDIR)/.vim $(HOME)/.vim"

vimrc:
	@echo "ln -sf $(CURDIR)/.vimrc $(HOME)/.vimrc"

vimrc.bundle:
	@echo "ln -sf $(CURDIR)/.vimrc.bundle $(HOME)/.vimrc.bundle"

vimBundleInstall: check_default
	@echo "vim +PlugInstall! +q"

check_default:
	@echo "Would you like to install vim bundles?"
	@( read -p "Are you sure?!? [y/N]: " sure && case "$$sure" in [yY]) true;; *) false;; esac )

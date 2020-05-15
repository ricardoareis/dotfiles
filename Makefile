all: dotfiles

dotfiles: tmux zsh vim
#
# Use tmux target to configure tmux
#
tmux: tmux.conf install_tmux

tmux.conf:
	@echo "ln -sf $(CURDIR)/.tmux.conf $(HOME)/.tmux.conf"

install_tmux:
	@echo "brew install tmux"
#
# Use zsh target to configure zsh
#
zsh: zshrc install_zsh zshdefault

zshrc:
	@echo "ln -sf $(CURDIR)/.zshrc $(HOME)/.zshrc"

install_zsh:
	@echo "brew install zsh"

zshdefault: check_default
	@echo "chsh -s $(which zsh)"

check_default:
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

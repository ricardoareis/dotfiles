export ZSH=$HOME/.oh-my-zsh
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Command history configuration
if [ -z "$HISTFILE"  ]; then
    HISTFILE=$HOME/.zsh_history
fi

alias history='fc -il 1'

HISTSIZE=10000
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Export TERM correctly for tmux
[[ $TERM == "screen" ]] && export TERM=screen-256color
[[ $TERM == "xterm"  ]] && export TERM=xterm-256color

# Locale settings
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# fasd - eval "$(fasd --init posix-alias zsh-hook)"
fasd_cache="$HOME/.fasd-init-bash"

if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache"  ]; then
  fasd --init posix-alias zsh-{hook,ccomp,ccomp-install,wcomp,wcomp-install} >| "$fasd_cache"
fi

source "$fasd_cache"
unset fasd_cache

export PYTHON_CONFIGURE_OPTS="--enable-shared"

if [[ "$(uname)" == "Linux" ]]; then
    alias fd="fdfind"
    export GOROOT=/opt/go
    export PYENV_ROOT="$HOME/.pyenv"
    if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    export PATH="$HOME/.local/bin:$PYENV_ROOT/bin:$PATH"
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
    export GOPATH=$HOME/repos/Go
    export DOCKER_HOST=tcp://0.0.0.0:2375
elif [[ "$(uname)" == "Darwin" ]] ; then
    alias vim=/Users/cabelo/repos/macvim/src/MacVim/build/Release/MacVim.app/Contents/bin/vim
    alias vimdiff=/Users/cabelo/repos/macvim/src/MacVim/build/Release/MacVim.app/Contents/bin/vimdiff
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    alias ctags="/usr/local/bin/ctags"
    export PYENV_ROOT=/usr/local/opt/pyenv
    export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
    export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
    export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/libxml2:$C_INCLUDE_PATH"
    if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    export GOPATH=$HOME/Go 
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
    export PATH=$PATH:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$GOROOT/bin
    export PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
fi

# ssh
alias ssh='TERM=xterm-256color ssh'
alias q='tmux kill-pane'

# Customization 
export ZSH_CUSTOM=$HOME/repos/dotfiles/zsh_custom

# Plugins
plugins=(git golang pip osx sudo docker jsontools zsh-syntax-highlighting zsh-autosuggestions tmux dotenv fzf)

# User configuration
export DISABLE_UPDATE_PROMPT=true
export EDITOR=vim
export VISUAL=vim
export KEYTIMEOUT=1
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

## Powerlevel9k Settings
#[[ -f $HOME/.zsh_powerlevel ]] && source $HOME/.zsh_powerlevel

## TmuxSettings
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=false

#########################################################################################
source $ZSH/oh-my-zsh.sh
echo ""

fortune | cowsay -f vader | lolcat

echo ""

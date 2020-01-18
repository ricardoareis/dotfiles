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

# ssh
alias ssh='TERM=xterm-256color ssh'
alias vim=/Users/cabelo/repos/macvim/src/MacVim/build/Release/MacVim.app/Contents/bin/vim
alias vimdiff=/Users/cabelo/repos/macvim/src/MacVim/build/Release/MacVim.app/Contents/bin/vimdiff

# Functions
# fj - changing directory with fasd
function fj() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
zle -N fj

# v - recent files with fasd
function lv() {
  local file
  zle reset-prompt
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "${file}"
}
zle -N lv

# fs [FUZZY PATTERN] - Select selected tmux session
function fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}
zle -N fs

# Loading Bindings 
[[ -f ~/.zsh_bindings ]] && source ~/.zsh_bindings

# Plugins
plugins=(git golang pip osx sudo docker jsontools zsh-syntax-highlighting zsh-autosuggestions tmux dotenv fzf)

# User configuration
export EDITOR=vim
export VISUAL=vim
export KEYTIMEOUT=1

alias q='tmux kill-pane'
alias updatedb="sudo /usr/libexec/locate.updatedb"
alias ctags="/usr/local/bin/ctags"

export PYENV_ROOT=/usr/local/opt/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export GOPATH=/Users/cabelo/Go 
export GOROOT=/usr/local/opt/go/libexec
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$GOROOT/bin
export PATH=$PYENV_ROOT/bin:$(pyenv root)/shims:$PATH
export DISABLE_UPDATE_PROMPT=true
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/libxml2:$C_INCLUDE_PATH"

## Powerlevel9k Settings
DEFAULT_USER="cabelo"
POWERLEVEL9K_HISTORY_BACKGROUND='green'
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir dir_writable newline vcs go_version pyenv)
POWERLEVEL9K_OS_ICON_BACKGROUND=024 #navyblue
POWERLEVEL9K_OS_ICON_FOREGROUND=202 #orangered1
POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=249 # white
POWERLEVEL9K_DIR_HOME_FOREGROUND=249
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=249
POWERLEVEL9K_DIR_ETC_FOREGROUND=249
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=249
POWERLEVEL9K_DIR_HOME_BACKGROUND=024 #deepskyblue4a
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=024 #deepskyblue4a
POWERLEVEL9K_DIR_ETC_BACKGROUND=024 #deepskyblue4a
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=024 #deepskyblue4a
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_BACKGROUND=017
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=017
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status history)
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=017 # navyblue
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=040 # green3a
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=017 # navyblue
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=220 # gold1
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=236 #grey19
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=160 #red3a
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
ZSH_THEME="powerlevel10k/powerlevel10k"

## TmuxSettings
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=false

#########################################################################################
source $ZSH/oh-my-zsh.sh
echo ""

fortune | cowsay -f vader | lolcat

echo ""

# Path to your oh-my-zsh installation.
export ZSH=/Users/cabelo/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git python aws docker docker-compose brew golang go osx pip pyenv)
plugins=(git python go golang pyenv pip osx sudo docker jsontools git zsh-syntax-highlighting zsh-autosuggestions tmux)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
#else
#   export EDITOR='vim'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vim=/Users/cabelo/repos/macvim/src/MacVim/build/Release/MacVim.app/Contents/bin/vim
alias updatedb=/usr/libexec/locate.updatedb
alias ctags="/usr/local/bin/ctags"
export PYENV_ROOT=/usr/local/opt/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export GOPATH=/Users/cabelo/Go 
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$GOROOT/bin
export PATH="$PYENV_ROOT/bin:$PATH"
export DISABLE_UPDATE_PROMPT=true
#export CPPFLAGS=-I$(brew --prefix openssl)/include
#export LDFLAGS=-L$(brew --prefix openssl)/lib
export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/libxml2:$C_INCLUDE_PATH"
## Powerlevel9k Settings
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"
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
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=249POWERLEVEL9K_DIR_HOME_BACKGROUND=024 #deepskyblue4a
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
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history)
POWERLEVEL9K_VCS_CLEAN_FOREGROUND=017 # navyblue
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=040 # green3a
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=017 # navyblue
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=220 # gold1
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=236 #grey19
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=160 #red3a
POWERLEVEL9K_SHOW_CHANGESET=true
## TmuxSettings
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=false
#########################################################################################
export LC_ALL=en_US.UTF-8
source $ZSH/oh-my-zsh.sh
echo ""

Fortune | cowsay -f vader | lolcat

echo ""

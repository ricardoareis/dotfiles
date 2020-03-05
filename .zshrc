# Basic properties {
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker={,} foldlevel=0 foldmethod=marker spell:

#COMPLETION_WAITING_DOTS="true" # Uncomment the following line to display red dots whilst waiting for completion.

umask 022
# Configure the cache dir
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
ZSH_COMPDUMP="${ZSH_COMPDUMP:-${ZSH_CACHE_DIR}}"

# The instant prompt loaded a precompiled version of zsh
# some times it does not work, breaking the load
# the property below produce the config
POWERLEVEL9K_INSTANT_PROMPT=off

# this if statement load the config
#if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#    source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/

[[ -d "${ZSH_COMPDUMP}" ]] || mkdir -p "${ZSH_COMPDUMP}"

_update_zcomp() {
    setopt local_options
    setopt extendedglob
    autoload -Uz compinit
    local zcompf="$1/zcompdump"
    # use a separate file to determine when to regenerate, as compinit doesn't
    # always need to modify the compdump
    local zcompf_a="${zcompf}.augur"

    if [[ -e "$zcompf_a" && -f "$zcompf_a"(#qN.md-1) ]]; then
        compinit -C -d "$zcompf"
    else
        compinit -d "$zcompf"
        touch "$zcompf_a"
    fi
    # if zcompdump exists (and is non-zero), and is older than the .zwc file,
    # then regenerate
    if [[ -s "$zcompf" && (! -s "${zcompf}.zwc" || "$zcompf" -nt "${zcompf}.zwc") ]]; then
        # since file is mapped, it might be mapped right now (current shells), so
        # rename it then make a new one
        [[ -e "$zcompf.zwc" ]] && mv -f "$zcompf.zwc" "$zcompf.zwc.old"
        # compile it mapped, so multiple shells can share it (total mem reduction)
        # run in background
        zcompile -M "$zcompf" &!
    fi
}

# Command history configuration
HISTFILE=${HISTFILE:-${HOME}/.zsh_history}

HISTSIZE=1000000
HIST_STAMPS="yyyy-mm-dd"
SAVEHIST=500000

#alias history='fc -il 1'

setopt append_history           # append
setopt extended_history         # add timestamp, and more
setopt hist_expire_dups_first
setopt hist_ignore_dups         # ignore duplication command history list
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share command history data between 

setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt auto_cd                  # auto change directory
setopt interactivecomments      # permit a command start w/ "#" like a bash 

zstyle ':completion:*' use-cache on                             # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ${ZSH_CACHE_DIR}              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # ignore case
zstyle ':completion:*' menu select=2                            # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}           # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Pushd
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

# Export TERM correctly for tmux
[[ $TERM == "screen" ]] && export TERM=screen-256color
[[ $TERM == "xterm"  ]] && export TERM=xterm-256color

# Run manpage on Esc+h
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo
bindkey '^[h' run-help  # Esc+h
#}

# Workaround MacOSX / Linux / WSL properties {

if [[ "$(uname)" == "Linux" ]]; then
    export GOROOT=/opt/go
    #export PYENV_ROOT="$HOME/.pyenv"
    #if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    export PATH="$HOME/.local/bin:$PYENV_ROOT/bin:$PATH"
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
    export GOPATH=$HOME/repos/Go
    export DOCKER_HOST=tcp://0.0.0.0:2375
elif [[ "$(uname)" == "Darwin" ]] ; then
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    #alias ctags="/usr/local/bin/ctags"
    #export PYENV_ROOT=/usr/local/opt/pyenv
    export LDFLAGS=-L/usr/local/opt/openssl@1.1/lib
    export CPPFLAGS=-I/usr/local/opt/openssl@1.1/include
    export C_INCLUDE_PATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/usr/include/libxml2:$C_INCLUDE_PATH"
    #if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    export GOPATH=$HOME/Go 
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
    export PATH=$PATH:/usr/local/sbin:/usr/local/opt/go/libexec/bin:$GOPATH/bin:$GOROOT/bin
    export PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
fi
#}

# Plugin: ZINIT a plugin manager {
declare -A ZINIT

ZINIT[HOME_DIR]="${HOME}/repos/dotfiles/.zinit"     # Where Zinit should create all working directories, e.g.: "~/.zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"             # Where Zinit code resides, e.g.: "~/.zinit/bin"
ZINIT[MODULES_DIR]="${ZINIT[BIN_DIR]}/zmodules/Src"
ZINIT[ZCOMPDUMP_PATH]="${ZSH_COMPDUMP}/zcompdump"
ZINIT[COMPINIT_OPTS]="-C"

[[ -d "${ZINIT[HOME_DIR]}/polaris/bin" ]] || mkdir -p "${ZINIT[HOME_DIR]}/polaris/bin"

source ${ZINIT[BIN_DIR]}/zinit.zsh
autoload -Uz _zinit
(( ${+_comps}  )) && _comps[zinit]=_zinit

if [ ! -d ${ZINIT[MODULES_DIR]} ];then
    zinit modules build
fi

module_path+=( ${ZINIT[MODULES_DIR]} )   # When "zinit module build" was executed, 
zmodload zdharma/zplugin                 # these lines load this module, an execute zsh compilation
#} 

# Load all of your custom configurations {

# Load custom functions
fpath=(
    ${ZSH_CUSTOM}/functions.zsh 
    "${fpath[@]}"
)

# Set ZSH_CUSTOM to the path where your custom config files
# and plugins exists, or else we will use the default custom/
ZSH_CUSTOM=${ZSH_CUSTOM:-${HOME}/repos/dotfiles/zsh_custom}
for config_file ($ZSH_CUSTOM/*.zsh(N)); do
    source $config_file
done
unset config_file

# Set ZSH_3PARTY for zsh plugin managed with git submodules
ZSH_3PARTY=${ZSH_3PARTY:-${ZSH_CUSTOM}/3party}
for config_file ($ZSH_3PARTY/**/*.*sh(N)); do
    source $config_file
done
unset config_file

# Remember to only call the compinit at the end of all included files has been loaded
_update_zcomp "${ZSH_COMPDUMP}"
unfunction _update_zcomp
#}

# Fortune with the Cow Vader :P {
#echo ""

#fortune | cowsay -f vader | lolcat

#echo ""
#}

# Basic properties {
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker={,} foldlevel=0 foldmethod=marker spell:
#zmodload zsh/zprof

umask 022

# Configure the cache dir
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
ZSH_COMPDUMP="${ZSH_COMPDUMP:-${ZSH_CACHE_DIR}}"

# The instant prompt loaded a precompiled version of zsh
# some times it does not work, breaking the load.
#
# The property below toggle the file evaluated by if
POWERLEVEL9K_INSTANT_PROMPT=off

# this if, load the p10k instant prompt config
# however, does not work.
#
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    # if zcompdump exists (and is not zero), and is older than the .zwc file,
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

_rationalize-path () {
    # Remove entries that don't exist on this system.  Just for sanity's
    # sake more than anything.
    #http://zsh.sourceforge.net/Contrib/startup/users/debbiep/dot.zshenv
    # Note that this works only on arrays, not colon-delimited strings.
    # Not that this is a problem now that there is typeset -T.
    local element
    local build
    build=()
    # Evil quoting to survive an eval and to make sure that
    # this works even with variables containing IFS characters, if I'm
    # crazy enough to setopt shwordsplit.
    eval '
    foreach element in "$'"$1"'[@]"; do
        if [[ -d "$element" ]]; then
            build=("$build[@]" "$element")
        fi
    done
    '"$1"'=( "$build[@]" )
    '
}

# Command history configuration
HISTFILE=${HISTFILE:-${HOME}/.zsh_history}
HISTSIZE=1000000
SAVEHIST=500000
HIST_STAMPS="yyyy-mm-dd"

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

# PATH && MANPATH properties {
export PYENV_ROOT="$HOME/.pyenv"

# Workaround for WSL Windows
if [[ ! -z "$(command -v explorer.exe)" ]];then
    export DOCKER_HOST=tcp://0.0.0.0:2375
fi

typeset -U PATH path

path=(
    /opt/vim/bin
    "$HOME/.local/bin"
    "$PYENV_ROOT/bin"
    "$PYENV_ROOT/shims"
    /usr/local/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    "$path[@]"
    "$fpath[@]"
)

# Remove entries that don't exist on this system.  Just for sanity's# sake
# more than anything.
_rationalize-path path
export PATH

# MANPATH: path for the man command to search.
# Look at the manpath command's output and prepend
# my own manual paths manually (ahem).
if [[ ${+MANPATH} -eq 1 ]]; then
    # Only do this if the MANPATH variable isn't already set.
    # And, as always, no duplicate entries are needed.
    typeset -U manpath
    if whence manpath >/dev/null 2>&1; then
        # Get the original manpath, then modify it.
        MANPATH="$(manpath 2>/dev/null)"
        manpath=(
            "$HOME/man"
            "$HOME/.local/share/man"
            "$manpath[@]"
        )
    else
        # This list is out of date, but it will suffice.
        manpath=(
            "$HOME/man"
            "$HOME/.local/share/man"
        )
    fi
    _rationalize-path manpath
    unfunction _rationalize-path
    export MANPATH
fi

if [[ "$(uname)" == "Darwin" ]];then
    export CC="clang"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/openssl@1.1/lib"
    export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/openssl@1.1/include"
fi
#}

# Plugin: ZINIT a plugin manager {
declare -A ZINIT

ZINIT[HOME_DIR]="${HOME}/repos/dotfiles/.zinit"     # Where Zinit should create all working directories, e.g.: "~/.zinit"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"             # Where Zinit code resides, e.g.: "~/.zinit/bin"
ZINIT[MODULES_DIR]="${ZINIT[BIN_DIR]}/zmodules/Src"
ZINIT[ZCOMPDUMP_PATH]="${ZSH_COMPDUMP}/zcompdump"
ZINIT[COMPINIT_OPTS]="-C"
ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1

[[ -d "${ZINIT[HOME_DIR]}/polaris/bin" ]] || mkdir -p "${ZINIT[HOME_DIR]}/polaris/bin"

source ${ZINIT[BIN_DIR]}/zinit.zsh
autoload -Uz _zinit
(( ${+_comps}  )) && _comps[zinit]=_zinit

#if [ ! -d ${ZINIT[MODULES_DIR]} ];then
#    zinit module build
#fi

# allowing python-build be reached
path=(
    "${path[@]}"
    ${ZINIT[PLUGINS_DIR]}/pyenv---pyenv/plugins/python-build/bin
)

module_path+=( ${ZINIT[MODULES_DIR]} )   # When "zinit module build" was executed,
zmodload zdharma/zplugin                 # these lines load this module, an execute zsh compilation
#}

# Load all of your custom configurations {
ZSH_CUSTOM_FPATH=${ZSH_CUSTOM_FPATH:-${HOME}/repos/dotfiles/zsh_custom/functions}
typeset -U fpath

fpath=(
    ${ZSH_CUSTOM_FPATH}
    /usr/local/share/zsh/functions
    "${fpath[@]}"
)

export FPATH

# autoload all functions in $FPATH - that is, all files in
# each component of the array $fpath.  If there are none, feed the list
# it prints into /dev/null.
DO_NOT_EXEC="+X"
for paths in "$fpath[@]"; do
    [[ $paths != ${ZSH_CUSTOM_FPATH} ]] && DO_NOT_EXEC=""
    autoload $DO_NOT_EXEC -U "$paths"/*(N:t) >/dev/null
done
unset paths

# ZSH_CUSTOM to the path where your custom config files
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
#zprof
#}

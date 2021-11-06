# Loading without delay {
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker={,} foldlevel=0 foldmethod=marker spell:
zinit ice svn atinit'ZSH_TMUX_AUTOSTART=true\
                     ZSH_TMUX_AUTOSTART_ONCE=true\
                     ZSH_TMUX_AUTOCONNECT=false' lucid compile
zinit snippet OMZ::plugins/tmux

# Load within zshrc – for the instant prompt
zinit ice depth=1 atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd compile
zinit light romkatv/powerlevel10k
#}

# Loading with a min delay (default) {
#
# OMZ things to source
local _ZSHRC_OMZ_LIB_SRCS=(
  # Libs
  git.zsh
  completion.zsh
  functions.zsh
  grep.zsh
  key-bindings.zsh
  spectrum.zsh
  directories.zsh
  theme-and-appearance.zsh
)

zinit ice svn depth"0" wait multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zinit snippet OMZ::lib
#}

# Loading with a 1s delay {
#
zinit ice svn wait"1a" atload"unalias grv" lucid
zinit snippet OMZ::plugins/git

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/aws

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/macos

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/colored-man-pages

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/docker-compose

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/docker-machine

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/dotenv

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/git-auto-fetch

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/golang

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/npm

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/pip

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/sudo

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/jsontools

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/safe-paste

zinit ice wait"1b" lucid as="program" pick="bin/fzf-tmux"
zinit light junegunn/fzf

zinit ice svn wait"1b" lucid
zinit snippet OMZ::plugins/fzf

zinit wait"1b" lucid for \
    atload'source init.zsh'\
    atinit'export FZF_MARKS_JUMP="m"'\
        urbainvaes/fzf-marks
#}

# Loading as a program with a 1s delay {
zinit wait"1c" lucid as=program  for                                                                     \
    atclone="./fasd --init auto > zfasd.zsh"                                                             \
    src="zfasd.zsh"                                                                                      \
        clvv/fasd                                                                                        \
    atclone="./autogen.sh && ./configure --prefix=$PWD"                                                  \
    make="" pick="ctags"                                                                                 \
        universal-ctags/ctags                                                                            \
    atclone="./libexec/pyenv init - > zpyenv.zsh"                                                        \
    atinit='export PYENV_ROOT="$HOME/.pyenv"'                                                            \
    atpull="%atclone" pick='bin/pyenv'                                                                   \
    src="zpyenv.zsh" nocompile='!'                                                                       \
        pyenv/pyenv                                                                                      \
    atclone="mkdir -p $PYENV_ROOT/plugins;                                                               \
            ln -sf ${ZINIT[PLUGINS_DIR]}/pyenv---pyenv-virtualenv $PYENV_ROOT/plugins/pyenv-virtualenv ; \
            pyenv virtualenv-init - > zpvirt.zsh"                                                        \
    atinit='export PYENV_ROOT="$HOME/.pyenv"'                                                            \
    atpull="%atclone" src"zpvirt.zsh" nocompile='!'                                                      \
        pyenv/pyenv-virtualenv                                                                           \
    atclone="./libexec/goenv init - > zgoenv.zsh"                                                        \
    atinit='export GOENV_DISABLE_GOPATH=1
           export GOENV_ROOT="$PWD"
           export PATH="$GOENV_ROOT/bin:$GOENV_ROOT/shims:$PATH"' atpull="%atclone"                      \
    atload='export GOPATH="$HOME/go"
           export GOPATH_BIN="$(go env GOPATH)/bin"
           export PATH="$GOENV_ROOT/bin:$GOENV_ROOT/shims:$PATH"
           export PATH="$GOPATH_BIN:$GOROOT/bin:$PATH"
           [[ -d $GOPATH_BIN ]] || mkdir -p $GOPATH_BIN'                                                 \
    pick='bin/goenv' src="zgoenv.zsh" nocompile='!'                                                      \
        syndbg/goenv

zinit wait"1d" lucid as=program from"gh-r" for                             \
    mv"golangci-lint* -> golangci-list" pick="golangci-list/golangci-lint" \
        @golangci/golangci-lint                                            \
    mv"hadolint* -> hadolint" pick="hadolint/hadolint"                     \
        @hadolint/hadolint                                                 \
    mv"shellcheck* -> shellcheck" pick="shellcheck/shellcheck"             \
        @koalaman/shellcheck                                               \
    mv"shfmt* -> shfmt" pick="shfmt/shfmt"                                 \
        @mvdan/sh                                                          \
    mv"jq* -> jq" pick="jq/jq"                                             \
        @stedolan/jq                                                       \
    mv"bat* -> bat" pick="bat/bat"                                         \
        @sharkdp/bat                                                       \
    mv"ripgrep* -> rg" pick="rg/rg"                                        \
        @BurntSushi/ripgrep                                                \
    mv"fd* -> fd" pick="fd/fd"                                             \
        @sharkdp/fd                                                        \
    mv"delta* -> delta" pick="delta/delta"                                 \
        @dandavison/delta                                                  \
    mv"code-minimap* -> code-minimap" pick="code-minimap/code-minimap"     \
        @wfxr/code-minimap                                                 \
    mv"vale* -> vale" pick="vale/vale"                                     \
        @errata-ai/vale                                                    \
        @errata-ai/Microsoft                                               \
    pick="fzf/fzf" src="$ZSH_CUSTOM/fzf.cfg"                               \
        @junegunn/fzf-bin

zinit wait"1f" lucid as=program for                        \
    pick="fpp" nocompile'!'                                \
    atinit' ln -sf $PWD/fpp $ZPFX/bin'                     \
        facebook/pathpicker                                \
    pick="git-recall"                                      \
        Fakerr/git-recall                                  \
    pick="git-open"                                        \
        paulirish/git-open                                 \
    pick="git-recent"                                      \
        paulirish/git-recent                               \
    pick="git-my"                                          \
        davidosomething/git-my                             \
    pick="git-quick-stats"                                 \
    atload"export _MENU_THEME=legacy"                      \
        arzzen/git-quick-stats                             \
    pick="git-quick-stats ; etc/git-extras-completion.zsh" \
    make"PREFIX=$ZPFX install"                             \
        tj/git-extras
#}

# Loading with a 2s delay {
#
zinit wait"2a" lucid for                     \
    hlissner/zsh-autopair                    \
    voronkovich/gitignore.plugin.zsh         \
    atinit='export forgit_log="gvlo"         \
            export forgit_diff="gvd"         \
            export forgit_add="gva"          \
            export forgit_reset_head="gvrh"  \
            export forgit_ignore="gvi"       \
            export forgit_restore="gvcf"     \
            export forgit_clean="gvclean"    \
            export forgit_stash_show="gvss"' \
        wfxr/forgit
#}

# Loading the completions mandatory at the end {
#

zinit wait"2b" atinit"zpcompinit; zpcdreplay" silent light-mode for     \
    ricardoareis/fast-syntax-highlighting                               \
    scriptingosx/mac-zsh-completions                                    \
    blockf                                                              \
        atpull'zinit creinstall -q .'                                   \
            zsh-users/zsh-completions                                   \
        atload"_zsh_autosuggest_start"                                  \
        atinit="export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10"              \
            zsh-users/zsh-autosuggestions
#}

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
# zinit light zinit-zsh/z-a-as-monitor

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

#zinit ice svn wait"2b" lucid
#zinit snippet OMZ::plugins/aws

zinit ice svn wait"1a" lucid
zinit snippet OMZ::plugins/osx

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

zinit ice wait"1c" lucid as="program" pick="bin/fzf-tmux"
zinit light junegunn/fzf

zinit ice svn wait"1c" lucid
zinit snippet OMZ::plugins/fzf

zinit wait"1c" lucid for \
    atload'source init.zsh'\
    atinit'export FZF_MARKS_JUMP="m"'\
        urbainvaes/fzf-marks
#}

# Loading as a program with a 1s delay {
zinit wait"1c" lucid as=program                 \
    atclone"./fasd --init auto > zfasd.zsh"     \
    src="zfasd.zsh" for                         \
    clvv/fasd

zinit wait"1d" lucid as=program from"gh-r"      \
    atinit='ln -sf $PWD/bat/bat $ZPFX/bin'      \
    mv"bat* -> bat" pick="bat/bat" for          \
    @sharkdp/bat

zinit wait"1d" lucid as=program from"gh-r"      \
    atinit='ln -sf $PWD/fd/fd $ZPFX/bin'        \
    mv"fd* -> fd" pick="fd/fd" for              \
    @sharkdp/fd

zinit wait"1d" lucid as=program from"gh-r"      \
    atinit='ln -sf $PWD/delta/delta $ZPFX/bin'  \
    mv"delta* -> delta" pick="delta/delta" for  \
    @dandavison/delta

zinit wait"1d" lucid as=program from"gh-r"      \
    atinit='ln -sf $PWD/rg/rg $ZPFX/bin'        \
    mv"ripgrep* -> rg" pick="rg/rg" for         \
    @BurntSushi/ripgrep

zinit wait"1d" lucid as=program from"gh-r"      \
    atinit='ln -sf $PWD/fzf $ZPFX/bin'          \
    mv"fzf* -> fzf" pick="fzf/fzf"              \
    src="$ZSH_CUSTOM/fzf.cfg"  for              \
    @junegunn/fzf-bin

zinit wait"1d" lucid as=program                                 \
    atclone="./autogen.sh && ./configure --prefix=$PWD"         \
    make="" pick="ctags" for                                    \
    universal-ctags/ctags

zinit wait"1d" lucid as=program                                 \
    atclone"./libexec/pyenv init - > zpyenv.zsh"                \
    atinit'export PYENV_ROOT="$HOME/.pyenv"'                    \
    atpull"%atclone" pick='bin/pyenv'                           \
    src"zpyenv.zsh" nocompile'!' for                            \
    pyenv/pyenv

zinit wait"1e" lucid as=program                                                                         \
    atclone"mkdir -p $PYENV_ROOT/plugins;                                                               \
            ln -sf ${ZINIT[PLUGINS_DIR]}/pyenv---pyenv-virtualenv $PYENV_ROOT/plugins/pyenv-virtualenv ;\
            pyenv virtualenv-init - > zpvirt.zsh"                                                       \
    atinit'export PYENV_ROOT="$HOME/.pyenv"'                                                            \
    atpull"%atclone" src"zpvirt.zsh" nocompile'!' for                                                   \
    pyenv/pyenv-virtualenv

zinit wait"1d" lucid as=program atclone"./libexec/goenv init - > zgoenv.zsh"    \
    atinit'export GOENV_ROOT="$PWD"
           export PATH="$GOENV_ROOT/bin:$GOENV_ROOT/shims:$PATH"
           export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"' atpull"%atclone"        \
    pick='bin/goenv' src"zgoenv.zsh" nocompile'!' for                           \
    syndbg/goenv

zinit wait"1f" lucid as=program                             \
    pick="fpp" nocompile'!'                                 \
    atinit' ln -sf $PWD/fpp $ZPFX/bin' for                  \
    facebook/pathpicker

zinit wait"1e" lucid as=program pick="git-recall"   for Fakerr/git-recall
zinit wait"1e" lucid as=program pick="git-open"     for paulirish/git-open
zinit wait"1e" lucid as=program pick="git-recent"   for paulirish/git-recent
zinit wait"1e" lucid as=program pick="git-my"       for davidosomething/git-my

zinit wait"1e" lucid as=program pick="git-quick-stats"  \
    atload"export _MENU_THEME=legacy"                   \
    for arzzen/git-quick-stats

zinit wait"1e" lucid as=program pick="git-quick-stats ; etc/git-extras-completion.zsh"  \
    make"PREFIX=$ZPFX install"                          \
    for tj/git-extras
#}

# Loading with a 2s delay {
#
zinit wait"2a" lucid for \
    hlissner/zsh-autopair

zinit ice silent wait"2e"\
    atload"_zsh_autosuggest_start"\
    atinit="export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10"
zinit light zsh-users/zsh-autosuggestions

zinit wait"2" lucid for \
    voronkovich/gitignore.plugin.zsh \
    atinit='export forgit_log="gvlo"\
            export forgit_diff="gvd"\
            export forgit_add="gva"\
            export forgit_reset_head="gvrh"\
            export forgit_ignore="gvi"\
            export forgit_restore="gvcf"\
            export forgit_clean="gvclean"\
            export forgit_stash_show="gvss"'\
    wfxr/forgit
#}

# Loading the completions mandatory at the end {

zinit ice silent wait"2b" as"completion" atload"zicompinit; zicdreplay" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice silent wait"2e" atinit"zpcompinit; zpcdreplay"
zinit light scriptingosx/mac-zsh-completions

zinit ice silent wait"2e" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice silent wait"2e" atload"zicompinit; zicdreplay" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
#}

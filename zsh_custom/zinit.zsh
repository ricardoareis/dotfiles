# Loading without delay {
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker={,} foldlevel=0 foldmethod=marker spell:
zinit ice svn atinit'ZSH_TMUX_AUTOSTART=true\
                     ZSH_TMUX_AUTOSTART_ONCE=true\
                     ZSH_TMUX_AUTOCONNECT=false' lucid compile
zinit snippet OMZ::plugins/tmux

# Load within zshrc – for the instant prompt
zinit ice atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd compile
zinit light romkatv/powerlevel10k
#}

# Loading with a min delay (default) {
# OMZ things to source
local _ZSHRC_OMZ_LIB_SRCS=(
  # Libs
  git.zsh
  completion.zsh
  functions.zsh
  #diagnostics.zsh
  grep.zsh
  key-bindings.zsh
  #misc.zsh
  spectrum.zsh
  #termsupport.zsh
  directories.zsh
  theme-and-appearance.zsh
)

zplugin ice svn depth"0" wait multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::lib
#}

# Loading with a 1s delay {
#
zinit ice svn wait"1a" atload"unalias grv" lucid
zinit snippet OMZ::plugins/git

#zinit ice svn wait"2b" lucid
#zinit snippet OMZ::plugins/aws

#zinit wait"1c" lucid for \
#    atinit'FZFZ_RECENT_DIRS_TOOL="fasd"' \
#        andrewferrier/fzf-z

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

zinit ice svn wait"1c" lucid
zinit snippet OMZ::plugins/fzf

zinit wait"1c" lucid for \
    atload'source init.zsh'\
    atinit'bindkey "m" fzm'\
        urbainvaes/fzf-marks
#}

# Loading as a program with a 1s delay {
zinit wait"1c" lucid as=program \
    atload'!fasd_cache="$HOME/.fasd-init-bash";\
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ];then
        fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"; unset fasd_cache' pick="fasd" for \
        clvv/fasd

zinit wait"1b" lucid as=program \
    atload='export FZF_DEFAULT_COMMAND=""\
            export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --inline-info \
            --bind=\"alt-k:preview-up,alt-p:preview-up\"\
            --bind=\"alt-j:preview-down,alt-n:preview-down\"\
            --bind=\"ctrl-r:toggle-all\"\
            --bind=\"ctrl-s:toggle-sort\"\
            --bind=\"?:toggle-preview\"\
            --bind=\"alt-w:toggle-preview-wrap\"\
            --preview-window=\"right:60%\""\
            export FZF_CTRL_T_COMMAND="fd -H -E .git -t f ."\
            export FZF_CTRL_T_OPTS="--height 80% --preview=\"bat --style=numbers  --color=always {} | head -n50\""\
            export FZF_ALT_C_COMMAND="fd -H -E .git -t d . "\
            export FZF_ALT_C_OPTS="--height 80% --preview \"tree -C {} | head -50\"" \
            export FZF_CTRL_R_OPTS="--preview \"echo {}\" --preview-window down:3:hidden:wrap --bind \"?:toggle-preview\""\
            export FZF_BASE="${ZINIT[HOME_DIR]}/plugins/junegunn---fzf";\
            bindkey "^P" fzf-file-widget; bindkey "p" fzf-cd-widget;\
            ln -sf $PWD/bin/fzf $ZPFX/bin;ln -sf $PWD/bin/fzf-tmux $ZPFX/bin'\
    make="install PREFIX=$ZPFX" pick="bin/fzf*" for \
        junegunn/fzf

zinit wait"1d" lucid as=program from"gh-r" for \
    mv"bat* -> bat" pick="bat/bat" @sharkdp/bat

zinit wait"1d" lucid as=program from"gh-r" for \
    mv"fd* -> fd" pick="fd/fd" @sharkdp/fd

zinit wait"1d" lucid as=program from"gh-r" for \
    mv"delta* -> delta" pick="delta/delta" @dandavison/delta
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
zinit ice silent wait"1" atclone"./libexec/pyenv init - > zpyenv.zsh" \
    atinit'export PYENV_ROOT="$HOME/.pyenv"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

zinit ice silent wait"2b" as"completion" atload"zicompinit; zicdreplay" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice silent wait"2e" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice silent wait"2e" atload"zicompinit; zicdreplay" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions
#}

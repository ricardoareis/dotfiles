# OMZ things to source
local _ZSHRC_OMZ_LIB_SRCS=(
  # Libs
  compfix.zsh
  completion.zsh
  functions.zsh
  diagnostics.zsh
  grep.zsh
  key-bindings.zsh
  misc.zsh
  spectrum.zsh
  termsupport.zsh
)

zplugin ice svn depth"0" wait"0a" multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::lib

# Load within zshrc – for the instant prompt
zinit atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd compile
zinit light romkatv/powerlevel10k

zinit ice svn lucid compile
zinit snippet OMZ::plugins/tmux

zinit ice wait"0a" atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

#zinit ice svn wait"2b" lucid
#zinit snippet OMZ::plugins/aws

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/osx

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/colored-man-pages

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/docker-compose

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/docker-machine

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/dotenv

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/git-auto-fetch

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/golang

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/npm

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/pip

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/sudo

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/jsontools

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/fzf

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/safe-paste

zinit ice wait"" lucid atload"zicompinit; zicdreplay" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice silent wait"2b" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice silent wait"2d" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zplugin ice wait"2e" as"completion" lucid
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit lucid as=program pick="$ZPFX/bin/(fzf|fzf-tmux)"\
    atclone="cp shell/completion.zsh _fzf_completion; \
             cp bin/(fzf|fzf-tmux) $ZPFX/bin" \
    make="PREFIX=$ZPFX install" for \
        junegunn/fzf

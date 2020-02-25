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

zplugin ice svn depth"0" wait multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::lib

zinit ice svn wait atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice svn atinit'ZSH_TMUX_AUTOSTART=true\
                     ZSH_TMUX_AUTOSTART_ONCE=true\
                     ZSH_TMUX_AUTOCONNECT=false' lucid compile
zinit snippet OMZ::plugins/tmux

# Load within zshrc – for the instant prompt
zinit ice atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd compile
zinit light romkatv/powerlevel10k

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

#pick="fasd" atinit"cp fasd $ZPFX/bin"

zinit wait"1a" lucid as=program \
    atload'!fasd_cache="$HOME/.fasd-init-bash";\
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ];then
        fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"; unset fasd_cache' pick="fasd" for \
		clvv/fasd

zinit wait"1b" lucid as=program \
    atload='export FZF_DEFAULT_COMMAND="fd -H -E .git"\
            export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND -t f ."\
            export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -t d ."\
            export FZF_BASE="${ZINIT[HOME_DIR]}/plugins/junegunn---fzf";\
            bindkey "^P" fzf-file-widget; bindkey "p" fzf-cd-widget;\
			ln -sf $PWD/bin/fzf $ZPFX/bin;ln -sf $PWD/bin/fzf-tmux $ZPFX/bin'\
    make="install PREFIX=$ZPFX" pick="bin/fzf*" for \
        junegunn/fzf

#cp bin/fzf* $ZPFX/bin

zinit wait"1b" lucid as=program from"gh-r" for \
    mv"fd* -> fd" pick="fd/fd" @sharkdp/fd

zinit wait"1c" lucid for \
    atinit'FZFZ_RECENT_DIRS_TOOL="fasd"' \
        andrewferrier/fzf-z
	
zinit wait"1c" lucid for \
    hlissner/zsh-autopair \
    atload'source init.zsh'\
    atinit'bindkey "m" fzm'\
		urbainvaes/fzf-marks

zinit ice svn wait"1c" lucid
zinit snippet OMZ::plugins/fzf

zplugin ice silent wait"2e" as"completion" lucid
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice silent wait"2e"\
    atload"_zsh_autosuggest_start"\
    atinit="export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10"
zinit light zsh-users/zsh-autosuggestions

zinit ice silent wait"2e" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice silent wait"2e" atload"zicompinit; zicdreplay" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

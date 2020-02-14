# Load within zshrc – for the instant prompt
zinit atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd
zinit load romkatv/powerlevel10k

zinit ice wait"0a" atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/aws

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/osx

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/bundler

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/colored-man-pages

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/command-not-found

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/composer

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

zinit ice svn wait"0a" lucid
zinit snippet OMZ::plugins/npm

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/tmux

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/pip

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/osx

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/sudo

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/jsontools

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/fzf

zinit ice svn wait"2b" lucid
zinit snippet OMZ::plugins/safe-paste

zinit ice silent wait"2b" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice silent wait"2c" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice silent wait"2d" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

# OMZ things to source
local _ZSHRC_OMZ_LIB_SRCS=(
  # Libs
  compfix.zsh
  completion.zsh
  functions.zsh
  diagnostics.zsh
  grep.zsh
  git.zsh
  key-bindings.zsh
  misc.zsh
  spectrum.zsh
  termsupport.zsh
)

local _ZSHRC_OMZ_PLUGINS_SRCS=(
  # Plugins
  aws/aws.plugin.zsh
  bundler/bundler.plugin.zsh
  colored-man-pages/colored-man-pages.plugin.zsh
  command-not-found/command-not-found.plugin.zsh
  composer/composer.plugin.zsh
  docker-compose/docker-compose.plugin.zsh
  docker-machine/docker-machine.plugin.zsh
  dotenv/dotenv.plugin.zsh
  git-auto-fetch/git-auto-fetch.plugin.zsh
  golang/golang.plugin.zsh
  npm/npm.plugin.zsh
  tmux/tmux.plugin.zsh
  pip/pip.plugin.zsh
  osx/osx.plugin.zsh
  sudo/sudo.plugin.zsh
  jsontools/jsontools.plugin.zsh
  fzf/fzf.plugin.zsh
  safe-paste/safe-paste.plugin.zsh
)

zinit lucid as=program pick="$ZPFX/bin/(fzf|fzf-tmux)"\
    atclone="cp shell/completion.zsh _fzf_completion; \
             cp bin/(fzf|fzf-tmux) $ZPFX/bin" \
    make="PREFIX=$ZPFX install" for \
        junegunn/fzf

zplugin ice svn depth"0" wait"0a" multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::lib

zplugin ice depth"1" wait"0b" multisrc"${_ZSHRC_OMZ_PLUGINS_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::plugins

zplugin ice wait"1" as"completion" lucid
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

#zplugin ice wait"1" lucid
#zplugin light zdharma/history-search-multi-word

#zplugin ice wait"1" lucid
#zplugin light zsh-users/zsh-history-substring-search

#zplugin light romkatv/powerlevel10k

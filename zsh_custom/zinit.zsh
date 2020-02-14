# Two regular plugins loaded without tracking.
#
# Load within zshrc – for the instant prompt
zinit atload'!source $ZSH_CUSTOM/powerlevel.cfg' lucid nocd
zinit load romkatv/powerlevel10k

zinit ice wait atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice silent wait"2" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice silent wait"2" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice silent wait"2" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# OMZ things to source
local _ZSHRC_OMZ_SOURCES=(
  # Libs
  lib/compfix.zsh
  lib/completion.zsh
  lib/functions.zsh
  lib/diagnostics.zsh
  lib/grep.zsh
  lib/git.zsh
  lib/key-bindings.zsh
  lib/misc.zsh
  lib/spectrum.zsh
  lib/termsupport.zsh

  # Plugins
  plugins/aws/aws.plugin.zsh
  plugins/bundler/bundler.plugin.zsh
  plugins/colored-man-pages/colored-man-pages.plugin.zsh
  plugins/command-not-found/command-not-found.plugin.zsh
  plugins/composer/composer.plugin.zsh
  plugins/docker-compose/docker-compose.plugin.zsh
  plugins/docker-machine/docker-machine.plugin.zsh
  plugins/dotenv/dotenv.plugin.zsh
  plugins/git-auto-fetch/git-auto-fetch.plugin.zsh
  plugins/git/git.plugin.zsh
  plugins/golang/golang.plugin.zsh
  plugins/npm/npm.plugin.zsh
  plugins/tmux/tmux.plugin.zsh
  plugins/pip/pip.plugin.zsh
  plugins/osx/osx.plugin.zsh
  plugins/sudo/sudo.plugin.zsh
  plugins/jsontools/jsontools.plugin.zsh
  plugins/fzf/fzf.plugin.zsh
  plugins/safe-paste/safe-paste.plugin.zsh
)

#zplugin ice wait"0" from"gh" pick"lib/git.zsh" nocompletions blockf \
#    atload'!local f; for f in ${_ZSHRC_OMZ_SOURCES}; do source $f; done' \
#    compile"(${(j.|.)_ZSHRC_OMZ_SOURCES})" lucid
#    zplugin light robbyrussell/oh-my-zsh

zplugin ice depth"1" wait"0" multisrc"${_ZSHRC_OMZ_LIB_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::lib

zplugin ice depth"1" wait"0" multisrc"${_ZSHRC_OMZ_PLUGINS_SRCS}" pick"/dev/null" blockf lucid
zplugin snippet OMZ::plugins

zplugin ice wait"1" as"completion" lucid
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker


zplugin ice wait"1" lucid
zplugin light zdharma/history-search-multi-word

zplugin ice wait"1" lucid
zplugin light zsh-users/zsh-history-substring-search

#zplugin light romkatv/powerlevel10k

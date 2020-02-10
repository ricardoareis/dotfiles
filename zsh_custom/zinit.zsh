# Two regular plugins loaded without tracking.
zinit ice silent wait"2" blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice silent wait"2" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice silent wait"2" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

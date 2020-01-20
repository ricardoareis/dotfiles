################################################################################
# Key bindings
################################################################################
FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS "
zle -N fzf-cd-widget
case "$TERM" in
  *xterm*|screen-256color)
    # Ctrl-p: Recent directory with fzf
    bindkey '^p' rdf
    # Ctrl-\: FZF cd
    bindkey '^\' fzf-cd-widget
    # Ctrl-v: Lastest vim file
    bindkey '^v' ltv
  ;;
esac

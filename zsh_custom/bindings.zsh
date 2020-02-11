################################################################################
# Key bindings
################################################################################
FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS "
zle -N fzf-cd-widget
case "$TERM" in
  *xterm*|screen-256color)
    # Ctrl-p: Recent directory with fzf
    bindkey '^p' rdf
    # Ctrl-o: FZF cd
    bindkey '^o' fzf-cd-widget
    # Ctrl-e: Lastest vim file
    bindkey '^b' ltv
  ;;
esac

################################################################################
# Key bindings
################################################################################
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

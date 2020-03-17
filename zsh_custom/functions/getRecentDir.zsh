# Function: recent directory with fasd ##{
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker=##{,##} foldlevel=0 foldmethod=marker spell:
function rdf() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
zle -N rdf
##}

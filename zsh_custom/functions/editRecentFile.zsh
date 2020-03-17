# Function: editRecentFile - recent files with fasd ##{
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker=##{,##} foldlevel=0 foldmethod=marker spell:
editRecentFile() {
    local file
    zle reset-prompt
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && $EDITOR "${file}"
}
zle -N editRecentFile
##}

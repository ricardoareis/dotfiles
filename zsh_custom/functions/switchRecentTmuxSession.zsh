# Function: swithRecentTmuxSession  [FUZZY PATTERN] - Select selected tmux session ##{
# vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=zsh foldmarker=##{,##} foldlevel=0 foldmethod=marker spell:
function switchRecentTmuxSession() {
    local session
    session=$(tmux list-sessions -F "#{session_name}" |\
        fzf --query="$1" --select-1 --exit-0) &&
        tmux switch-client -t "$session"
}
zle -N switchRecentTmuxSession
##}

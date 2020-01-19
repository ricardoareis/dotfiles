# fj - changing directory with fasd
function fj() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
zle -N fj

# v - recent files with fasd
function lv() {
  local file
  zle reset-prompt
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "${file}"
}
zle -N lv

# fs [FUZZY PATTERN] - Select selected tmux session
function fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}
zle -N fs

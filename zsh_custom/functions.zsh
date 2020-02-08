# vim: set expandtab sts=2 ts=2 sw=2 tw=78 ft=zsh norl:
# recent directory with fasd
function rdf() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
zle -N rdf

# lastest vim - recent files with fasd
function ltv() {
  local file
  zle reset-prompt
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "${file}"
}
zle -N ltv

# fs [FUZZY PATTERN] - Select selected tmux session
function fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" |\
    fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}
zle -N fs

function getUniqueFolder() {
  local trunc_path directory test_dir test_dir_length
  local -a matching
  local -a paths
  local cur_path='/'
  paths=(${(s:/:)1})
  for directory in ${paths[@]}; do
    test_dir=''
    for (( i=0; i < ${#directory}; i++ )); do
      test_dir+="${directory:$i:1}"
      matching=("$cur_path"/"$test_dir"*/)
      if [[ ${#matching[@]} -eq 1 ]]; then
        break
      fi
    done
    trunc_path+="$test_dir/"
    cur_path+="$directory/"
  done
  echo "${trunc_path: : -1}"
}

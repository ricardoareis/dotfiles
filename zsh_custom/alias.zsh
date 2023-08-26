alias history="fc -il 1"
alias ssh="TERM=xterm-256color ssh"
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"
alias tq="tmux kill-pane"
[[ "$(uname)" == "Darwin"  ]] && \
    alias updatedb="sudo /usr/libexec/locate.updatedb" && \
    #alias vim="~/repos/vim/src/vim"
    #alias vimdiff="~/repos/vim/src/vim -d"

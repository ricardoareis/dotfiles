#!/bin/zsh -f

if [[ -f $HOME/repos/dotfiles/zsh_custom/functions/getTruncatedPath ]];then
    . $HOME/repos/dotfiles/zsh_custom/functions/getTruncatedPath

    delim_unicode="\u2026"
    local delim=$(echo -n $delim_unicode)
    getTruncatedPath $1 1 $delim "middle"
fi

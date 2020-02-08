#!/bin/zsh
if [ -f  $HOME/repos/dotfiles/zsh_custom/functions.zsh ];then
    . $HOME/repos/dotfiles/zsh_custom/functions.zsh
    current_path=$@
    current_path=${current_path/#$HOME/"~"}
    POWERLEVEL9K_SHORTEN_DELIMITER="\u2026"
    local delim=$(echo -n $POWERLEVEL9K_SHORTEN_DELIMITER)
    echo $(truncatePath $current_path 1 $delim "middle")  
fi

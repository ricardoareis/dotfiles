#!/bin/zsh
if [ -f  $HOME/repos/dotfiles/zsh_custom/functions.zsh ];then
    . $HOME/repos/dotfiles/zsh_custom/functions.zsh
    echo "${$(getUniqueFolder $@)/h\/m/"~"}"
fi

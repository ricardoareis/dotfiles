augroup vimhooks
  autocmd!
  " Automatically reload vimrc when it's saved
  autocmd BufWritePost .vimrc source ~/repos/dotfiles/.vimrc.local

  " Automatically rebuild custom dictionary binaries when saving the text versions
  autocmd BufWritePost .vim/spell/*.add silent! :mkspell! %
augroup END


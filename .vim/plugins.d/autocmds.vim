set nocompatible            " this may already be in your .vimrc
filetype plugin indent on   " ...and this too

augroup vimhooks
  autocmd!
  " Automatically reload vimrc when it's saved
  autocmd BufWritePost .vimrc source ~/repos/dotfiles/.vimrc.local

  " Automatically rebuild custom dictionary binaries when saving the text versions
  autocmd BufWritePost .vim/spell/*.add silent! :mkspell! %

augroup END

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END

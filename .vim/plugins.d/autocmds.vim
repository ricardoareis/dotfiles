set nocompatible            " this may already be in your .vimrc
filetype plugin indent on   " ...and this too

augroup vimhooks
    autocmd!

    " Automatically reload vimrc when it's saved
    autocmd BufWritePost .vimrc source ~/repos/dotfiles/.vimrc.local

    " Automatically rebuild custom dictionary binaries when saving the text versions
    autocmd BufWritePost .vim/spell/*.add silent! :mkspell! %

    " Discovery empty filetype
    autocmd BufWritePost * if empty(&filetype) | filetype detect | endif

    " Orig files are readonly
    autocmd BufRead *.orig set readonly

    " Disable spell for some files
    autocmd FileType man,startify setlocal nospell

    " Set execution permission for shell scripts
    autocmd BufWritePost *.sh call system('chmod +x ' . expand('%:p'))

    " Disable Buffer when entering in a buffer
    autocmd BufEnter * nohlsearch

    " Enable cursorline when insert mode is disable
    autocmd InsertLeave,WinEnter * set cursorline

    " Disable cursorline when insert mode is enable
    autocmd InsertEnter,WinLeave * set nocursorline

    " Force a filetype
    autocmd BufNewFile,BufRead *.html.twig  set filetype=html.twig
    autocmd BufNewFile,BufRead *.coffee     set filetype=coffee

    " Formating base on FileType
    autocmd FileType  haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s

    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

    " Wrap line
    autocmd VimResized * | set columns=120

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Relative Numbers on/off when a different events occurred
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

augroup END

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END

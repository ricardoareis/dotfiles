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

    " Golang Menu && Maps
    autocmd Filetype go let g:which_key_localleader_map.g = { 'name' : '+Golang' }
    "
    autocmd Filetype go nmap <LocalLeader>gs <Plug>(go-implements)
    autocmd Filetype go let g:which_key_localleader_map.g.s = 'Go-Implements'
    "
    autocmd FileType go nmap <LocalLeader>gi <Plug>(go-info)
    autocmd Filetype go let g:which_key_localleader_map.g.i = 'Go-Info'
    "
    autocmd FileType go nmap <LocalLeader>ge <Plug>(go-rename)
    autocmd Filetype go let g:which_key_localleader_map.g.e = 'Go-Rename'
    "
    autocmd FileType go nmap <LocalLeader>gr <Plug>(go-run)
    autocmd Filetype go let g:which_key_localleader_map.g.r = 'Go-Run'
    "
    autocmd FileType go nmap <LocalLeader>gb <Plug>(go-build)
    autocmd Filetype go let g:which_key_localleader_map.g.b = 'Go-Build'
    "
    autocmd FileType go nmap <LocalLeader>gt <Plug>(go-test)
    autocmd Filetype go let g:which_key_localleader_map.g.t = 'Go-Test'
    "
    autocmd FileType go nmap <LocalLeader>gd <Plug>(go-doc)
    autocmd Filetype go let g:which_key_localleader_map.g.d = 'Go-Doc'
    "
    autocmd FileType go nmap <LocalLeader>gv <Plug>(go-doc-vertical)
    autocmd Filetype go let g:which_key_localleader_map.g.v = 'Go-Doc-Vertical'
    "
    autocmd FileType go nmap <LocalLeader>gc <Plug>(go-coverage)
    autocmd Filetype go let g:which_key_localleader_map.g.c = 'Go-Coverage'

    " Python Menu && Maps
    autocmd Filetype python let g:which_key_localleader_map.p = { 'name' : '+Python' }
    autocmd Filetype python nnoremap <silent> <LocalLeader>pw  :SendCurrentLine<CR>
    autocmd Filetype python vnoremap <silent> <LocalLeader>pw  :SendLineToREPL<CR>
    autocmd Filetype python nnoremap <silent> <LocalLeader>pr  :REPLToggle<CR>
    autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<CR>
    autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<CR>
    autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<CR>

augroup END

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END

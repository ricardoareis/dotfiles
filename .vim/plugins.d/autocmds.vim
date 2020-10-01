set nocompatible            " this may already be in your .vimrc
filetype plugin indent on   " ...and this too

" file is large from 5mb
let g:LargeFile = 1024 * 1024 * 5

function! LargeFile()
    " no syntax highlight
    setlocal syntax=OFF
    " no syntax highlighting etc
    "set eventignore+=FileType
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
    " display message
    autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see autocmds.vim for details)."
endfunction

augroup vimhooks
    autocmd!

    " Disable Syntax Highlight when the file size is greater than 5MB
    "autocmd Filetype xml  if getfsize(@%) > 5000000 | setlocal syntax=OFF | endif
    "autocmd Filetype json if getfsize(@%) > 5000000 | setlocal syntax=OFF | endif
    autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif

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
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

    " Relative Numbers on/off when a different events occurred
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

    " Golang Menu && Maps
    autocmd Filetype go let g:which_key_localleader_map.g = { 'name' : '+Golang' }
    "
    " Golang Fold properties
    autocmd Filetype go set foldmethod=syntax
    autocmd Filetype go set foldlevel=9
    "
    " Golang Format
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    "
    " ALE properties
    autocmd Filetype go nnoremap <LocalLeader><LocalLeader>q :cclose<CR>
    autocmd Filetype go map <LocalLeader><LocalLeader>n :cnext<CR>
    autocmd Filetype go map <LocalLeader><LocalLeader>m :cprevious<CR>
    "
    " Vim-GO properties
    autocmd Filetype go nnoremap <LocalLeader><LocalLeader>v :vsp <CR>:exe "GoDef" <CR>
    autocmd Filetype go nnoremap <LocalLeader><LocalLeader>s :sp <CR>:exe "GoDef"<CR>
    autocmd Filetype go nnoremap <LocalLeader><LocalLeader>t :tab split <CR>:exe "GoDef"<CR>
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

    " Python Fold properties
    autocmd Filetype python set foldmethod=indent
    autocmd Filetype python set foldlevel=9

    " Quickfix preview
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

augroup END

augroup textobj_sentence
  autocmd!
  autocmd FileType markdown call textobj#sentence#init()
  autocmd FileType textile call textobj#sentence#init()
augroup END

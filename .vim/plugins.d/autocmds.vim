filetype plugin indent on

" file is large from 5mb
let g:LargeFile = 1024 * 1024 * 5

function! LargeFile()
    " no syntax highlight
    setlocal syntax=OFF
    " no syntax highlighting etc
    " set eventignore+=FileType
    " save memory when other file is viewed
    setlocal bufhidden=unload
    " is read-only (write with :w new_filename)
    setlocal buftype=nowrite
    " no undo possible
    setlocal undolevels=-1
    " display message
    augroup _LargeFile
        autocmd!
        autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see autocmds.vim for details)."
    augroup END
endfunction

augroup perf_group
    autocmd!
    " Disable Syntax Highlight when the file size is greater than 5MB
    autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

augroup speel_cmds_group
    autocmd!
    " Automatically rebuild custom dictionary binaries when saving the text versions
    autocmd BufWritePost .vim/spell/*.add silent! :mkspell! %
    " Disable spell for some files
    autocmd FileType man,startify setlocal nospell
    " Spell-check Markdown, Git files
    autocmd FileType markdown,gitcommit setlocal spell
augroup END

augroup format_cmds_group
    autocmd!
    " Formating base on FileType
    autocmd FileType  haskell,puppet,ruby,yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    " Yaml properties
    autocmd Filetype yaml set foldlevel=9
    " Golang Format
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

augroup filetype_cmds_group
    autocmd!
    " Discovery empty filetype
    autocmd BufWritePost * if empty(&filetype) | filetype detect | endif
    " Force a filetype
    autocmd BufNewFile,BufRead *.html.twig  set filetype=html.twig
    autocmd BufNewFile,BufRead *.coffee     set filetype=coffee
augroup END

" Quickfix preview
augroup qf_cmds_group
    autocmd!
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
augroup END

" Relative Numbers on/off when a different events occurred
augroup numbers_cmds_group
    autocmd!
    let ignore_ft = ['minimap', 'startify']
    autocmd BufEnter,FocusGained,InsertLeave * if index(ignore_ft, &ft) < 0 | set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * if index(ignore_ft, &ft) < 0 | set norelativenumber
augroup END

" Enable omni completion.
augroup omnifunc_cmds_group
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=python3complete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

augroup python_cmds_group
    autocmd!
    " Python Menu && Maps
    autocmd Filetype python let g:which_key_localleader_map.p = { 'name' : '+Python' }
    autocmd Filetype python nnoremap <silent> <LocalLeader>ps  :REPLSendSession<CR>
    autocmd Filetype python nnoremap <silent> <LocalLeader>pw  :SendCurrentLine<CR>
    autocmd Filetype python vnoremap <silent> <LocalLeader>pw  :SendLineToREPL<CR>
    autocmd Filetype python nnoremap <silent> <LocalLeader>pr  :REPLToggle<CR>
    autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<CR>
    autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<CR>
    autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<CR>
    " Python Fold properties
    autocmd Filetype python set foldmethod=indent
    autocmd Filetype python set foldlevel=9
augroup END

augroup golang_cmds_group
    autocmd!
    " Golang Menu && Maps
    autocmd Filetype go let g:which_key_localleader_map.g = { 'name' : '+Golang' }
    " Golang Fold properties
    autocmd Filetype go set foldmethod=syntax
    autocmd Filetype go set foldlevel=9
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
    "
    autocmd FileType go nmap <Leader><Leader>x :GoFmt<CR>
    autocmd Filetype go let g:which_key_leader_map[','].x = 'Go-Fmt'
    "
    autocmd FileType go nmap <LocalLeader>grt <Plug>(go-run-tab)
    autocmd Filetype go let g:which_key_localleader_map.g.rt = 'Go-Run-Tab'
    "
    autocmd FileType go nmap <LocalLeader>grv <Plug>(go-run-vertical)
    autocmd Filetype go let g:which_key_localleader_map.g.rv = 'Go-Run-Vertical'
    "
    autocmd FileType go nmap <LocalLeader>gat :GoAddTags<CR>
    autocmd Filetype go let g:which_key_localleader_map.g.at = 'Go-Add-Tags'
    "
    autocmd FileType go nmap <LocalLeader>gds :GoDecls<CR>
    autocmd Filetype go let g:which_key_localleader_map.g.ds = 'Go-Decls'
    "
    autocmd FileType go nmap <LocalLeader>gdd :GoDeclsDir<CR>
    autocmd Filetype go let g:which_key_localleader_map.g.dd = 'Go-DeclsDir'
augroup END

augroup textobj_quote
    autocmd!
    autocmd FileType markdown call textobj#quote#init()
    autocmd FileType textile call textobj#quote#init()
augroup END

augroup textobj_sentence
    autocmd!
    autocmd FileType markdown call textobj#sentence#init()
    autocmd FileType textile call textobj#sentence#init()
augroup END

augroup vimhooks
    autocmd!
    " Orig files are readonly
    autocmd BufRead *.orig set readonly
    " Set execution permission for shell scripts
    autocmd BufWritePost *.sh call system('chmod +x ' . expand('%:p'))
    " Disable Highlighting when entering in a buffer
    autocmd BufEnter * nohlsearch
    " Enable cursorline when insert mode is disable
    " autocmd InsertLeave,WinEnter * set cursorline
    " Disable cursorline when insert mode is enable
    autocmd InsertEnter,WinLeave * set nocursorline
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Wrap line
    autocmd VimResized * | set columns=120
    " Minimap
    autocmd FileType minimap let g:better_whitespace_enabled=0
augroup END

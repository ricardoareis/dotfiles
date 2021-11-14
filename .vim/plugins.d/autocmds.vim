filetype plugin indent on

" File is large from 5mb
let g:LargeFile = 1024 * 1024 * 5

function! LargeFile()
    setlocal syntax=OFF       " no syntax highlight
    setlocal bufhidden=unload " save memory when other file is viewed
    setlocal buftype=nowrite  " is read-only (write with :w new_filename)
    setlocal undolevels=-1    " no undo possible
    augroup _LargeFile        " display message
        autocmd!
        autocmd VimEnter *  echo "The file is larger than "
                    \. (g:LargeFile / 1024 / 1024)
                    \. " MB, so some options are changed (see autocmds.vim for details)."
    augroup END
endfunction

augroup perf_group

    autocmd!
    " Disable Syntax Highlight when the file size is greater than 5MB
    autocmd BufReadPre * let f=getfsize(expand("<afile>"))
                \| if f > g:LargeFile || f == -2 | call LargeFile() | endif
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
    autocmd FileType haskell,puppet,ruby,yml
                \setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    " Yaml properties
    autocmd Filetype yaml set foldlevel=9
augroup END

augroup filetype_cmds_group
    autocmd!
    " Discovery empty filetype
    autocmd BufWritePost * if empty(&filetype) | filetype detect | endif
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

" Disable IndentGuides by FileType
augroup disable_indent_guides
    autocmd!
    autocmd FileType minimap,startify :IndentGuidesDisable
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

augroup textobj_quote
    autocmd!
    autocmd FileType textile,markdown call textobj#quote#init()
augroup END

augroup textobj_sentence
    autocmd!
    autocmd FileType textile,markdown call textobj#sentence#init()
augroup END

augroup vimhooks
    autocmd!
    autocmd BufRead *.orig set readonly                                   " Orig files are readonly
    autocmd BufWritePost *.sh call system('chmod +x ' . expand('%:p'))    " Set execution permission for shell scripts
    autocmd BufEnter * nohlsearch                                         " Disable Highlighting when entering in a buffer
    autocmd InsertEnter,WinLeave * set nocursorline                       " Disable cursorline when insert mode is enable
    autocmd FileType haskell setlocal commentstring=--\ %s                " Workaround vim-commentary for Haskell
    autocmd FileType minimap let g:better_whitespace_enabled=0            " Minimap
    autocmd TerminalOpen * if &buftype == "terminal" | :DisableWhitespace " Terminal
augroup END

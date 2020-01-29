" vim: set expandtab sts=2 ts=2 sw=2 tw=78 ft=vim norl:

" Linter only in a write moment
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" keep the sign gutter open
let g:ale_sign_column_always = 1

" Set this in your vimrc file to disabling highlighting
let g:ale_set_highlights = 0

set foldmethod=indent
set foldlevel=9

" Lint Python files
let b:ale_linters = ['flake8', 'pylint', 'mypy', 'bandit']

" Fix Python files
let b:ale_fixers = [
            \'autoflake', 'black', 'trim_whitespace',
            \'reorder-python-imports' ,
            \'add_blank_lines_for_python_control_statements'
            \]

" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
let b:ale_python_autoflake_options = '--remove-unused-variables --remove-all-unused-imports --ignore-init-module-imports'

" Using black as a gq default vim formatter (:h formatprg)
setlocal formatprg=black\ -S\ --quiet\ -\ 2>/dev/null

" Python Menu && Maps
let g:which_key_localleader_map.p = { 'name' : '+Python' }
nnoremap <silent> <LocalLeader>ps  :REPLSendSession<CR>
nnoremap <silent> <LocalLeader>pw  :SendCurrentLine<CR>
vnoremap <silent> <LocalLeader>pw  :SendLineToREPL<CR>
nnoremap <silent> <LocalLeader>pr  :REPLToggle<CR>
nnoremap <F10> <Esc>:REPLPDBN<CR>
nnoremap <F11> <Esc>:REPLPDBS<CR>
nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<CR>

setlocal omnifunc=python3complete#Complete

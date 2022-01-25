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

" Using a pythonhelper cmd for keywordprg
" reference https://www.reddit.com/r/vim/comments/s4s3f7/some_keywordprg_snippets/
setl keywordprg=:PythonHelper

command! -narg=+ PythonHelper term ++close ++shell
  \ python -m pydoc <q-args>

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

let g:which_key_left_square_bracket_map['['] = 'PrevPythonClass'
let g:which_key_left_square_bracket_map[']'] = 'PrevEndPythonClass'
let g:which_key_left_square_bracket_map['m'] = 'PrevPythonFunction'
let g:which_key_left_square_bracket_map['M'] = 'PrevEndPythonFunction'

let g:which_key_right_square_bracket_map['['] = 'NextEndPythonClass'
let g:which_key_right_square_bracket_map[']'] = 'NextPythonClass'
let g:which_key_right_square_bracket_map['m'] = 'NextPythonFunction'
let g:which_key_right_square_bracket_map['M'] = 'NextEndPythonFunction'

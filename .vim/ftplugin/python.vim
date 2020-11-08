" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['black', 'trim_whitespace', 'reorder-python-imports' ,'add_blank_lines_for_python_control_statements']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0
" Using black as a gq default vim formatter (:h formatprg)
setlocal formatprg=black\ --quiet\ -
augroup black-fmt
    autocmd!
    autocmd BufWritePre <buffer> keepjumps normal m'gggqG``
augroup END

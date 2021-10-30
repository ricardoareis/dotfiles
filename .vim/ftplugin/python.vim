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
setlocal formatprg=black\ --quiet\ -\ 2>/dev/null
" augroup black-fmt
    " autocmd!
    " autocmd BufWritePre <buffer> keepjumps normal m'gggqG``
" augroup END

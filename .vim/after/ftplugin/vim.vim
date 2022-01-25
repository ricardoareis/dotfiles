" Check Python files with flake8 and pylint.
let b:ale_linters = ['vint']
" Disable warnings about trailing whitespace
let b:ale_warn_about_trailing_whitespace = 0

" reference https://www.reddit.com/r/vim/comments/s4s3f7/some_keywordprg_snippets/
setl keywordprg=:botright\ vertical\ help

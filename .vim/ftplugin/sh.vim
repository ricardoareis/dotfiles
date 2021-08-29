let g:ale_linters = {
            \'sh':   ['language_server' ,'shellcheck'],
            \'bash': ['language_server' ,'shellcheck']
            \}
let b:ale_fixers = ['shfmt']
let b:ale_warn_about_trailing_whitespace = 0

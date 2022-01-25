let g:ale_linters = {
            \'sh':   ['language_server' ,'shellcheck'],
            \'bash': ['language_server' ,'shellcheck']
            \}

let b:ale_fixers = ['shfmt']
let b:ale_warn_about_trailing_whitespace = 0

" reference https://www.reddit.com/r/vim/comments/s4s3f7/some_keywordprg_snippets/
setl keywordprg=:ShellHelp
command! -narg=+ ShellHelp term ++close ++shell
  \ [[ "$(type <q-args>)" =~ .*(keyword|builtin)$ ]]
  \ && help <q-args> | less
  \ || man <q-args>

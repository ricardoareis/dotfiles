let g:ale_linters = {'go': ['golangci-lint']}
let g:ale_go_golangci_lint_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
let g:ale_go_golangci_lint_package = 1

set foldmethod=syntax
set foldlevel=9

nnoremap <LocalLeader><LocalLeader>v :vsp <CR>:exe "GoDef" <CR>
nnoremap <LocalLeader><LocalLeader>s :sp <CR>:exe "GoDef"<CR>
nnoremap <LocalLeader><LocalLeader>t :tab split <CR>:exe "GoDef"<CR>

 " Golang Menu && Maps
let g:which_key_localleader_map.g = { 'name' : '+Golang' }
nmap <LocalLeader>gi <Plug>(go-implements)
let g:which_key_localleader_map.g.i = 'Go-Implements'
nmap <LocalLeader>gI <Plug>(go-info)
let g:which_key_localleader_map.g.I = 'Go-Info'
nmap <LocalLeader>gr <Plug>(go-rename)
let g:which_key_localleader_map.g.r = 'Go-Rename'
nmap <LocalLeader>gR <Plug>(go-run)
let g:which_key_localleader_map.g.R = 'Go-Run'
nmap <LocalLeader>gb <Plug>(go-build)
let g:which_key_localleader_map.g.b = 'Go-Build'
nmap <LocalLeader>gt <Plug>(go-test)
let g:which_key_localleader_map.g.t = 'Go-Test'
nmap <LocalLeader>gd <Plug>(go-doc)
let g:which_key_localleader_map.g.d = 'Go-Doc'
nmap <LocalLeader>gv <Plug>(go-doc-vertical)
let g:which_key_localleader_map.g.v = 'Go-Doc-Vertical'
nmap <LocalLeader>gc <Plug>(go-coverage)
let g:which_key_localleader_map.g.c = 'Go-Coverage'
nmap <Leader><Leader>x :GoFmt<CR>
let g:which_key_leader_map[','].x = 'Go-Fmt'
nmap <LocalLeader>gT <Plug>(go-run-tab)
let g:which_key_localleader_map.g.T = 'Go-Run-Tab'
nmap <LocalLeader>gV <Plug>(go-run-vertical)
let g:which_key_localleader_map.g.V = 'Go-Run-Vertical'
nmap <LocalLeader>ga :GoAddTags<CR>
let g:which_key_localleader_map.g.a = 'Go-Add-Tags'
nmap <LocalLeader>gd :GoDecls<CR>
let g:which_key_localleader_map.g.d = 'Go-Decls'
nmap <LocalLeader>gD :GoDeclsDir<CR>
let g:which_key_localleader_map.g.D = 'Go-DeclsDir'

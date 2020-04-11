" Plugin: EasyMotion properties {
" vim: set expandtab sw=4 ts=4 sts=4 et tw=78 ft=vim foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" Changed default prefix
map  <Leader><Leader>  <Plug>(easymotion-prefix)
" <Leader>f(char) to move to (char)
map  <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>w <Plug>(easymotion-overwin-w)

" s(char)(char) to move to (char)(char)
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader><Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader><Leader>L <Plug>(easymotion-overwin-line)
"}

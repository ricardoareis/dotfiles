" vim: set expandtab sts=2 ts=2 sw=2 tw=78 ft=vim norl:
"
" VimWichKey properties
" By default timeoutlen is 1000 ms
set timeoutlen=500
let g:maplocalleader=','
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

"Define prefix dictionary
call which_key#register(',', "g:which_key_map")
let g:which_key_map =  {}

let g:which_key_map['t'] = {
  \ 'name': '+tab'   ,
  \ '1' : ['1gt'     , 'tab-1'],
  \ '2' : ['2gt'     , 'tab-2'],
  \ '3' : ['3gt'     , 'tab-3'],
  \ '4' : ['4gt'     , 'tab-4'],
  \ '5' : ['5gt'     , 'tab-5'],
  \ '6' : ['6gt'     , 'tab-6'],
  \ '7' : ['7gt'     , 'tab-7'],
  \ '8' : ['8gt'     , 'tab-8'],
  \ '9' : ['9gt'     , 'tab-9'],
  \ 'c' : ['tabclose', 'close-current-tab'],
  \ }

let g:which_key_map['f'] = {
  \ 'name' : '+find/files/fold'             ,
  \ '0' : '0-fold-level'                    ,
  \ '1' : '1-fold-level'                    ,
  \ '2' : '2-fold-level'                    ,
  \ '3' : '3-fold-level'                    ,
  \ '4' : '4-fold-level'                    ,
  \ '5' : '5-fold-level'                    ,
  \ '6' : '6-fold-level'                    ,
  \ '7' : '7-fold-level'                    ,
  \ '8' : '8-fold-level'                    ,
  \ '9' : '9-fold-level'                    ,
  \ 'd' : 'find-current-buffer-in-NERDTree' ,
  \ 'f' : 'files-in-home-direcotry'         ,
  \ 's' : 'save-file'                       ,
  \ 't' : 'toggle-NERDTree'                 ,
  \ '?' : 'files-in-current-direcotry'      ,
  \ 'R' : 'reload-vimrc'                    ,
  \ }

let g:which_key_map['g'] = {
  \ 'name' : '+git/version-control' ,
  \ 'b' : ['Gblame'                 , 'fugitive-blame']             ,
  \ 'c' : ['BCommits'               , 'commits-for-current-buffer'] ,
  \ 'C' : ['Gcommit'                , 'fugitive-commit']            ,
  \ 'd' : ['Gdiff'                  , 'fugitive-diff']              ,
  \ 'e' : ['Gedit'                  , 'fugitive-edit']              ,
  \ 'h' : {
    \ 'name': '+hunk'                                               ,
    \ 's' : ['GitGutterStageHunk'   , 'StageHunk']                  ,
    \ 'u' : ['GitGutterUndoHunk'    , 'UndoHunk'] ,
    \ }                                                             ,
  \ 'l' : ['Glog'                   , 'fugitive-log']               ,
  \ 'r' : ['Gread'                  , 'fugitive-read']              ,
  \ 's' : ['Gstatus'                , 'fugitive-status']            ,
  \ 'w' : ['Gwrite'                 , 'fugitive-write']             ,
  \ 'p' : ['Git push'               , 'fugitive-push']              ,
  \ 'y' : ['Goyo'                   , 'goyo-mode']                  ,
  \ }


let g:which_key_map['s'] = {
  \ 'name' : '+search/show'                        ,
  \ 'c' : 'search-clear-highlight'                 ,
  \ 'h' : ['spacevim#util#SyntaxHiGroup()'         , 'show-highlight-group']              ,
  \ 'b' : ['spacevim#map#manager#BLines()'         , 'search-in-buffer']                  ,
  \ 'B' : ['spacevim#map#manager#BufCword()'       , 'search-cword-in-buffer']            ,
  \ 'r' : ['spacevim#map#manager#SearchRecently()' , 'search-recently-buffers-and-files'] ,
  \ }

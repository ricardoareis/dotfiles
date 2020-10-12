" Debug highlight with SyntaxQuery
function! s:syntax_query() abort
  for id in synstack(line('.'), col('.'))
    echo synIDattr(id, 'name')
  endfor
endfunction
command! SyntaxQuery call s:syntax_query()
nnoremap <silent><unique> <Leader>sq :SyntaxQuery<CR>
let g:which_key_leader_map.s.q = 'VimSyntaxQuery'

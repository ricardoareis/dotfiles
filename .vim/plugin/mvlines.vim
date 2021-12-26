" Map to move lines to bellow than current line
"
"TODO: Refactoring to suporte more than
"2 chars, in a relative line number
"by Reis
function! MvLines()
    " This function receive 2 chars
    " that representing the relative line number
    " Ex. command mv +9 will mv the line 9 to the
    " current cursorline.
    let l:number = 2
    let l:string = ''
    while l:number > 0
        let l:string .= nr2char(getchar())
        let l:number -= 1
    endwhile
    return l:string . 'm.'
endfunction
"
nnoremap mv :<C-u>execute MvLines()<CR>

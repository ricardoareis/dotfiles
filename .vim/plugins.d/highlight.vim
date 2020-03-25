" vim: set expandtab sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker={,} foldlevel=0 foldmethod=marker nospell:

" Remove all hiing
hi clear Constant
"hi clear Number
hi clear Statement
"hi clear PreProc
"hi clear Type
hi clear Special
"hi clear Identifier
"hi clear String
hi clear Comment
hi clear Error
hi clear LineNr
"hi clear NonText
hi clear SpecialKey
hi clear SpellBad
hi clear Search

" Set up some simple non-intrusive colors
if &background == "light"
    "   hi String         term=underline  cterm=NONE ctermfg=DarkGreen
    "   hi Comment        term=bold       cterm=NONE ctermfg=DarkBlue
    "   hi SpecialComment                            ctermfg=DarkCyan
    "   hi Error          term=reverse    cterm=NONE ctermfg=DarkRed
    "   hi LineNr         term=bold       cterm=NONE ctermfg=DarkYellow
    "   hi NonText        term=bold       cterm=NONE ctermfg=DarkYellow
    "   hi SpecialKey     term=bold       cterm=NONE ctermfg=DarkYellow
else
    "   hi String         term=underline  cterm=bold,underline    "ctermfg=DarkGreen
    hi Comment        term=NONE         cterm=NONE      ctermfg=DarkGray
    hi SpecialComment                   cterm=NONE      ctermfg=DarkCyan
    hi Error          term=bold         cterm=underline ctermfg=Red
    hi LineNr         term=bold         cterm=NONE      ctermfg=DarkGray
    "hi NonText       term=bold         cterm=NONE      ctermfg=Yellow
    hi SpecialKey     term=bold         cterm=NONE      ctermfg=Yellow
    hi SpellBad       term=NONE         cterm=underline ctermfg=NONE
endif

"hi Number       cterm=underline
hi Constant     ctermfg=Brown
hi Special      ctermfg=Red
"hi Identifier  ctermfg=6
"hi Statement   cterm=bold              ctermfg=Red
"hi PreProc     cterm=underline         "ctermfg=5
"hi Type        cterm=bold,underline    "ctermfg=2
"hi Underlined  cterm=underline         ctermfg=DarkYellow
"hi Ignore      cterm=bold              ctermfg=7
hi Search       cterm=bold              ctermfg=Black   ctermbg=Yellow

" Cursor properties
hi CursorLine   cterm=underline         ctermbg=NONE    ctermfg=NONE
hi CursorColumn cterm=NONE              ctermbg=NONE    ctermfg=Gray

" Highlight - Matching Noises
highlight ExtraWhitespace ctermbg=DarkRed
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/
autocmd BufWinLeave * call clearmatches()

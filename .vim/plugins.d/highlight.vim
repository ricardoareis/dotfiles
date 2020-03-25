" Remove all hiing
hi clear Constant
"hi clear Number
"hi clear Statement
"hi clear PreProc
"hi clear Type
"hi clear Special
"hi clear Identifier
"
"hi clear String
hi clear Comment
hi clear Error
hi clear LineNr
"hi clear NonText
"hi clear SpecialKey
hi clear SpellBad
hi clear Search

" Set up some simple non-intrusive colors
if &background == "light"
"  hi String         term=underline  cterm=NONE ctermfg=DarkGreen
"  hi Comment        term=bold       cterm=NONE ctermfg=DarkBlue
"  hi SpecialComment                            ctermfg=DarkCyan
"  hi Error          term=reverse    cterm=NONE ctermfg=DarkRed
"  hi LineNr         term=bold       cterm=NONE ctermfg=DarkYellow
"  hi NonText        term=bold       cterm=NONE ctermfg=DarkYellow
"  hi SpecialKey     term=bold       cterm=NONE ctermfg=DarkYellow
else
  "hi String         term=underline  cterm=bold,underline    "ctermfg=DarkGreen
  hi Comment        term=NONE        cterm=NONE     ctermfg=DarkGray
  hi SpecialComment                 cterm=NONE      ctermfg=DarkCyan
  hi Error          term=NONE       cterm=underline ctermbg=NONE
  hi LineNr         term=bold       cterm=NONE      ctermfg=DarkGray
  "hi NonText        term=bold       cterm=NONE     ctermfg=Yellow
  "hi SpecialKey     term=bold       cterm=NONE     ctermfg=Yellow
   hi SpellBad                      cterm=underline ctermfg=DarkCyan
endif


"hi Number       cterm=underline
hi Constant     ctermfg=brown
"hi Special      ctermfg=5
"hi Identifier   ctermfg=6
"hi Statement    cterm=bold              ctermfg=3
"hi PreProc      cterm=underline         "ctermfg=5
"hi Type         cterm=bold,underline    "ctermfg=2
hi Underlined   cterm=underline         ctermfg=5
"hi Ignore       cterm=bold              ctermfg=7
hi Search        cterm=bold         ctermfg=Black   ctermbg=Yellow

" Basic properties <<<1
" vim: set expandtab sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker=<<<1,1>>> foldlevel=0 foldmethod=marker spell:
"
"   Note: Custom Maps <<<1
"     <F1>      Open NERDTree
"     <F2>      Open UndoTree
"     <F3>      Open Tagbar
"     <F8>      Shift Spell dictionaries
"     <S-Tab>   Shift between buffers
"     <Alt-(Left|Right)> (Next|Previous) Tab
"     <Alt-(Up|Down)>     Move view to see (bellow|above) the cursor
"
"     zfm                               Fold Method
"     z<(Down|UP)>     (Next|Previous)  Fold
"     z<(Right|Left)> (Close|Open)      Fold
"
"     <C-p>     Fuzzy Finder
"     <C-l>     Fuzzy Grep
"     <C-/>     Toggle   (On|Off)   Search Highlight
"     <Alt-.>   Execute last :cmd
"     <Leader>. Execute last search/replace
    " 1>>>

    " Use bundles config <<<1
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
    " 1>>>

    " SnipMate <<<1
    " Setting the author var
    " If forking, please overwrite in your .vimrc.local file
    let g:snips_author = 'Ricardo Reis <ricardo.areis@gmail.com>'
    " 1>>>

    " Important Properties I <<<1
    set nocompatible                            " be iMproved, required"
    let g:skip_defaults_vim = 1                 " disable defaults.vim

    scriptencoding utf-8
    set encoding=utf-8
    set shell=$SHELL                            " Using default $SHELL

    " Config Clipboard
    if has('clipboard')
        if has('unnamedplus')                   " Only-X11 - When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                                    " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
    " 1>>>

    " Important Properties II - Performance <<<1
    " tuning it for performance:
    syntax on
    syntax sync maxlines=512                    " the minimal and the maximal line to be
    syntax sync minlines=256                    " parsed to improve syntax highlight

    set synmaxcol=250                           " max number of column to be highlighted
                                                " lines after may not be correctly highlighted
    " 1>>>

    " Important Properties III <<<1
    filetype plugin indent on                   " Enable file type detection and do language dependent indenting

    set mouse=a                                 " Automatically enable mouse usage
    set mousehide                               " Hide the mouse cursor while typing

    set shortmess+=filmnrxoOtTI                 " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore                     " Allow for cursor beyond last character

    set iskeyword-=.                            " '.' is an end of word
    set iskeyword-=#                            " '#' is an end of word
    set iskeyword-=-                            " '-' is an end of word

    set autowrite                               " Write the contents of the file, if it has been modified, on each
                                                " :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
                                                " :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
                                                " '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
    set autoread                                " Allow vim autoread everything

    set report=0                                " after yank/delete/... report number of lines affected
    set signcolumn=yes

    set timeout timeoutlen=1600                 " Allow more time between keystrokes for some key mappings.
    set ttimeout ttimeoutlen=50                 " But not for for key codes. Use a very small value for them.

    set completeopt=longest,menuone,preview
    set switchbuf=useopen,usetab                " Attempt to edit currently open files instead of opening multiple buf
    set hidden                                  " Hide buffers when they are abandoned

    set wildmenu                                " enhanced command line completion
    set wildmode=list:longest:full              " complete files like a shell
    set scrolloff=10                            " lines of text around cursor
    set scrolljump=5                            " Lines to scroll when cursor leaves screen

    if has('cmdline_info')
        set ruler                               " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                             " Show partial commands in status line and
                                                " Selected characters/lines in visual mode
        set cmdheight=1                         " command bar height
    endif

    set laststatus=2                            " Always show the status line
    set noshowmode                              " Disabled default showmode
    set number relativenumber                   " Default relative number

    "https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
    set backspace=indent,eol,start              " Backspace for dummies (vim has a different approach)
    " 1>>>

    " Searching <<<1
    set ignorecase                              " case insensitive searching
    set smartcase                               " case-sensitive if expresson contains a capital letter
    set hlsearch                                " highlight search match
    set incsearch                               " set incremental search, like modern browsers
    set magic                                   " Set magic on, for regex

    " Performance Improving
    set re=1                                    " revert to regexp engine v1
    set ttyfast                                 " Improves screen redraw"
    set lazyredraw                              " Avoid redrawing the screen mid-command."
    " 1>>>

    " Restore cursor to file position in previous editing session <<<1
    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction
    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
    " 1>>>

    " Cursor Behavior - changed behavior, in a edit, replace and append mode <<<1
    " see autocmds.vim
    if empty($TMUX)
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    else
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
    " 1>>>

    " Initialize directories <<<1
    " from spf13-vim :)
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }
        "
        if has('persistent_undo')
            "add an undo-break (see :help i_CTRL-G_u).
            inoremap <C-u> <C-g>u<C-u>
            set undofile
            set undolevels=10000                " Maximum number of changes that can be undone
            set undoreload=10000                " Maximum number lines to save for undo on a buffer reload
            let dir_list['undo'] = 'undodir'
        endif
        "$HOME/.vim/backupdir
        let common_dir = parent . '/.' . prefix . '/' . prefix
        "
        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                " the exec will execute:
                " set backup
                " set views
                " set swap
                " set undo
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()

    "set patchmode=.orig
    set backupext=.bkp
    set cursorcolumn
    " 1>>>

    " Keyboard keys - TMUX <<<1
    " tmux will send xterm-style keys when its xterm-keys option is on
    if &term =~ '^xterm' || &term =~ '^screen' || &term =~ "^tmux"
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
        "execute "set t_FI=\e[1;3D"
        "execute "set t_FJ=\e[1;3C"
    endif
    " 1>>>

    " Disable unused builtin plugins <<<1
    let g:loaded_gzip              = 1
    let g:loaded_tar               = 1
    let g:loaded_tarPlugin         = 1
    let g:loaded_zip               = 1
    let g:loaded_zipPlugin         = 1
    let g:loaded_rrhelper          = 1
    let g:loaded_2html_plugin      = 1
    let g:loaded_vimball           = 1
    let g:loaded_vimballPlugin     = 1
    let g:loaded_getscript         = 1
    let g:loaded_getscriptPlugin   = 1
    let g:loaded_netrw             = 1
    let g:loaded_netrwPlugin       = 1
    let g:loaded_netrwSettings     = 1
    let g:loaded_netrwFileHandlers = 1
    let g:loaded_logipat           = 1
    " 1>>>

    " Color properties <<<1
    if &term =~ '^xterm' || &term =~ '^screen' || &term =~ "^tmux"
        set t_Co=256                                " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    if exists('+termguicolors')                     " Only if compiled
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
    set background=dark                             " Prefer Dark over Light
    if isdirectory(expand(bundles_dir . "/gruvbox-material"))
        let g:gruvbox_material_background='hard'        " Contrast Level
        colorscheme gruvbox-material                    " Using the same color scheme
        let g:gruvbox_termcolors=256                    " Accepting the 256 colors
        let g:gruvbox_material_enable_italic = 0        " Allow Italic fonts
        let g:gruvbox_material_disable_italic_comment = 1
        let g:gruvbox_material_enable_bold = 1
        let g:gruvbox_material_diagnostic_line_highlight = 1
    endif
    " 1>>>

    " Alerts and feedback properties <<<1
    set noerrorbells
    set novisualbell
    set t_vb=                       "Never Flash de Screen"
    " 1>>>

    " Spell properties <<<1
    set spelllang=en_us,pt
    set spellsuggest=best,10
    set spellfile=~/.vim/spell/local.utf-8.add          " local dictionary
    " 1>>>

    " Format properties <<<1
    set autoindent          " Indent at the same level of the previous line
    set smartindent         " use smart indent if there is no indent file
    set tabstop=4           " each tab a four columns
    set softtabstop=4       " let backspace delete indent
    set smarttab            " Handle tabs more intelligently
    set expandtab           " tabs are spaces, not tabs
    set shiftwidth=4        " use indents of 4 spaces
    set shiftround          " rounding indent in a multiples of a shiftwidth
    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
    set splitright          " Puts new vsplit windows to the right of the current
    set splitbelow          " Puts new split windows to the bottom of the current
    set cindent             " Stricter rules for C program
    " 1>>>

    " The complete properties <<<1
    "
    " .: Scan the current buffer
    " w: Scan buffers from other windows
    " b: Scan buffers from the buffer list
    " u: Scan buffers that have been unloaded from the buffer list
    " t: Tag completion
    " i: Scan the current and included files
    "
    " see :set complet
    "
    set complete-=i   " disable scanning included files
    set complete-=t   " disable searching tags
    " 1>>>

" 1>>>

" Misc <<<1

    " WhichKey - Map <<<1
    " The default leader is '\', but many people prefer ',' as it's in a standard
    set timeoutlen=500
    let g:mapleader=","
    let g:maplocalleader=" "

    if isdirectory(expand(bundles_dir . "/vim-which-key"))
        nnoremap <silent> <Leader>      :<c-u>WhichKey       ','<CR>
        vnoremap <silent> <leader>      :<c-u>WhichKeyVisual ','<CR>
        nnoremap <silent> <LocalLeader> :<c-u>WhichKey        '<Space>'<CR>
        vnoremap <silent> <LocalLeader> :<c-u>WhichKeyVisual  '<Space>'<CR>

        " Define prefix dictionary
        let g:which_key_leader_map = {}
        let g:which_key_localleader_map = {}
        let g:which_key_leader_map.t = {'name': '+Toggle'}
        let g:which_key_leader_map.e = {'name': '+Edit'}
        let g:which_key_leader_map.s = {'name': '+System/Session'}
        let g:which_key_leader_map.g = {'name': '+Git'}
        let g:which_key_leader_map.w = {'name': '+Windows'}
        let g:which_key_leader_map.k = {'name': '+Bookmark'}
        let g:which_key_leader_map.n = {'name': '+Narrow'}
        let g:which_key_leader_map.a = {'name': '+Align'}
        let g:which_key_leader_map.r = {'name': '+Replace'}
        "
        call which_key#register(',',       'g:which_key_leader_map')
        call which_key#register('<Space>', 'g:which_key_localleader_map')

        nnoremap <silent><unique> <Leader>sr :source ~/.vimrc<CR>
        nnoremap <silent><unique> <Leader>so :browse oldfiles<CR>
        let g:which_key_leader_map.s.r = 'VimReload'
        let g:which_key_leader_map.s.o = 'BrowserOldfiles'

    endif
    " 1>>>

    " Show Invisible Chars <<<1
    set nolist                                          " default disable
    if &encoding =~ 'utf-8'
        set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵       " default unicode
        nnoremap <silent><unique> <Leader>tl :set list!<CR>
        let g:which_key_leader_map.t.l = 'ListChars'
    endif
    " 1>>>

    " Dealing with a long lines properties <<<1
    set wrap                                            " wrap long lines by default
    set whichwrap=b,s,h,l,<,>,[,]                       " Backspace and cursor keys wrap too
    set colorcolumn=120                                 " Use a colored column to mark textwidh
    set showbreak=...
    " 1>>>

    " Vimdiff - Properties <<<1
    if &diff
        set diffopt+=iwhite
        if has('nvim-0.3.2') || has("patch-8.1.0360")
            set diffopt=internal,filler,algorithm:histogram,indent-heuristic,vertical
        endif
        function! IwhiteToggle()
            if &diffopt =~ 'iwhite'
                set diffopt-=iwhite
            else
                set diffopt+=iwhite
            endif
        endfunction
        map gs :call IwhiteToggle()<CR>
    endif
    " 1>>>

    " Conceal properties <<<1
    if has('conceal')
        set conceallevel=0
        nnoremap coe :set <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=1'<CR><CR>
    endif
    " 1>>>

    " JSON <<<1
    if has('python3')
        command! JSONPretty call FormatJson()
    else
        command! JSONPretty %!python -m json.tool
    endif
    nnoremap jp <Esc>:JSONPretty<CR><Esc>:set filetype=json<CR>
    let g:vim_json_syntax_conceal = 1
    " 1>>>

    " DecodeB64 <<<1
    if has('python3')
        vnoremap <leader>64 c<c-r>=DecodeB64()<CR><Esc>
    else
        vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<CR><Esc>
    endif
    " 1>>>

    " Wildfire <<<1
    let g:wildfire_objects = {
                \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
                \ "html,xml" : ["at"],
                \ }
    " 1>>>

" 1>>>

" Maps <<<1

    " Map for <Leader> <<<1
    " Ignore which key popup
    "
    " repeat the search/replace in the cursor line
    nnoremap <Leader>. :&<CR>
    " replace one by one, the work in the cursor
    nnoremap <Leader>x *``cgn
    " search/replace over
    nnoremap <Leader>ro :OverCommandLine<CR>
    " a quick way of select
    nmap <Leader>v <Plug>(wildfire-quick-select)
    let g:which_key_leader_map.x = 'which_key_ignore'
    let g:which_key_leader_map.o = 'which_key_ignore'
    let g:which_key_leader_map.v = 'which_key_ignore'
    let g:which_key_leader_map['.'] = 'which_key_ignore'
    let g:which_key_leader_map['*'] = 'which_key_ignore'
    let g:which_key_leader_map['/'] = 'which_key_ignore'
    " 1>>>

    " Plugin: Whichkey map for <Leader><Leader> <<<1
    let g:which_key_leader_map[','] = {
     \ 'name' : '+Quick',
     \ 'x' : [':ALEFix                                     ', 'ALEFix'                         ],
     \ 'n' : [':ALENext                                     ', 'ALENext'                        ],
     \ 'p' : [':ALEPreviows                                 ', 'ALEPreviows'                    ],
     \ 'i' : [':ALEInfoToClipboard                          ', 'ALEInfoToClipboard'             ],
     \ 'd' : [':YcmCompleter GoToDefinitionElseDeclaration  ', 'GoToDefinitionElseDeclaration'  ],
     \ }
    " 1>>>

    " Windows: Better split management, kept in sync with tmux' mappings <<<1
    let g:which_key_leader_map['w'] = {
      \ 'name' : '+Windows' ,
      \ 'w' : ['<C-W>w'         , 'other-window']          ,
      \ 'd' : ['<C-W>c'         , 'delete-window']         ,
      \ '-' : ['<C-W>s'         , 'split-window-below']    ,
      \ '|' : ['<C-W>v'         , 'split-window-right']    ,
      \ '2' : ['<C-W>v'         , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'         , 'window-left']           ,
      \ 'j' : ['<C-W>j'         , 'window-below']          ,
      \ 'l' : ['<C-W>l'         , 'window-right']          ,
      \ 'k' : ['<C-W>k'         , 'window-up']             ,
      \ 'H' : ['<C-W>10<'       , 'expand-window-left']    ,
      \ 'J' : [':resize +10'    , 'expand-window-below']   ,
      \ 'L' : ['<C-W>10>'       , 'expand-window-right']   ,
      \ 'K' : [':resize -10'    , 'expand-window-up']      ,
      \ '=' : ['<C-W>='         , 'balance-window']        ,
      \ 's' : ['<C-W>s'         , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'         , 'split-window-below']    ,
      \ '?' : ['Windows'        , 'fzf-window']            ,
      \ }
    " 1>>>

    " Toggle cursor line <<<1
    nnoremap <silent><unique> <Leader>tc :set cursorline!<CR>
    let g:which_key_leader_map.t.c = 'CursorLine'
    " 1>>>

    " Scroll the view port faster <<<1
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>
    " 1>>>

    " Buffer shortcuts <<<1
    "
    nnoremap <silent><S-Tab>  :bp<CR>
    "
    let g:which_key_leader_map.b = {
      \ 'name' : '+Buffers' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }
    " 1>>>

    " Map to move lines to bellow than current line <<<1
    "
    "TODO: Refactoring to suporte more than
    "2 chars, in a relative line number
    "
    function! MvLines()
        " This function receave 2 chars
        " that representing the relative line number
        " Ex. command mv +9 will mv the line 9 to the
        " current cursorline.
        let l:number = 2
        let l:string = ""
        while l:number > 0
            let l:string .= nr2char(getchar())
            let l:number -= 1
        endwhile
        return l:string . "m."
    endfunction
    "
    nnoremap mv :<C-u>execute MvLines()<CR>
    "https://www.reddit.com/r/vim/comments/fzu6b7/cp_change_put/
    nnoremap cp "_ciw<C-r>0<Esc>
    " 1>>>

    " Inconsistency: Fix <<<1
    "
    " Yank from the cursor to the end of the line, to be consistent with C and D.
    " (including the newline)
    nnoremap Y y$
    " select since the first chars at the end of line, without newline
    nnoremap vv ^vg_
    " select all chars after cursos, without newline
    nnoremap vV vg_
    " TODO: why i don't have this problem?
    "set nostartofline
    " 1>>>

    " Solve an accidentally typing  <<<1
    " remap the cmd history to be q;
    nnoremap q; q:
    " remap the cmd history keycode to cmd quit
    nnoremap q: :q
    " 1>>>

    " Go to tab by number <<<1
    noremap <Esc>[1;3D :tabnext<CR>
    noremap <Esc>[1;3C :tabprevious<CR>
    " 1>>>

    " Code folding options <<<1
    set foldenable
    set foldminlines=2                              " minimal of lines
    set foldnestmax=10                              " deepest fold levels
    set foldopen-=search                            " do not open when searching for a match
    "
    "Jump between folding
    nnoremap z<Up> zk
    nnoremap z<Down> zj
    nnoremap z<Left> zc
    nnoremap z<Right> zo
    nmap <Leader>f0 :set foldlevel=0<CR>

    let g:which_key_leader_map.f = {
      \ 'name': '+Find/Files/Fold',
      \   '0' : '0-fold-level',
      \   '1' : '1-fold-level',
      \   '2' : '2-fold-level',
      \   '3' : '3-fold-level',
      \   '4' : '4-fold-level',
      \   '5' : '5-fold-level',
      \   '6' : '6-fold-level',
      \   '7' : '7-fold-level',
      \   '8' : '8-fold-level',
      \   '9' : '9-fold-level',
      \ }

    nmap <Leader>f1 :set foldlevel=1<CR>
    nmap <Leader>f2 :set foldlevel=2<CR>
    nmap <Leader>f3 :set foldlevel=3<CR>
    nmap <Leader>f4 :set foldlevel=4<CR>
    nmap <Leader>f5 :set foldlevel=5<CR>
    nmap <Leader>f6 :set foldlevel=6<CR>
    nmap <Leader>f7 :set foldlevel=7<CR>
    nmap <Leader>f8 :set foldlevel=8<CR>
    nmap <Leader>f9 :set foldlevel=9<CR>
    "
    set foldmethod=syntax
    nnoremap <silent>cof :let &foldmethod = tolower(matchstr(
          \',mmanual,kmarker,iindent,ssyntax,eexpr,ddiff',
          \','.nr2char(getchar()).'\zs\a*\C'))\|set foldmethod<CR>
    nmap <silent>zfm cof
    " 1>>>

    " Most prefer to toggle search highlighting rather than clear the current <<<1
    noremap    :set hlsearch! hlsearch?<CR>
    " 1>>>

    " Wrapped lines goes down/up to next row, rather than next line in file <<<1
    noremap j gj
    noremap k gk
    noremap <Down> g<Down>
    noremap <Up> g<Up>
    " 1>>>

    " End/Start of line motion keys act relative to row/wrap width in the <<<1
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-u>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-u>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-u>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-u>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-u>call WrapRelativeMotion("^", 1)<CR>
    " 1>>>

    " Visual shifting (does not exit Visual mode) <<<1
    vnoremap < <gv
    vnoremap > >gv
    " allow the <tab> to indent a selected text, when in a virtual mode
    vnoremap <Tab> >gv
    " 1>>>

    " Allow using the repeat operator with a visual selection (!) <<<1
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>
    " 1>>>

    " For when you forget to sudo.. Really Write the file. <<<1
    cmap w!! w !sudo tee % >/dev/null
    " 1>>>

    " Some helpers to edit mode <<<1
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
    " open in a new buffer
    map <Leader>ew :e %%
    let g:which_key_leader_map.e.w = 'NewFile'
    " open in a new horizontal window
    map <Leader>es :sp %%
    let g:which_key_leader_map.e.s = 'NewHorizontalWindow'
    " open in a new vertical window
    map <Leader>ev :vsp %%
    let g:which_key_leader_map.e.v = 'NewVerticalWindow'
    " open in a new tab
    map <Leader>et :tabe %%
    let g:which_key_leader_map.e.t = 'NewTab'
    " 1>>>

    " Jump to the middle of the current written line as opposed to the window width <<<1
    nnoremap <silent> gm :call cursor(0, virtcol('$')/2)<CR>
    nnoremap <silent> gM gm
    " 1>>>

    " Scroll relative to cursor (@_ suppresses [count] for zt) <<<1
    " this cmd alternate between 10 lines bellow and above.
    " Use <expr> to increase or decrease
    nnoremap <expr><C-Up>   v:count > 0 ? '@_zt'.v:count.'<c-y>' : 'zt'
    nnoremap <expr><C-Down> v:count > 0 ? '@_zb'.v:count.'<c-e>' : 'zb'
    " 1>>>

    " Repeat the last command (ex. :ls) <<<1
    " If your terminal print the same  for, both <Esc> and <Alt>
    " decide the best usability.
    nnoremap <Esc>. @:
    " 1>>>

    " Past Visual Select <<<1
    vnoremap <silent><C-w>pt "+y \| :tabnew \| :normal p<CR>
    " 1>>>


" 1>>>

" Unmaps <<<1
" STOP the help from being so... HELPFULL ;)
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>
" 1>>>

" Funtions <<<1

    " Initialize NERDTree as needed <<<1
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " 1>>>

    " Shell command <<<1
    function! s:RunShellCommand(cmdline)
        botright new
        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction
    "
    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " 1>>>

    " Searcher I - Search without move cursor <<<1
    " https://github.com/andymass/dotfiles/blob/master/vim/vimrc
    function! SearchWord()
        let l:word = escape(expand('<cword>'), &magic ? "/.*~[^$\\" : "/^$\\")
        let @/ = '\<'.l:word.'\>'
    endfunction

    nnoremap <silent> <Leader><Leader>s :<c-u>call SearchWord()
                \ \| set hlsearch \| let v:searchforward = 0<CR>
    nnoremap <silent> <Leader><Leader>S :<c-u>call SearchWord()
                \ \| set hlsearch \| let v:searchforward = 1<CR>
    " 1>>>

    " Searcher II - Search for deleted <<<1
    function! Text2Re(re, sp)
        set hlsearch
        let l:esc = escape(a:re, &magic ? a:sp.".*~\[^$\\" : a:sp."^$\\")
        return substitute(l:esc, '\n', '\\n', 'g')
    endfunction
    " search forward or backward for last small delete text
    function! KeepChanging(cmd)
        if empty(@-) | return '' | endif
        return a:cmd.Text2Re(@-, a:cmd)."\<cr>"
    endfunction
    nnoremap <expr> z[ KeepChanging('/')
    nnoremap <expr> z] KeepChanging('?')
    " 1>>>

    " TextWidth <<<1
    function! s:ToggleTextWidth()
        if &l:textwidth > 0
            let s:old_tw = &l:textwidth
            let &l:textwidth = 0
        else
            if exists('s:old_tw')
                let &l:textwidth = s:old_tw
            else
                let &l:textwidth = &g:colorcolumn  " textwith == colorcolumn
            endif
        endif
    endfunction

    let s:default_tw = &g:textwidth ? &g:textwidth : 74
    function! s:ExpandTextWidth()
        let l:longest = max(map(getline(line('w0'), line('w$')),
            \ 'strdisplaywidth(v:val)'))
        let &l:textwidth = (&l:textwidth == l:longest)
            \ ? s:default_tw
            \ : max([ s:default_tw, l:longest ])
        echo 'set textwidth='.&l:textwidth
    endfunction

    " toggle textwidth/column
    nnoremap <leader>tw :<c-u>call <sid>ToggleTextWidth()<CR>

    " set textwidth to longest line current screen, or default
    nnoremap <leader><leader>w :<c-u>call <sid>ExpandTextWidth()<CR>
    " 1>>>

" 1>>>

"Plugins <<<1

    " Plugin: YCM properties <<<1
    if isdirectory(expand(bundles_dir . "/YouCompleteMe"))
        let g:ycm_use_clangd = 1
        let g:ycm_max_num_candidates = 30
        " Virtualenv properties
        let g:ycm_python_interpreter_path = ''
        let g:ycm_python_sys_path = []
        let g:ycm_extra_conf_vim_data = [
          \  'g:ycm_python_interpreter_path',
          \  'g:ycm_python_sys_path'
          \]
        let g:ycm_global_ycm_extra_conf = '~/repos/dotfiles/.ycm_extra_conf.py'
        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:ycm_key_detailed_diagnostics = ''
        let g:ycm_show_diagnostics_ui = 0
        "
        nmap <Leader><Leader>h <plug>(YCMHover)
        let g:ycm_auto_hover = 1
        let g:ycm_auto_trigger = 1
        let g:ycm_seed_identifiers_with_syntax = 1
        " Trigger configuration.
        " Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
        "
        let g:UltiSnipsExpandTrigger = '<C-j>'
        let g:UltiSnipsJumpForwardTrigger = '<C-j>'
        let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit = "vertical"
        let g:ycm_enable_diagnostic_signs = 0
        let g:ycm_collect_identifiers_from_tags_files = 1
        "
        " Disable the neosnippet preview candidate window
        " When enabled, there can be too much visual noise
        " especially when splits are used.
        set completeopt-=preview
    endif
    " 1>>>

    " Plugin: Identlines properties (this plugin change conceal properties) <<<1
    if isdirectory(expand(bundles_dir . "/vim-indent-guides/"))
        let g:indent_guides_default_mapping = 0
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
        "
        nnoremap <silent><unique> <Leader>ti :IndentGuidesToggle<CR>
        let g:which_key_leader_map.t.i = 'IndentGuidesToggle'
    endif
    " 1>>>

    " Plugin: Airline properties <<<1
    if isdirectory(expand(bundles_dir . "/vim-airline/"))
        let g:airline_powerline_fonts = 1
        let g:airline_skip_empty_sections = v:true
        let g:bufferline_echo = 0
        let g:airline_highlighting_cache = 1
        if isdirectory(expand(bundles_dir . "/vim-airline-themes/"))
            let g:airline_extensions=['branch', 'localsearch', 'virtualenv', 'csv', 'bufferline',
                        \             'hunks', 'keymap', 'quickfix', 'ale', 'tagbar', 'term',
                        \             'undotree', 'whitespace', 'wordcount', 'ycm', 'tabline']
            " tab properties
            let g:airline#extensions#tabline#show_buffers = 0
            let g:airline#extensions#tabline#show_splits = 0                " show splited windows on tabs
            let g:airline#extensions#tabline#show_tab_count = 0             " show tab cont
            let g:airline#extensions#tabline#tab_min_count = 2
            let g:airline#extensions#tabline#exclude_preview = 1
            let g:airline#extensions#tabline#show_close_button = 0
            let g:airline#extensions#tabline#show_tab_type = 0
            let g:airline#extensions#tabline#show_tab_nr = 0
            let g:airline#extensions#tabline#fnamecollapse = 1
            let g:airline#extensions#tabline#buffers_label = ''
            let g:airline#extensions#tabline#tabs_label = ''

            " Just show the file name
            let g:airline#extensions#tabline#fnamemod = ':t'

            if exists('g:gruvbox_material')
                let g:airline_theme='gruvbox_material'
            endif
            if exists('g:airline_powerline_fonts') && v:version >= 800 && has('signs')
                let g:airline_symbols = {}
                let g:airline_symbols.branch = ''
                let g:airline_symbols.crypt =  ''
                let g:airline_symbols.maxlinenr = ' '
                let g:airline_symbols.linenr = '☰ '
                let g:airline_symbols.modified = '+'
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.paste = 'ρ'
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.space = ' '
                let g:airline_symbols.spell = ''
                let g:airline_symbols.whitespace = 'Ξ'
            endif
        endif
    endif
    " 1>>>

    " Plugin: FZF (performs like CtrlP) <<<1
    if isdirectory(expand(bundles_dir . "/fzf/"))
        "Open a file fuzzy search
        nnoremap <C-p> :Files<CR>
        "Open a content fuzzy search
        nnoremap <C-l> :Rg<CR>
        "Open a line fuzzy search
        nnoremap gl :BLines<CR>
        "Open a word fuzzy search
        nnoremap <leader>* :Rg <C-R><C-W><CR>
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'sharp'  }  }
    endif
    " 1>>>

    " Plugin: Vim-Go properties <<<1
    if isdirectory(expand(bundles_dir . "/vim-go/"))
        let g:go_fmt_command = "goimports"          " format with goimports instead of gofmt
        let g:go_list_type = "quickfix"
        let g:go_version_warning = 0
        let g:go_fmt_fail_silently = 1
        let g:go_fmt_autosave = 1                   " disable fmt on save
        let g:go_textobj_include_function_doc = 1

        " Performance improve
        let g:go_highlight_methods = 0
        let g:go_highlight_functions = 0
        let g:go_highlight_structs = 0
        let g:go_highlight_interfaces = 0
        let g:go_highlight_operators = 0
        "
        let g:go_gopls_enabled = 1                  " YCM concurrency
        let g:go_highlight_space_tab_error=0
        let g:go_highlight_array_whitespace_error=0
        let g:go_highlight_trailing_whitespace_error=0
        let g:go_highlight_build_constraints = 1
    endif
    " 1>>>

    " Plugin: GitGutter properties <<<1
    if isdirectory(expand(bundles_dir . "/vim-gitgutter/"))
        set updatetime=500
        let g:gitgutter_enabled=1
        let g:gitgutter_map_keys=0
        let g:gitgutter_sign_allow_clobber=1
        let g:gitgutter_highlight_lines=0
        let g:gitgutter_highlight_linenrs=1
        let g:gitgutter_sign_added='ad'
        let g:gitgutter_sign_modified='md'
        let g:gitgutter_sign_removed='rd'
        let g:gitgutter_sign_removed_first_line='rf'
        let g:gitgutter_sign_modified_removed='mr'
        let g:gitgutter_max_signs=100
        set foldtext=gitgutter#fold#foldtext()
        map ghs :GitGutterStageHunk<CR>
        map ghu :GitGutterUndoHunk<CR>
        map ghf :GitGutterFold<CR>
        nmap ]h <Plug>(GitGutterNextHunk)
        nmap [h <Plug>(GitGutterPrevHunk)
    endif
    " 1>>>

    " Plugin: Vim-ALE properties <<<1
    if isdirectory(expand(bundles_dir . "/ale/"))
        let g:ale_lint_on_enter = 0
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_insert_leave = 0
        let g:ale_sign_column_always = 1
        let g:ale_open_list = 1
        let g:ale_set_loclist = 0
        let g:ale_set_quickfix = 1
        let g:ale_keep_list_window_open = 1
        let g:ale_list_window_size = 5
        let g:ale_completion_autoimport = 1
        let g:ale_linters_explicit = 1
        let g:ale_fixers = {
                    \   'python':   ['remove_trailing_lines', 'trim_whitespace'],
                    \   'go':       ['remove_trailing_lines', 'trim_whitespace'],
                    \   'sh':       ['remove_trailing_lines', 'trim_whitespace'],
                    \   'zsh':      ['remove_trailing_lines', 'trim_whitespace']
                    \}
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format = '[%linter%:%code%:%severity%] %s'
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    endif
    " 1>>>

    " Plugin: EditorConfig properties <<<1
    if isdirectory(expand(bundles_dir . "/editorconfig/"))
        let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    endif
    " 1>>>

    " Plugin: Session List <<<1
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    if isdirectory(expand(bundles_dir . "/sessionman.vim/"))
        nnoremap <silent><Leader>sl :SessionList<CR><CR>
        let g:which_key_leader_map.s.l = 'SessionList'
        "
        nnoremap <silent><Leader>ss :SessionSave<CR><CR>
        let g:which_key_leader_map.s.s = 'SessionSave'
        "
        nnoremap <silent><Leader>sc :SessionClose<CR><CR>
        let g:which_key_leader_map.s.c = 'SessionClose'
    endif
    " 1>>>

    " Plugin: UndoTree properties <<<1
    if isdirectory(expand(bundles_dir . "/undotree/"))
        nnoremap <silent><F2> :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle=1
        let g:undotree_WindowLayout = 4
        let g:undotree_ShortIndicators = 1
        let g:undotree_DiffpanelHeight = 13
        let g:undotree_SplitWidth = 30
        let g:undotree_HighlightChangedWithSign = 1
        let g:undotree_DiffCommand = 'diff -pud --label earlier --label later'
        let g:undotree_HighlightChangedWithSign = 1
    endif
    " 1>>>

    " Plugin: NerdTree properties <<<1
    if isdirectory(expand(bundles_dir . "/nerdtree"))
        nnoremap <silent><F1> :NERDTreeToggle<CR>
        let g:NERDShutUp=1
        let g:NERDTreeQuitOnOpen=1                      " close NERDTree after a file is opened
        let NERDTreeShowLineNumbers=1
        let NERDTreeMinimalUI=0
        let NERDTreeDirArrows=0
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
        " expand to the path of the file in the current buffer
        nnoremap <silent> <Leader>ff :NERDTreeFind<CR>
        let g:which_key_leader_map.f.f = 'NERDTreeFind'
    endif
    " 1>>>

    " Plugin: TagBar properties <<<1
    if isdirectory(expand(bundles_dir . "/tagbar/"))
        nnoremap <silent> <F3> :TagbarToggle<CR>
        let g:tagbar_left=0
        let g:tagbar_autofocus=1
        let g:tagbar_compact=1
        let g:tagbar_autoclose=1
        set tags=./tags;/,~/.vimtags
        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    endif
    " 1>>>

    " Plugin: Rainbow <<<1
    if isdirectory(expand(bundles_dir . "/rainbow/"))
        let g:rainbow_active = 1                        " 0 if you want to enable it later via :RainbowToggle
    endif
    " 1>>>

    " Plugin: Fugitive <<<1
    if isdirectory(expand(bundles_dir . "/vim-fugitive/"))
        nnoremap <silent> <Leader>gs :Gstatus<CR>
        let g:which_key_leader_map.g.s = 'Gstatus'
        "
        nnoremap <silent> <Leader>gd :Gdiff<CR>
        let g:which_key_leader_map.g.d = 'Gdiff'
        "
        nnoremap <silent> <Leader>gc :Gcommit<CR>
        let g:which_key_leader_map.g.c = 'Gcommit'
        "
        nnoremap <silent> <Leader>gb :Gblame<CR>
        let g:which_key_leader_map.g.b = 'Gblame'
        "
        nnoremap <silent> <Leader>gl :Glog<CR>
        let g:which_key_leader_map.g.l = 'Glog'
        "
        nnoremap <silent> <Leader>gp :Git push<CR>
        let g:which_key_leader_map.g.p = 'Gpush'
        "
        nnoremap <silent> <Leader>gr :Gread<CR>
        let g:which_key_leader_map.g.r = 'Gread'
        "
        nnoremap <silent> <Leader>gw :Gwrite<CR>
        let g:which_key_leader_map.g.w = 'Gwrite'
        "
        nnoremap <silent> <Leader>ge :Gedit<CR>
        let g:which_key_leader_map.g.e = 'Gedit'
        "
        nnoremap <silent> <Leader>gi :Git add -p %<CR>
        let g:which_key_leader_map.g.i = 'Gadd -p %'
        "
        nnoremap <silent> <Leader>gv :GV<CR>
        let g:which_key_leader_map.g.v = 'GitBrowser'
        "
        nnoremap <silent> <Leader>gf :GV!<CR>
        let g:which_key_leader_map.g.f = 'GitBrowserThisFile'
    endif
    " 1>>>

    " Plugin: Better-WhiteSpace <<<1
    if isdirectory(expand(bundles_dir . "/vim-better-whitespace/"))
        nnoremap ]w :NextTrailingWhitespace<CR>
        nnoremap [w :PrevTrailingWhitespace<CR>
        let g:strip_whitespace_on_save = 1
    endif
    " 1>>>

    " Plugin: LocalSearch <<<1
    if isdirectory(expand(bundles_dir . "/vim-localsearch/"))
        nmap <Leader>/ <Plug>localsearch_toggle
    endif
    " 1>>>

    " Plugin: Wordy <<<1
    noremap  <silent> <F8> :<C-u>NextWordy<cr>
    xnoremap <silent> <F8> :<C-u>NextWordy<cr>
    inoremap <silent> <F8> <C-o>:NextWordy<cr>
    "]s	- Move to next misspelled word after the cursor.
    "[s	- Like ]s but search backwards
    " 1>>>

    "Plugin: Vim-repl - Python <<<1
    if isdirectory(expand(bundles_dir . "/vim-repl/"))
        let g:repl_program = {
                    \   'python': 'ipython',
                    \   'default': 'zsh',
                    \   'r': 'R',
                    \   'lua': 'lua',
                    \   'vim': 'vim -e',
                    \   }
        let g:repl_predefine_python = {
                    \   'numpy': 'import numpy as np',
                    \   'matplotlib': 'from matplotlib import pyplot as plt'
                    \   }
        let g:repl_cursor_down = 1
        let g:repl_python_automerge = 1
        let g:repl_ipython_version = '7.13.0'
        let g:repl_output_copy_to_register = "t"
        let g:sendtorepl_invoke_key = ""
        let g:repl_position = 3
    endif
    " 1>>>

    " Plugin: MarkerText <<<1
    let g:SignatureMarkerTextHLDynamic=1
    " 1>>>

    " Plugin: NERDCommenter <<<1
    if isdirectory(expand(bundles_dir . "/nerdcommenter/"))
        let g:which_key_leader_map['c'] = {
         \ 'name' : '+Commentes',
         \ ' ' : ['<Plug>NERDCommentToggle   ', 'Toggle'    ],
         \ '$' : ['<Plug>NERDCommentToEOL    ', 'ToEOL'     ],
         \ 'A' : ['<Plug>NERDCommentAppend   ', 'Append'    ],
         \ 'a' : ['<Plug>NERDCommentAltDelims', 'AltDelims' ],
         \ 'b' : ['<Plug>NERDCommentAlignBoth', 'AlignBoth' ],
         \ 'c' : ['<Plug>NERDCommentComment  ', 'Comment'   ],
         \ 'i' : ['<Plug>NERDCommentInvert   ', 'Invert'    ],
         \ 'l' : ['<Plug>NERDCommentAlignLeft', 'AlignLeft' ],
         \ 'm' : ['<Plug>NERDCommentMinimal  ', 'Minimal'   ],
         \ 'n' : ['<Plug>NERDCommentNested   ', 'Nested'    ],
         \ 's' : ['<Plug>NERDCommentSexy     ', 'Sexy'      ],
         \ 'u' : ['<Plug>NERDCommentUncomment', 'Uncomment' ],
         \ 'y' : ['<Plug>NERDCommentYank     ', 'Yank'      ],
         \ }
        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1

        " Use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs = 1

        " Enable trimming of trailing whitespace when uncommenting
        let g:NERDTrimTrailingWhitespace = 1

        " Enable NERDCommenterToggle to check all selected lines is commented or not
        let g:NERDToggleCheckAllLines = 1
    endif
    " 1>>>

    " Plugin: Sneake <<<1
    if isdirectory(expand(bundles_dir . "/vim-sneak/"))
        let g:sneak#label = 1
        map <Leader><Leader>f <Plug>Sneak_s
        map <Leader><Leader>F <Plug>Sneak_S
    endif
    " 1>>>

    " Plugin: Vim-FloatTerm <<<1
    if isdirectory(expand(bundles_dir . "/vim-floaterm/"))
        let g:floaterm_keymap_new    = '<F4>'
        let g:floaterm_keymap_prev   = '<F5>'
        let g:floaterm_keymap_next   = '<F6>'
        let g:floaterm_keymap_toggle = '<F7>'
        let g:floaterm_keymap_kill   = '<Leader><Leader>k'
        let g:floaterm_width    = 0.9
        let g:floaterm_height   = 0.9
        let g:floaterm_position = 'center'
        let g:floaterm_autoclose = 2
    endif
    " 1>>>

    " Plugin: Vim-Bookmark <<<1
    if isdirectory(expand(bundles_dir . "/vim-bookmarks/"))
        let g:bookmark_no_default_key_mappings = 1
        let g:bookmark_auto_save = 1
        let g:bookmark_auto_save_file = $HOME .'/.vim/.'. $USER .'-bookmarks'
        let g:which_key_leader_map.t.b = 'BookmarkToggle'
        nnoremap <silent><Leader>tb :BookmarkToggle<CR>
        nnoremap <Leader>ki :BookmarkAnnotate<CR>
        nnoremap <Leader>ka :BookmarkShowAll<CR>
        nnoremap <Leader>kj :BookmarkNext<CR>
        nnoremap <Leader>kk :BookmarkPrev<CR>
        nnoremap <Leader>kc :BookmarkClear<CR>
        nnoremap <Leader>kx :BookmarkClearAll<CR>
        nnoremap <Leader>ku :BookmarkMoveUp<CR>
        nnoremap <Leader>kd :BookmarkMoveDown<CR>
        nnoremap <Leader>kg :BookmarkMoveToLine<CR>
        let g:which_key_leader_map.k.i = 'BookmarkAnnotate'
        let g:which_key_leader_map.k.a = 'BookmarkShowAll'
        let g:which_key_leader_map.k.j = 'BookmarkNext'
        let g:which_key_leader_map.k.k = 'BookmarkPrev'
        let g:which_key_leader_map.k.c = 'BookmarkClear'
        let g:which_key_leader_map.k.x = 'BookmarkClearAll'
        let g:which_key_leader_map.k.u = 'BookmarkMoveUp'
        let g:which_key_leader_map.k.d = 'BookmarkMoveDown'
        let g:which_key_leader_map.k.g = 'BookmarkMoveToLine'
    endif
    " 1>>>

    " Plugin: Vim-Pythonsense <<<1
    if isdirectory(expand(bundles_dir . "/vim-pythonsense/"))
        let g:is_pythonsense_alternate_motion_keymaps = 1
        let g:is_pythonsense_suppress_location_keymaps = 1
    endif
    " 1>>>

    " Plugin: Vim-Move <<<1
    if isdirectory(expand(bundles_dir . "/vim-move/"))
        let g:move_map_keys = 1
        let g:move_past_end_of_line = 1
        vmap j <Plug>MoveBlockDown
        vmap k <Plug>MoveBlockUp
        vmap h <Plug>MoveBlockLeft
        vmap l <Plug>MoveBlockRight
    endif
    " 1>>>

    " Plugin: Vim-Matchup <<<1
    if isdirectory(expand(bundles_dir . "/vim-matchup/"))
        let g:loaded_matchit = 0
        let g:matchup_matchparen_enabled = 0
        let g:matchup_text_obj_enabled = 1
    endif
    " 1>>>

    " Plugin: Vim-VisualSplit <<<1
    if isdirectory(expand(bundles_dir . "/visual-split.vim/"))
        xmap <C-W>r <Plug>(Visual-Split-VSResize)
        xmap <C-W>s <Plug>(Visual-Split-VSSplit)
        xmap <C-W>a <Plug>(Visual-Split-VSSplitAbove)
        xmap <C-W>b <Plug>(Visual-Split-VSSplitBelow)

        nmap <C-W>r <Plug>(Visual-Split-Resize)
        nmap <C-W>s <Plug>(Visual-Split-Split)
        nmap <C-W>a <Plug>(Visual-Split-SplitAbove)
        nmap <C-W>b <Plug>(Visual-Split-SplitBelow)
    endif
    " 1>>>

    " Plugin: Vim-NrrwRegn <<<1
    if isdirectory(expand(bundles_dir . "/NrrwRgn/"))
        let g:which_key_leader_map.n.r = 'OpenInNarrowedWindow'
    endif
    " 1>>>

    " Plugin: Vim-autopair <<<1
    if isdirectory(expand(bundles_dir . "/auto-pairs/"))
        let g:AutoPairsShortcutToggle = '<Leader>tp'
    endif
    " 1>>>

    " Plugin: Vim-tabularize <<<1
    if isdirectory(expand(bundles_dir . "/tabular/"))
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
    endif
    " 1>>>

    " Plugin: Vim-gutentags <<<1
    if isdirectory(expand(bundles_dir . "/vim-gutentags/"))
        " enable gtags module
        let g:gutentags_modules = ['ctags']

        " config project root markers.
        let g:gutentags_project_root = ['.root']

        " generate datebases in my cache directory, prevent gtags files polluting my project
        let g:gutentags_cache_dir = expand('~/.cache/tags')

        " change focus to quickfix window after search (optional).
        let g:gutentags_plus_switch = 1

        " YCM compatibility
        let g:gutentags_ctags_extra_args = ['--fields=+lnS']

        let g:gutentags_plus_nomap = 1
    endif
    " 1>>>

    " Plugin: Vim-docker <<<1
    if isdirectory(expand(bundles_dir . "/docker.vim/"))
        " open browser command, default is 'open'
        let g:docker_open_browser_cmd = 'open'

        " split temrinal windows, can use vert or tab, etc...
        let g:docker_terminal_open = 'vert'

        let s:docker_auth_file = expand('~/.docker/docker.vim.json')
        if filereadable(s:docker_auth_file)
            let g:docker_registry_auth = json_decode(join(readfile(s:docker_auth_file), "\n"))
        endif
    endif
    " 1>>>

    " Plugin: Vim-Compose <<<1
    if isdirectory(expand(bundles_dir . "/docker-compose.vim/"))
        " open terminal way
        let g:docker_compose_open_terminal_way = 'top'
    endif
    " 1>>>

    " Plugin: Vim-Dispatch <<<1
    if isdirectory(expand(bundles_dir . "/vim-dispatch/"))
        let test#strategy = "dispatch"
        let g:test#preserve_screen = 1
        let test#python#runner = 'pytest'
    endif
    " 1>>>

    " Plugin: Vim-Preview <<<1
    if isdirectory(expand(bundles_dir . "/vim-preview/"))
        noremap <LocalLeader><LocalLeader>d :PreviewTag<CR>
        noremap <LocalLeader><LocalLeader>s :PreviewSignature!<CR>
        inoremap <LocalLeader><LocalLeader>s <c-\><c-o>:PreviewSignature!<CR>
    endif
    " 1>>>
" 1>>>

" Loading others .vim <<<1
" function to source in directory
for fpath in split(globpath('~/.vim/plugins.d/', '*.vim'), '\n')
    exe 'source' fpath
endfor
" 1>>>

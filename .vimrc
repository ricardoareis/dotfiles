" Basic properties <<<1
" vim: set expandtab sw=4 ts=4 sts=4 tw=78 ft=vim foldmarker=<<<1,1>>> foldlevel=0 foldmethod=marker spell:

    " Note: Custom Maps <<<1
    "     <F1>      Open NERDTree
    "     <F2>      Open UndoTree
    "     <F3>      Open Tagbar
    "     <F8>      Shift Spell dictionaries
    "     <S-Tab>   Shift between buffers
    "     <Alt-(Left|Right)> (Next|Previous) Tab
    "     <Alt-(Up|Down)>     Move view to see (bellow|above) the cursor
    "
    "     zfm                              Fold Method
    "     z<(Down|UP)>    (Next|Previous)  Fold
    "     z<(Right|Left)> (Close|Open)     Fold
    "
    "     <C-p>     Fuzzy Finder
    "     <C-l>     Fuzzy Grep
    "     <C-/>     Toggle  (On|Off)   Search Highlight
    "     <Alt-.>   Execute last :cmd
    "     <Leader>. Execute last search/replace
    " 1>>>

    " Use bundles config <<<1
    if filereadable(expand('~/.vimrc.bundles'))
        source ~/.vimrc.bundles
    endif
    " 1>>>

    " Important Properties I <<<1
    let g:skip_defaults_vim = 1                 " disable defaults.vim
    " Used to identify a git repo
    let g:gitroot = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '[\n\r]', '', 'g')

    set termencoding=utf-8
    set encoding=utf-8
    scriptencoding utf-8
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
    filetype plugin indent on                              "  Enable file type detection and do language dependent indenting

    set mouse=a                                            "  Automatically enable mouse usage
    set mousehide                                          "  Hide the mouse cursor while typing

    set shortmess+=filmnrxoOtTI                            "  Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash        "  Better Unix / Windows compatibility
    set virtualedit=onemore                                "  Allow for cursor beyond last character

    set iskeyword-=.                                       "  '.' is an end of word
    set iskeyword-=#                                       "  '#' is an end of word
    set iskeyword-=-                                       "  '-' is an end of word
    set iskeyword+=@-@                                     "  @ which represent any characters that isalpha()
                                                           "  help isf

    set autowrite                                          "  Write the contents of the file, if it has been modified, on each
                                                           "  :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
                                                           "  :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
                                                           "  '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
    set autoread                                           "  Allow vim autoread everything

    set report=0                                           "  after yank/delete/... report number of lines affected
    set signcolumn=yes

    set timeout timeoutlen=1000                            "  Allow more time between keystrokes for some key mappings.
    set ttimeout ttimeoutlen=0                             "  But not for for key codes. Use a very small value for them.

    set completeopt=longest,menuone,preview
    set switchbuf=useopen,usetab                           "  Attempt to edit currently open files instead of opening multiple buf
    set hidden                                             "  Hide buffers when they are abandoned

    set wildmenu                                           "  enhanced command line completion
    set wildmode=list:longest:full                         "  complete files like a shell
    set scrolloff=5                                        "  lines of text around cursor
    set scrolljump=5                                       "  Lines to scroll when cursor leaves screen

    if has('cmdline_info')
        set ruler                                          "  Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) "  A ruler on steroids
        set showcmd                                        "  Show partial commands in status line and
                                                           "  Selected characters/lines in visual mode
        set cmdheight=1                                    "  command bar height
    endif

    set laststatus=2                                       "  Always show the status line
    set noshowmode                                         "  Disabled default showmode
    set number relativenumber                              "  Default relative number

    "https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
    set backspace=indent,eol,start                         " Backspace for dummies (vim has a different approach)
    " 1>>>

    " Searching <<<1
    set ignorecase                              " case insensitive searching
    set smartcase                               " case-sensitive if expresson contains a capital letter
    set hlsearch                                " highlight search match
    set incsearch                               " set incremental search, like modern browsers
    set magic                                   " Set magic on, for regex

    if executable('rg')
        set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
        set grepformat=%f:%l:%c:%m,%f:%l:%m
    endif

    " Performance Improving
    set regexpengine=1                          " revert to regexp engine v1
    set ttyfast                                 " Improves screen redraw"
    set lazyredraw                              " Avoid redrawing the screen mid-command."
    " 1>>>

    " Restore cursor to file position in previous editing session <<<1
    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    function! ResCur()
        if line("'\"") <= line('$')
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
            " Allow <C-u> recovery from a wrong motion in
            " the edit mode.
            " https://vi.stackexchange.com/questions/16773/how-to-undo-the-deletion-of-characters-in-insert-mode-caused-by-ctrl-u
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
            if exists('*mkdir')
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo 'Warning: Unable to create backup directory: ' . directory
                echo 'Try: mkdir -p ' . directory
            else
                let directory = substitute(directory, ' ', '\\\\ ', 'g')
                " the exec will execute:
                " set backup
                " set views
                " set swap
                " set undo
                exec 'set ' . settingname . '=' . directory
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
    if &term =~# '^xterm' || &term =~# '^screen' || &term =~# '^tmux'
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
    endif
    " 1>>>

    " Keyboard modifyOtherKeys <<<1
    " nowadays iterm2 only support in the beta version
        " let &t_TI = "\<Esc>[>4;2m"
        " let &t_TE = "\<Esc>[>4;m"
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
    if &term =~# '^xterm' || &term =~# '^screen' || &term =~# '^tmux'
        set t_Co=256                                          "  Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif

    if exists('+termguicolors')                               "  Only if compiled
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif

    set background=dark                                       "  Prefer Dark over Light

    if isdirectory(expand(bundles_dir . '/gruvbox-material'))
        let g:gruvbox_material_disable_italic_comment = 1     "  Disable support to italic, must be located before colorscheme
        let g:gruvbox_material_enable_italic = 0              "  Allow Italic fonts
        let g:gruvbox_material_background = 'hard'            "  Contrast Level
        colorscheme gruvbox-material                          "  Using the same color scheme
        let g:gruvbox_termcolors = 256                        "  Accepting the 256 colors
        let g:gruvbox_material_enable_bold = 1
        let g:gruvbox_material_diagnostic_line_highlight = 1
        let g:gruvbox_material_better_performance = 1
    endif
    " 1>>>

    " Alerts and feedback properties <<<1
    set noerrorbells
    set novisualbell
    set t_vb=                                           " Never Flash de Screen"
    " 1>>>

    " Spell properties <<<1
    set spelllang=en_us,pt
    set spellsuggest=best,10
    set spellfile=~/.vim/spell/local.utf-8.add          " local dictionary
    set complete+=kspell
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
    set complete-=i         " disable scanning included files
    set complete-=t         " disable searching tags
    " 1>>>

" 1>>>

" Misc <<<1

    " WhichKey - Map <<<1
    " The default leader is '\', but many people prefer ',' as it's in a standard
    set timeoutlen=500
    let g:mapleader=','
    let g:maplocalleader=' '

    if isdirectory(expand(bundles_dir . '/vim-which-key'))
        nnoremap <silent> <Leader>      :<c-u>WhichKey       ','<CR>
        vnoremap <silent> <leader>      :<c-u>WhichKeyVisual ','<CR>
        nnoremap <silent> <LocalLeader> :<c-u>WhichKey        '<Space>'<CR>
        vnoremap <silent> <LocalLeader> :<c-u>WhichKeyVisual  '<Space>'<CR>

        " Define prefix dictionary
        let g:which_key_leader_map = {}
        let g:which_key_leader_map.t = {'name': '+Toggle/Terminal/Table'}
        let g:which_key_leader_map.o = {'name': '+Open'}
        let g:which_key_leader_map.s = {'name': '+System/Session/Show'}
        let g:which_key_leader_map.g = {'name': '+Git'}
        let g:which_key_leader_map.w = {'name': '+Windows'}
        let g:which_key_leader_map.a = {'name': '+Align'}
        let g:which_key_leader_map.r = {'name': '+Replace'}

        let g:which_key_localleader_map = {}
        let g:which_key_localleader_map[' '] = {'name': 'Quick'}
        let g:which_key_localleader_map.q = {'name': 'QuickFix'}
        let g:which_key_localleader_map.l = {'name': 'LocationList'}

        call which_key#register(',',       'g:which_key_leader_map')
        call which_key#register('<Space>', 'g:which_key_localleader_map')
    endif
    " 1>>>

    " Startify <<<1
    if isdirectory(expand(bundles_dir . '/vim-startify'))
        let g:startify_session_dir         = '~/.vim/sessions'
        let g:startify_session_number      = 10
        let g:startify_session_sort        = 1
        let g:startify_relative_path       = 1
        let g:startify_change_to_dir       = 1
        let g:startify_fortune_use_unicode = 1
        let g:startify_files_number        = 8
        let g:startify_update_oldfiles     = 1
        let g:startify_session_persistence = 1

        let g:startify_skiplist = [
                \ 'COMMIT_EDITMSG',
                \ 'CONTRIBUTING.md',
                \ '/opt/vim',
                \ '^/tmp',
                \ ]

        let g:startify_bookmarks = [
                    \{'v': '~/.vimrc'},
                    \{'vb': '~/.vimrc.bundles'},
                    \{'z': '~/.zshrc'},
                    \{'t': '~/.tmux.conf'},
                    \]

        " unicode header to the fortune
        let g:startify_custom_header =
                    \startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')

        " start at 1 instead of 0
        let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

        " returns all modified files of the current git repo
        " `2>/dev/null` makes the command fail quietly, so that when we are not
        " in a git repo, the list will be empty
        function! s:gitModified()
            let files = systemlist('git ls-files -m 2>/dev/null')
            return map(files, "{'line': v:val, 'path': v:val}")
        endfunction

        " same as above, but show untracked files, honouring .gitignore
        function! s:gitUntracked()
            let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
            return map(files, "{'line': v:val, 'path': v:val}")
        endfunction

        let g:startify_lists = [
                \ { 'type': 'files',     'header': ['   MRU']            },
                \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
                \ { 'type': 'sessions',  'header': ['   Sessions']       },
                \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
                \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
                \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
                \ { 'type': 'commands',  'header': ['   Commands']       },
                \ ]

    endif
    " 1>>>

    " Show Invisible Chars <<<1
    set nolist                                          " default disable
    if &encoding =~# 'utf-8'
        set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵       " default unicode
        nnoremap <silent><unique> <Leader>tl :set list!<CR>
        let g:which_key_leader_map.t.l = 'ListCharsToggle'
    endif
    " 1>>>

    " Dealing with a long lines properties <<<1
    set wrap                                            " wrap long lines by default
    set whichwrap=b,s,h,l,<,>,[,]                       " Backspace and cursor keys wrap too
    set colorcolumn=100                                 " Use a colored column to mark textwidh
    set breakindent                                     " wrap with an indentation
    set breakindentopt=shift:2
    set showbreak=...
    " 1>>>

    " Vimdiff - Properties <<<1
    if &diff
        set diffopt+=iwhite
        if has('nvim-0.3.2') || has('patch-8.1.0360')
            set diffopt=internal,filler,algorithm:histogram,indent-heuristic,vertical
        endif
        function! IwhiteToggle()
            if &diffopt =~# 'iwhite'
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
                \ '*' : ["i'", 'i"', 'i)', 'i]', 'i}', 'ip'],
                \ 'html,xml' : ['at'],
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
    let g:which_key_leader_map.v = 'which_key_ignore'
    let g:which_key_leader_map['.'] = 'which_key_ignore'
    let g:which_key_leader_map['*'] = 'which_key_ignore'
    let g:which_key_leader_map['/'] = 'which_key_ignore'
    " 1>>>

    " System/Session/Show Menu<<<1
    " reload vim
    nnoremap <silent><unique><Leader>sr :source ~/.vimrc<CR>
    let g:which_key_leader_map.s.r = 'VimReload'
    " history of edited files
    nnoremap <silent><nowait><Leader>sh :History<cr>
    let g:which_key_leader_map.s.h = 'ShowHistoryList'
    " history of marks files
    nnoremap <silent><nowait><leader>sm <cmd>Marks<cr>
    let g:which_key_leader_map.s.m = 'ShowMarksList'
    " Show Maps files
    nnoremap <silent><nowait><leader>sM <cmd>Maps<cr>
    let g:which_key_leader_map.s.M = 'ShowMapsList'
    " Show Startify Menu
    nnoremap <silent><nowait><leader>st <cmd>Startify<cr>
    let g:which_key_leader_map.s.t = 'ShowStartify'
    " 1>>>

    " InsertMap <<<1
    "
    " Create new line
    " ino <C-Return> <Esc>o -it already working
    " Expands current file dir path
    ino <C-d> <C-R>=expand('%:p:h') . '/' <CR>
    " move right
    ino <C-f> <Right>
    " move left
    ino <C-b> <Left>
    " backspace one char
    ino <C-h> <BS>
    " go to the beginning of the line
    ino <C-a> <ESC>^i
    " go to the end of the line
    ino <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
    " 1>>>

    " Plugin: Whichkey map for <Leader><Leader> <<<1

    " Change to the directory of the edited file
    nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

    let g:which_key_leader_map[','] = {
     \ 'name': '+Quick',
     \  'x'  :[':ALEFix'                                     , 'ALEFix'                         ],
     \  'i'  :[':ALEInfoToClipboard'                         , 'ALEInfoToClipboard'             ],
     \ 'cd'  :[':cd %:p:h<CR>:pwd<CR>'                       , 'ChangeToFileDirectory'          ],
     \  'd'  :[':YcmCompleter GoToDefinitionElseDeclaration' , 'GoToDefinitionElseDeclaration'  ],
     \ }
    " 1>>>

    " Windows: Better split management, kept in sync with tmux' mappings <<<1
    let g:which_key_leader_map['w'] = {
      \ 'name' : '+Windows' ,
      \ 'w' : ['<C-W>w'         , 'other-window']          ,
      \ 'd' : ['<C-W>c'         , 'delete-window']         ,
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
      \ 'a' : ['<C-W>a'         , 'visual-selection-split-above']    ,
      \ 'b' : ['<C-W>s'         , 'visual-selection-split-below']    ,
      \ 'v' : ['<C-W>v'         , 'split-window-vertical'] ,
      \ 'V' : ['<C-W>s'         , 'split-window-horizontal'] ,
      \ '?' : ['Windows'        , 'fzf-window']            ,
      \ }
    " 1>>>

    " Toggle cursor line <<<1
    nnoremap <silent><unique> <Leader>tc :set cursorline!<CR>
    let g:which_key_leader_map.t.c = 'CursorLineToggle'
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
      \ 'name' : '+Buffers/Bookmark' ,
      \ '1' : ['b1'        , 'buffer-number']   ,
      \ '2' : ['b2'        , 'buffer-number']   ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ 'w' : ['bw'        , 'wipeout-buffer']  ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }
    " 1>>>

    " Map to move lines to bellow than current line <<<1
    "
    "TODO: Refactoring to suporte more than
    "2 chars, in a relative line number
    "by Reis
    function! MvLines()
        " This function receave 2 chars
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
    " mapping accent to allow use of vim marks
    nnoremap á 'a
    nnoremap à `a
    nnoremap é 'e
    nnoremap è `e
    nnoremap ç 'c
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
      \   '0' : 'fold-level',
      \   '1' : 'fold-level',
      \   '2' : 'fold-level',
      \   '3' : 'fold-level',
      \   '4' : 'fold-level',
      \   '5' : 'fold-level',
      \   '6' : 'fold-level',
      \   '7' : 'fold-level',
      \   '8' : 'fold-level',
      \   '9' : 'fold-level',
      \   'd' : 'FoldContextDecrease',
      \   'e' : 'FoldSearchEnd',
      \   'i' : 'FoldContextIncrease',
      \   'l' : 'FoldLast',
      \   'w' : 'FoldWord',
      \   's' : 'FoldSearch',
      \   'S' : 'FoldSpell',
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
    " using m register to allow jumplist
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
    noremap <Down> g<Down>
    noremap <Up> g<Up>
    " 1>>>

    " End/Start of line motion keys act relative to row/wrap width in the <<<1
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    function! WrapRelativeMotion(key, ...)
        let vis_sel=''
        if a:0
            let vis_sel='gv'
        endif
        if &wrap
            execute 'normal!' vis_sel . 'g' . a:key
        else
            execute 'normal!' vis_sel . a:key
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
    let g:filename_path = fnameescape(expand('%:h'))

    " verify if the path of the file currently edited exist
    " otherwise overwrite it
    if len(g:filename_path) == 0
        let g:filename_path = '.'
    endif

    cnoremap %% <C-R>=g:filename_path.'/'<CR>
    " open in a new buffer
    map <Leader>ob :e %%
    let g:which_key_leader_map.o.b = 'OpenNewBuffer'
    " open in a new horizontal window
    map <Leader>oh :sp %%
    let g:which_key_leader_map.o.h = 'OpenNewHorizontalWindow'
    " open in a new vertical window
    map <Leader>ov :vsp %%
    let g:which_key_leader_map.o.v = 'OpenNewVerticalWindow'
    " open in a new tab
    map <Leader>ot :tabe %%
    let g:which_key_leader_map.o.t = 'OpenNewTab'
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
    " by Reis
    nnoremap <Esc>. @:
    " 1>>>

    " Past Visual Select <<<1
    " by Reis
    vnoremap <silent><C-w>pt "+y \| :tabnew \| :normal p<CR>
    " 1>>>

    " QuickFix <<<1
    " Navigate between quickfix occurrences
    nnoremap <LocalLeader>qg :silent vimgrep<Space>
    nnoremap <LocalLeader>qo :copen 5<CR>
    nnoremap <LocalLeader>qc :cclose<CR>
    nnoremap <silent>[q :cp<CR>
    nnoremap <silent>]q :cn<CR>
    let g:which_key_localleader_map.q.g = 'QuickFixVimGrep'
    let g:which_key_localleader_map.q.o = 'QuickFixOpen'
    let g:which_key_localleader_map.q.c = 'QuickFixClose'
    " 1>>>

    " LocationList<<<1
    " Navigate between location list occurrences
    nnoremap <LocalLeader>lg :silent lvimgrep<Space>
    nnoremap <LocalLeader>lo :lopen 5<CR>
    nnoremap <LocalLeader>lc :lclose<CR>
    nnoremap <silent>[l :lprevious<CR>
    nnoremap <silent>]l :lnext<CR>
    let g:which_key_localleader_map.l.g = 'LocationVimGrep'
    let g:which_key_localleader_map.l.o = 'LocationOpen'
    let g:which_key_localleader_map.l.c = 'LocationClose'
    " 1>>>

" 1>>>

" Unmaps <<<1
" STOP the help from being so... HELPFULL ;)
inoremap <F1> <Esc>
nnoremap <F1> <Esc>
vnoremap <F1> <Esc>
" 1>>>

" Functions <<<1

    " Initialize NERDTree as needed <<<1
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, 'NERD_tree')
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
    let g:which_key_leader_map[','].s = 'SearchWord'
    let g:which_key_leader_map[','].S = 'SearchWordReverse'
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
    nnoremap <expr> [d KeepChanging('/')
    nnoremap <expr> ]d KeepChanging('?')
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

    let s:default_tw = &g:textwidth ? &g:textwidth : 100
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
    let g:which_key_leader_map.t.w = 'TextWidthToggle'

    " set textwidth to longest line current screen, or default
    nnoremap <leader>sw :<c-u>call <sid>ExpandTextWidth()<CR>
    let g:which_key_leader_map.s.w = 'ExpandTextWidth'
    " 1>>>

    " Profile<<<1
    " from junegunn
    function! s:profile(bang)
    if a:bang
        profile pause
        noautocmd qall
    else
        profile start /tmp/profile.log
        profile func *
        profile file *
    endif
    endfunction
    command! -bang Profile call s:profile(<bang>0)
    " 1>>>

    " Root <<<1
    " from junegunn
    function! s:root()
        if g:gitroot !=# ''
            execute 'lcd' g:gitroot
            echo 'Changed directory to: '.g:gitroot
        else
            echo 'Not in git repo'
        endif
    endfunction
    command! Root call s:root()
    nnoremap <silent> <Leader>gt :Root<CR>
    let g:which_key_leader_map.g.t = 'ChangeDir2GitTopLevel'
    " 1>>>

    " Google it / Feeling lucky<<<1
    " from junegunn
    function! s:goog(pat, lucky)
        " I had to the hard-coded the browser cmd because macOS open command does not work
        let browser = '/Applications/Firefox.app/Contents/MacOS/firefox -new-tab'
        let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
        let q = substitute(q, '[[:punct:] ]',
            \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
        call system(printf('%s "https://www.google.com/search?%sq=%s"',
                        \ browser, a:lucky ? 'btnI&' : '', q))
    endfunction

    nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
    let g:which_key_leader_map['?'] = 'Google it'
    nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>
    let g:which_key_leader_map['!'] = 'Google FL'
    xnoremap <leader>? "gy:call <SID>goog(@g, 0)<cr>gv
    xnoremap <leader>! "gy:call <SID>goog(@g, 1)<cr>gv
    " 1>>>

" 1>>>

"Plugins <<<1

    " Plugin: YCM properties <<<1
    if isdirectory(expand(bundles_dir . '/YouCompleteMe'))
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
        let g:which_key_leader_map[','].h = 'YCMHover'
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
        let g:UltiSnipsEditSplit = 'vertical'
        let g:ycm_enable_diagnostic_signs = 0
        let g:ycm_collect_identifiers_from_tags_files = 1
        "
        " Disable the neosnippet preview candidate window
        " When enabled, there can be too much visual noise
        " especially when splits are used.
        set completeopt-=preview
    endif
    " 1>>>

    " Plugin: IndentGuides properties <<<1
    if isdirectory(expand(bundles_dir . '/vim-indent-guides/'))
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
    if isdirectory(expand(bundles_dir . '/vim-airline/'))
        let g:airline_powerline_fonts = 1
        let g:airline_skip_empty_sections = v:true
        let g:bufferline_echo = 0
        let g:airline_highlighting_cache = 1
        if isdirectory(expand(bundles_dir . '/vim-airline-themes/'))
            let g:airline_extensions=['branch', 'localsearch', 'virtualenv', 'bufferline',
                        \             'hunks', 'quickfix', 'ale', 'tagbar', 'term',
                        \             'undotree', 'whitespace', 'wordcount', 'ycm', 'tabline']

            augroup AirlineExtensions
                autocmd!
                autocmd FileType csv if index(airline_extensions, &ft) < 0 | call add(airline_extensions, 'csv')
            augroup END
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
                " let g:airline_symbols.maxlinenr = ' '
                " let g:airline_symbols.linenr = '☰ '
                let g:airline_symbols.maxlinenr = '☰ '
                let g:airline_symbols.linenr = ' '
                let g:airline_symbols.modified = '+'
                let g:airline_symbols.notexists = 'Ɇ'
                let g:airline_symbols.paste = 'ρ'
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.space = ' '
                let g:airline_symbols.spell = ''
                let g:airline_symbols.whitespace = 'Ξ'
                let g:airline_symbols.colnr = '℅'
            endif
            let g:airline_section_z = airline#section#create(
                        \[
                        \'windowswap', 'obsession',
                        \'%#__accent_bold#%3p%%'.g:airline_symbols.space,
                        \'linenr', 'maxlinenr', g:airline_symbols.space,
                        \g:airline_right_alt_sep.'%#__accent_bold#%3v/%03{col("$")-1}'
                        \]
                        \)
        endif
    endif
    " 1>>>

    " Plugin: FZF (performs like CtrlP) <<<1
    if isdirectory(expand(bundles_dir . '/fzf/'))
        " https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
        function! RipgrepFzf(query, fullscreen)
            let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
            let initial_command = printf(command_fmt, shellescape(a:query))
            let reload_command = printf(command_fmt, '{q}')
            let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
            call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
        endfunction

        command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

        "Open a file fuzzy search for git repo
        if g:gitroot !=# ''
            nnoremap <C-p> :GFiles --cached --others --exclude-standard<CR>
        else
            "Open a file fuzzy search
            nnoremap <C-p> :Files<CR>
        endif

        "Open a content fuzzy search
        nnoremap <C-l> :RG<CR>
        "Open a line fuzzy search
        nnoremap gl :BLines<CR>
        "Open a word fuzzy search
        nnoremap <leader>* :RG <C-R><C-W><CR>
        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'sharp'  }  }
    endif
    " 1>>>

    " Plugin: Vim-Go properties <<<1
    if isdirectory(expand(bundles_dir . '/vim-go/'))
        let g:go_gopls_enabled = 1                  " force default engine
        let g:go_list_type = 'quickfix'
        let g:go_fmt_fail_silently = 0
        " Always use gopls
        let g:go_fmt_command = 'gopls'
        let g:go_imports_mode = 'gopls'
        let g:go_rename_command = 'gopls'
        " Auto formatting and importing
        let g:go_fmt_autosave = 1
        let g:go_imports_autosave = 1
        let g:go_auto_type_info = 1                 " Status line types/signatures
        let g:go_version_warning = 0
        let g:go_textobj_include_function_doc = 1
        let g:go_diagnostics_enabled = 1
        let g:go_snippet_engine = 'ultisnips'       " force engine to be ultisnips
        let g:go_code_completion_enabled = 0        " disable omnifunc
        let g:go_decls_mode = 'fzf'                 " force engine fzf
        let g:go_addtags_skip_unexported = 1
        " Enable Terminal
        let g:go_term_enabled = 1
        let g:go_term_mode = 'split'
        let g:go_term_reuse = 1
        let g:go_term_height= 10

        " Go syntax highlighting
        let g:go_highlight_fields = 1
        let g:go_highlight_methods = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_function_calls = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_structs = 1
        let g:go_highlight_interfaces = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_space_tab_error = 1
        let g:go_highlight_array_whitespace_error = 1
        let g:go_highlight_trailing_whitespace_error = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_chan_whitespace_error = 1
        let g:go_highlight_space_tab_error = 1
    endif
    " 1>>>

    " Plugin: GitGutter properties <<<1
    if isdirectory(expand(bundles_dir . '/vim-gitgutter/'))
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
        let g:gitgutter_grep = 'rg'
        set foldtext=gitgutter#fold#foldtext()
        map ghs :GitGutterStageHunk<CR>
        map ghu :GitGutterUndoHunk<CR>
        map ghf :GitGutterFold<CR>
        nmap ghp <Plug>(GitGutterPreviewHunk)
        nmap ]h <Plug>(GitGutterNextHunk)
        nmap [h <Plug>(GitGutterPrevHunk)
        let g:gitgutter_preview_win_floating = 1
    endif
    " 1>>>

    " Plugin: Vim-ALE properties <<<1
    if isdirectory(expand(bundles_dir . '/ale/'))
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
        let g:ale_linters = {
                    \   'markdown':  ['vale'],
                    \   'text':      ['vale']
                    \}
        let g:ale_fixers = {
                    \'*': ['remove_trailing_lines', 'trim_whitespace']
                    \}
        let g:ale_echo_msg_format = '[%linter%:%code%:%severity%] %s'
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_sign_error = '✘'
        let g:ale_sign_warning = '⚠'
        nmap <silent> <C-k> <Plug>(ale_previous_wrap)
        nmap <silent> <C-j> <Plug>(ale_next_wrap)
    endif
    " 1>>>

    " Plugin: EditorConfig properties <<<1
    if isdirectory(expand(bundles_dir . '/editorconfig-vim/'))
        let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
        let g:EditorConfig_verbose = 0
        augroup EditorConfig
        autocmd!
        autocmd FileType gitcommit let b:EditorConfig_disable = 1
        augroup END
    endif
    " 1>>>

    " Plugin: Session List <<<1
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    if isdirectory(expand(bundles_dir . '/sessionman.vim/'))
        nnoremap <silent><Leader>sl :SessionList<CR><CR>
        let g:which_key_leader_map.s.l = 'ShowSessionList'
        "
        nnoremap <silent><Leader>ss :SessionSave<CR>
        let g:which_key_leader_map.s.s = 'SessionSave'
        "
        nnoremap <silent><Leader>sc :SessionClose<CR><CR>
        let g:which_key_leader_map.s.c = 'SessionClose'
    endif
    " 1>>>

    " Plugin: UndoTree properties <<<1
    if isdirectory(expand(bundles_dir . '/undotree/'))
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
    if isdirectory(expand(bundles_dir . '/nerdtree'))
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
    if isdirectory(expand(bundles_dir . '/tagbar/'))
        nnoremap <silent> <F3> :TagbarToggle<CR>
        let g:tagbar_left=0
        let g:tagbar_autofocus=1
        let g:tagbar_compact=1
        let g:tagbar_autoclose=1
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        if g:gitroot !=# ''
            let &tags = &tags . ',' . g:gitroot . '/.git/tags'
        endif
    endif
    " 1>>>

    " Plugin: Rainbow <<<1
    if isdirectory(expand(bundles_dir . '/rainbow/'))
        let g:rainbow_active = 1                        " 0 if you want to enable it later via :RainbowToggle
    endif
    " 1>>>

    " Plugin: Fugitive <<<1
    if isdirectory(expand(bundles_dir . '/vim-fugitive/'))
        nnoremap <silent> <Leader>gs :Git status<CR>
        let g:which_key_leader_map.g.s = 'status'
        "
        nnoremap <silent> <Leader>gd :Git diff<CR>
        let g:which_key_leader_map.g.d = 'diff'
        "
        nnoremap <silent> <Leader>gc :Git commit<CR>
        let g:which_key_leader_map.g.c = 'commit'
        "
        nnoremap <silent> <Leader>gb :Git blame<CR>
        let g:which_key_leader_map.g.b = 'blame'
        "
        nnoremap <silent> <Leader>gl :Git log<CR>
        let g:which_key_leader_map.g.l = 'log'
        "
        nnoremap <silent> <Leader>gP :Git push<CR>
        let g:which_key_leader_map.g.P = 'push'
        "
        nnoremap <silent> <Leader>gp :Git pull<CR>
        let g:which_key_leader_map.g.p = 'pull'
        "
        nnoremap <silent> <Leader>gr :Gread<CR>
        let g:which_key_leader_map.g.r = 'Gread'
        "
        nnoremap <silent> <Leader>gR :Git pull-request<CR>
        let g:which_key_leader_map.g.R = 'pull-request'
        "
        nnoremap <silent> <Leader>gF :Git fetch<CR>
        let g:which_key_leader_map.g.F = 'fetch'
        "
        nnoremap <silent> <Leader>gw :Gwrite<CR>
        let g:which_key_leader_map.g.w = 'Gwrite'
        "
        nnoremap <silent> <Leader>ge :Gedit<CR>
        let g:which_key_leader_map.g.e = 'Gedit'
        "
        nnoremap <silent> <Leader>ga :Git add -p .<CR>
        let g:which_key_leader_map.g.a = 'add -p .'
        "
        nnoremap <silent> <Leader>gv :GV<CR>
        let g:which_key_leader_map.g.v = 'GitBrowser'
        "
        nnoremap <silent> <Leader>gf :GV!<CR>
        let g:which_key_leader_map.g.f = 'GitBrowserThisFile'
    endif
    " 1>>>

    " Plugin: Better-WhiteSpace <<<1
    if isdirectory(expand(bundles_dir . '/vim-better-whitespace/'))
        nnoremap ]w :NextTrailingWhitespace<CR>
        nnoremap [w :PrevTrailingWhitespace<CR>
        let g:strip_whitespace_on_save = 1
        let g:strip_whitespace_confirm = 1
        let g:strip_whitelines_at_eof  = 1
    endif
    " 1>>>

    " Plugin: LocalSearch <<<1
    if isdirectory(expand(bundles_dir . '/vim-localsearch/'))
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
    if isdirectory(expand(bundles_dir . '/vim-repl/'))
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
        let g:repl_output_copy_to_register = 't'
        let g:sendtorepl_invoke_key = ''
        let g:repl_position = 3
        let g:repl_python_auto_import = 0
    endif
    " 1>>>

    " Plugin: MarkerText <<<1
    let g:SignatureMarkerTextHLDynamic=1
    " 1>>>

    " Plugin: NERDCommenter <<<1
    if isdirectory(expand(bundles_dir . '/nerdcommenter/'))
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
    if isdirectory(expand(bundles_dir . '/vim-sneak/'))
        let g:sneak#label = 1
        map <Leader><Leader>f <Plug>Sneak_s
        map <Leader><Leader>F <Plug>Sneak_S
        let g:which_key_leader_map[','].f = 'Sneak_s'
        let g:which_key_leader_map[','].F = 'Sneak_S'
    endif
    " 1>>>

    " Plugin: Vim-FloatTerm <<<1
    if isdirectory(expand(bundles_dir . '/vim-floaterm/'))
        let g:floaterm_keymap_new    = '<Leader>tn'
        let g:floaterm_keymap_prev   = '[t'
        let g:floaterm_keymap_next   = ']t'
        let g:floaterm_keymap_toggle = '<Leader>tt'
        let g:floaterm_keymap_kill   = '<Leader>tk'
        let g:floaterm_width    = 0.9
        let g:floaterm_height   = 0.9
        let g:floaterm_position = 'center'
        let g:floaterm_autoclose = 2

        let g:which_key_leader_map.t.n = 'TerminalNew'
        let g:which_key_leader_map.t.t = 'TerminalToggle'
        let g:which_key_leader_map.t.k = 'TerminalKill'
    endif
    " 1>>>

    " Plugin: Vim-Bookmark <<<1
    if isdirectory(expand(bundles_dir . '/vim-bookmarks/'))
        let g:bookmark_no_default_key_mappings = 1
        let g:bookmark_auto_save = 1
        let g:bookmark_auto_save_file = $HOME .'/.vim/.'. $USER .'-bookmarks'

        nnoremap <Leader>bt :BookmarkToggle<CR>
        nnoremap <Leader>ba :BookmarkAnnotate<CR>
        nnoremap <Leader>bs :BookmarkShowAll<CR>
        nnoremap <Leader>bN :BookmarkNext<CR>
        nnoremap <Leader>bP :BookmarkPrev<CR>
        nnoremap <Leader>bc :BookmarkClear<CR>
        nnoremap <Leader>bx :BookmarkClearAll<CR>
        nnoremap <Leader>bU :BookmarkMoveUp<CR>
        nnoremap <Leader>bD :BookmarkMoveDown<CR>
        nnoremap <Leader>bg :BookmarkMoveToLine<CR>

        let g:which_key_leader_map.b.t = 'toggle-bookmark'
        let g:which_key_leader_map.b.a = 'annotate-bookmark'
        let g:which_key_leader_map.b.s = 'show-all-Bookmark'
        let g:which_key_leader_map.b.N = 'next-bookmark'
        let g:which_key_leader_map.b.P = 'prev-bookmark'
        let g:which_key_leader_map.b.c = 'clear-bookmark'
        let g:which_key_leader_map.b.x = 'clear-all-bookmark'
        let g:which_key_leader_map.b.U = 'move-up-bookmark'
        let g:which_key_leader_map.b.D = 'move-down-bookmark'
        let g:which_key_leader_map.b.g = 'move-to-line-bookmark'
    endif
    " 1>>>

    " Plugin: Vim-Pythonsense <<<1
    if isdirectory(expand(bundles_dir . '/vim-pythonsense/'))
        let g:is_pythonsense_alternate_motion_keymaps = 1
        let g:is_pythonsense_suppress_location_keymaps = 1
    endif
    " 1>>>

    " Plugin: Vim-Move <<<1
    if isdirectory(expand(bundles_dir . '/vim-move/'))
        let g:move_map_keys = 1
        let g:move_past_end_of_line = 1
        vmap j <Plug>MoveBlockDown
        vmap k <Plug>MoveBlockUp
        vmap h <Plug>MoveBlockLeft
        vmap l <Plug>MoveBlockRight
    endif
    " 1>>>

    " Plugin: Vim-Matchup <<<1
    if isdirectory(expand(bundles_dir . '/vim-matchup/'))
        let g:loaded_matchit = 0
        let g:matchup_matchparen_enabled = 0
        let g:matchup_text_obj_enabled = 1
    endif
    " 1>>>

    " Plugin: Vim-VisualSplit <<<1
    if isdirectory(expand(bundles_dir . '/visual-split.vim/'))
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
    if isdirectory(expand(bundles_dir . '/NrrwRgn/'))
        let g:which_key_leader_map.r.n = 'ReplaceInNarrowedWindow'
        xmap <Leader>rn <Plug>NrrwrgnDo
    endif
    " 1>>>

    " Plugin: Vim-autopair <<<1
    if isdirectory(expand(bundles_dir . '/auto-pairs/'))
        let g:AutoPairsShortcutToggle = '<Leader>tp'
        let g:which_key_leader_map.t.p = 'AutoPairToggle'
    endif
    " 1>>>

    " Plugin: Vim-tabularize <<<1
    if isdirectory(expand(bundles_dir . '/tabular/'))
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a; :Tabularize /;<CR>
        vmap <Leader>a; :Tabularize /;<CR>
        nmap <Leader>a\| :Tabularize /\|<CR>
        vmap <Leader>a\| :Tabularize /\|<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
    endif
    " 1>>>

    " Plugin: Vim-gutentags <<<1
    if isdirectory(expand(bundles_dir . '/vim-gutentags/'))
        " enable gtags module
        let g:gutentags_modules = ['ctags']

        " config project root markers.
        let g:gutentags_project_root = ['.git']

        " Make tags placed in .git/tags file available in all levels of a repository
        set tags^=.git/tags;
        let g:gutentags_ctags_tagfile = '.git/tags'

        " change focus to quickfix window after search (optional).
        let g:gutentags_plus_switch = 1

        " generating tags when
        let g:gutentags_generate_on_new = 1
        let g:gutentags_generate_on_missing = 1
        let g:gutentags_generate_on_write = 1
        let g:gutentags_generate_on_empty_buffer = 0

        " Adding a ctags_ignore
        let ctags_ignore_param = ''
        let ctagsignore_file = '.ctagsignore'

        if filereadable(expand(ctagsignore_file))
            let ctags_ignore_param = '--exclude=@.ctagsignore'
        endif

        " YCM compatibility and ignore
        let g:gutentags_ctags_extra_args = [
                    \ '--tag-relative=yes',
                    \ '--fields=+ailmnS',
                    \ ctags_ignore_param,
                    \ ]
        " disable predefined map
        let g:gutentags_plus_nomap = 1

        let g:gutentags_ctags_exclude = [
              \ '*.git', '*.svg', '*.hg',
              \ '*/tests/*',
              \ 'build',
              \ 'dist',
              \ '*sites/*/files/*',
              \ 'bin',
              \ 'node_modules',
              \ 'bower_components',
              \ 'cache',
              \ 'compiled',
              \ 'docs',
              \ 'example',
              \ 'bundle',
              \ 'vendor',
              \ '*.md',
              \ '*-lock.json',
              \ '*.lock',
              \ '*bundle*.js',
              \ '*build*.js',
              \ '.*rc*',
              \ '*.json',
              \ '*.min.*',
              \ '*.map',
              \ '*.bak',
              \ '*.zip',
              \ '*.pyc',
              \ '*.class',
              \ '*.sln',
              \ '*.Master',
              \ '*.csproj',
              \ '*.tmp',
              \ '*.csproj.user',
              \ '*.cache',
              \ '*.pdb',
              \ 'tags*',
              \ 'cscope.*',
              \ '*.css',
              \ '*.less',
              \ '*.scss',
              \ '*.exe', '*.dll',
              \ '*.mp3', '*.ogg', '*.flac',
              \ '*.swp', '*.swo',
              \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
              \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
              \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
              \ ]

    endif
    " 1>>>

    " Plugin: Vim-docker <<<1
    if isdirectory(expand(bundles_dir . '/docker.vim/'))
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
    if isdirectory(expand(bundles_dir . '/docker-compose.vim/'))
        " open terminal way
        let g:docker_compose_open_terminal_way = 'top'
    endif
    " 1>>>

    " Plugin: Vim-Test <<<1
    if isdirectory(expand(bundles_dir . '/vim-test/'))
        let g:test#preserve_screen = 1
        let test#strategy = 'vimterminal'
        let test#python#runner = 'pytest'
        nmap <silent> t<C-n> :TestNearest<CR>
        nmap <silent> t<C-f> :TestFile<CR>
        nmap <silent> t<C-a> :TestSuite<CR>
        nmap <silent> t<C-l> :TestLast<CR>
        nmap <silent> t<C-v> :TestVisit<CR>
    endif
    " 1>>>

    " Plugin: Vim-Preview <<<1
    if isdirectory(expand(bundles_dir . '/vim-preview/'))
        noremap <LocalLeader><LocalLeader>t :PreviewTag<CR>
        noremap <LocalLeader><LocalLeader>s :PreviewSignature!<CR>
        inoremap <LocalLeader><LocalLeader>s <c-\><c-o>:PreviewSignature!<CR>
    endif
    " 1>>>

    " Plugin: Vim-Minimap<<<1
    if isdirectory(expand(bundles_dir . '/minimap.vim/'))
        let g:minimap_width = '20'
        let g:minimap_highlight = 'MinimapCurrentLine'
        hi MinimapCurrentLine ctermfg=Green guifg=#50FA7B guibg=#32302f
        nnoremap <F4> :MinimapToggle<CR>
    endif
    " 1>>>

    " Plugin: Vim-Doge<<<1
    if isdirectory(expand(bundles_dir . '/vim-doge/'))
        let g:doge_doc_standard_python = 'sphinx'
        let g:doge_enable_mappings = 0
        let g:doge_python_settings = {
                    \'single_quotes': 0
                    \}
        nnoremap <LocalLeader><LocalLeader>d :DogeGenerate<CR>
    endif
    " 1>>>

    " Plugin: Vim-QuickScope<<<1
    if isdirectory(expand(bundles_dir . '/quick-scope/'))
        let g:qs_buftype_blacklist = ['terminal', 'nofile']
        let g:qs_lazy_highlight = 1
        let g:qs_second_highlight = 0
        " Trigger a highlight in the appropriate direction when pressing these keys:
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
        nmap <Leader>tq <plug>(QuickScopeToggle)
        xmap <Leader>tq <plug>(QuickScopeToggle)
        let g:which_key_leader_map.t.q = 'QuickScopeToggle'
    endif
    " 1>>>

    " Plugin: Vim-Visual-Multi<<<1
    if isdirectory(expand(bundles_dir . '/vim-visual-multi/'))
        let g:VM_default_mappings = 0
    endif
    " 1>>>

    " Plugin: CamelCaseMotion<<<1
    if isdirectory(expand(bundles_dir . '/CamelCaseMotion/'))
        let g:camelcasemotion_key = '<Leader><Leader>'
        map <Leader><Leader>E <Plug>CamelCaseMotion_ge
        let g:which_key_leader_map[','].w = 'CamelCaseMotion_w'
        let g:which_key_leader_map[','].b = 'CamelCaseMotion_b'
        let g:which_key_leader_map[','].e = 'CamelCaseMotion_e'
        let g:which_key_leader_map[','].E = 'CamelCaseMotion_ge'
        let g:which_key_leader_map[','].g = { 'name': 'which_key_ignore' }
    endif
    " 1>>>

    " Plugin: TableMode<<<1
    if isdirectory(expand(bundles_dir . '/vim-table-mode/'))
        let g:table_mode_corner='|'
        let g:which_key_leader_map.t.m = 'TableModeToggle'
        let g:which_key_leader_map.t['?'] = 'TableModeEchoCell'
        let g:which_key_leader_map.t.iC = 'TableModeInsertColumnBefore'
        let g:which_key_leader_map.t.r = 'TableModeRealign'
        let g:which_key_leader_map.t.s = 'TableModeSort'
        let g:which_key_leader_map.t.d = {'name': 'TableModeDelete'}
        let g:which_key_leader_map.t.d.c = 'TableModeDeleteColumn'
        let g:which_key_leader_map.t.d.d = 'TableModeDeleteRow'
        let g:which_key_leader_map.t.f = {'name': 'TableModeFormula'}
        let g:which_key_leader_map.t.f.a = 'TableModeFormulaAdd'
        let g:which_key_leader_map.t.f.d = 'TableModeFormulaEval'
    endif
    " 1>>>

    " Plugin: Vim-JsonPath<<<1
    if isdirectory(expand(bundles_dir . '/vim-jsonpath/'))
        " Optionally copy path to a named register (* in this case) when calling :JsonPath
        let g:jsonpath_register = '*'

        " Define mappings for json buffers
        augroup vim_json_path
            autocmd!
            autocmd FileType json noremap <buffer> <silent> <leader><leader>g :call jsonpath#echo()<CR>
            autocmd FileType json noremap <buffer> <silent> <leader><leader>d :call jsonpath#goto()<CR>
        augroup END
    endif
    " 1>>>
" 1>>>

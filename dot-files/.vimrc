set encoding=utf-8
scriptencoding utf-8

set nocompatible

" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " Display
    Plugin 'khaveesh/vim-fish-syntax'
    Plugin 'Yggdroot/indentLine'

    " Behaviour
    Bundle 'matze/vim-move'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'tpope/vim-surround'
    " Move to fzf ?
    Plugin 'https://github.com/ctrlpvim/ctrlp.vim'

    " Completion and Debug
    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'puremourning/vimspector'

    " Load as very last one
    Plugin 'ryanoasis/vim-devicons'

    "Plugin 'morhetz/gruvbox'
call vundle#end()

" Plugins/YCM
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = { 'VimspectorPrompt': [ '.', '->', ':', '<' ] }
let g:ycm_clangd_args = ['--header-insertion=never']

" Plugins/vim-cpp-modern
let g:cpp_function_highlight = 1
let g:cpp_attribute_highlight = 1
let g:cpp_member_highlight = 1
"let g:cpp_simple_highlight = 1

" Plugins/CtrlP
let g:ctrlp_show_hidden = 1

" Plugins/gruvbox
"let g:gruvbox_italic='1'
"let g:gruvbox_transparent_bg='1'

" Indentation
set sw=4 sts=4 ts=4 expandtab
set nosmartindent
set cindent noautoindent
set cinoptions=l1,g0

set backspace=indent,eol,start
set whichwrap+=h,l
set completeopt=menu,preview
set clipboard=

" Search
set hlsearch
set incsearch
set smartcase ignorecase

" Window
set splitbelow splitright
set termwinsize=12x0

autocmd TerminalWinOpen *
    \ if &buftype == 'terminal' |
    \     setlocal nobuflisted |
    \     setlocal nowrap |
    \     set wfh |
    \ endif

" Behaviour
set mouse=a
set nohidden
set nowrap
set sidescroll=5
set scrolloff=1
set showmatch
set nostartofline
set nojoinspaces
set wildmenu
set wildmode=list:longest

" Display
set relativenumber
set numberwidth=3
set ruler
set showmode
set showcmd
set colorcolumn=100
set laststatus=2

set list
set listchars=tab:→\ ,space:·,eol:¬

set shortmess=a
set statusline=\ %<%f\ %y%m%r%=%(%l/%L,%c%)

set background=dark
set termguicolors
set t_Co=256
colorscheme cyberpunk-neon

" Terminal title set to file name
set title
set titlestring=%t
set titleold=

" Don't timeout incomplete commands
set notimeout ttimeout ttimeoutlen=0

" Syntax highlighting
syntax on
filetype on
filetype indent on
filetype plugin on

" Shortcuts
map <Tab> :bn<CR>
map <S-Tab> :bp<CR>

if has('macunix')
    " <Leader>o
    nmap ø o<Esc>0"_D
    " <Leader>O
    nmap Ø O<Esc>0"_D

    " <Leader>s
    nmap ß <Esc>:w<CR>
    " <Leader>w
    nmap ∑ <Esc>:bd!<CR>

    " <Leader>h
    nmap ª :tabp<CR>
    " <Leader>l
    nmap ¬ :tabn<CR>

    " <Leader>k
    nmap ∆ <Plug>MoveLineUp
    " <Leader>j
    nmap º <Plug>MoveLineDown

    vmap ª <Plug>MoveBlockLeft
    vmap ∆ <Plug>MoveBlockUp
    vmap º <Plug>MoveBlockDown
    vmap ¬ <Plug>MoveBlockRight
else
    " Took me a while to figure out why my terminal wouldn't let me use the Alt key
    " I used 'sed -n l' to find out what char my terminal (tilix) was sending
    execute "set <M-o>=o"
    execute "set <M-O>=O"
    execute "set <M-s>=s"
    execute "set <M-w>=w"
    nmap <Leader>o o<Esc>0"_D
    nmap <Leader>O O<Esc>0"_D
    nmap <Leader>s <Esc>:w<CR>
    nmap <Leader>w <Esc>:bd!<CR>

    execute "set <M-h>=h"
    execute "set <M-k>=k"
    execute "set <M-j>=j"
    execute "set <M-l>=l"
    nmap <Leader>h :tabp<CR>
    nmap <Leader>l :tabn<CR>

    nmap <Leader>k <Plug>MoveLineUp
    nmap <Leader>j <Plug>MoveLineDown

    vmap <Leader>h <Plug>MoveBlockLeft
    vmap <Leader>l <Plug>MoveBlockRight
    vmap <Leader>k <Plug>MoveBlockUp
    vmap <Leader>j <Plug>MoveBlockDown

    execute "set <Home>=OH"
    execute "set <End>=OF"
    map <Home> 0
    map <End> $
endif

" Apparently this has to be at the end
set exrc secure


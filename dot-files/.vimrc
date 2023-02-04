set encoding=utf8

set exrc
set secure
set nocompatible
set mouse=a
set hidden

set number
set nowrap

set showmode
set showcmd

set hlsearch
set incsearch
set showmatch

set colorcolumn=

set wildmenu
set wildmode=list:longest

set listchars=tab:→\ ,space:·,eol:¬
set list

set sw=4 sts=4 ts=4 expandtab
set autoindent
set smartindent

set backspace=indent,eol,start
set whichwrap+=h,l

set termwinsize=12x0
set splitbelow

filetype off

let g:polyglot_disabled = ['fish']

if &shell =~# 'fish$'
    set shell=sh
endif

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'ryanoasis/vim-devicons'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'khaveesh/vim-fish-syntax'
    Plugin 'bfrg/vim-cpp-modern'

    Bundle 'matze/vim-move'
    Plugin 'derekwyatt/vim-fswitch'
    Plugin 'qpkorr/vim-bufkill'

    Plugin 'jiangmiao/auto-pairs'
    Plugin 'tpope/vim-surround'

    Plugin 'Yggdroot/indentLine'
    Plugin 'powerline/powerline',{'rtp':'powerline/bindings/vim/'}

    Plugin 'preservim/nerdtree'
    Plugin 'Xuyuanp/nerdtree-git-plugin'

    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'puremourning/vimspector'

    "Plugin 'morhetz/gruvbox'

call vundle#end()

filetype plugin indent on

"let g:gruvbox_italic='1'
"let g:gruvbox_transparent_bg='1'

syntax on
set background=dark
colorscheme cyberpunk-neon
set termguicolors

set laststatus=2

let NERDTreeShowLineNumbers=0
let NERDTreeWinPos="left"
let NERDTreeWinSize=30

au! BufEnter *.cpp let b:fswitchdst='hpp,h'
au! BufEnter *.h let b:fswitchdst='cpp,c'
au! BufEnter *.hpp let b:fswitchdst='cpp'

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

if has('macunix')
    nnoremap ø o<Esc>0"_D
    nnoremap Ø O<Esc>0"_D

    nmap ª <Plug>MoveLineLeft
    nmap ∆ <Plug>MoveLineUp
    nmap º <Plug>MoveLineDown
    nmap ¬ <Plug>MoveLineRight

    vmap ª <Plug>MoveBlockLeft
    vmap ∆ <Plug>MoveBlockUp
    vmap º <Plug>MoveBlockDown
    vmap ¬ <Plug>MoveBlockRight
else
    " Took me a while to figure out why my terminal wouldn't let me use the Alt key
    " I used 'sed -n l' to find out what char my terminal (tilix) was sending
    execute "set <M-o>=o"
    execute "set <M-O>=O"
    nnoremap <Leader>o o<Esc>0"_D
    nnoremap <Leader>O O<Esc>0"_D

    execute "set <M-h>=h"
    execute "set <M-k>=k"
    execute "set <M-j>=j"
    execute "set <M-l>=l"
    nmap <Leader>h <Plug>MoveLineLeft
    nmap <Leader>k <Plug>MoveLineUp
    nmap <Leader>j <Plug>MoveLineDown
    nmap <Leader>l <Plug>MoveLineRight

    vmap <Leader>h <Plug>MoveBlockLeft
    vmap <Leader>k <Plug>MoveBlockUp
    vmap <Leader>j <Plug>MoveBlockDown
    vmap <Leader>l <Plug>MoveBlockRight

    execute "set <Home>=OH"
    execute "set <End>=OF"
    map <Home> 0
    map <End> $
endif

let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = { 'VimspectorPrompt': [ '.', '->', ':', '<' ] }
let g:ycm_clangd_args = ['--header-insertion=never']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


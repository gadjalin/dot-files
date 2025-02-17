set encoding=utf-8
scriptencoding utf-8

set nocompatible

let g:mapleader=","

" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " --- Display ---
    " Powerline
    Plugin 'itchyny/lightline.vim'
    Plugin 'itchyny/vim-gitbranch'
    " Shows indentation levels
    Plugin 'Yggdroot/indentLine'

    " --- Behaviour --- 
    Bundle 'matze/vim-move'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'tpope/vim-surround'
    " Alignment operator
    Plugin 'tommcdo/vim-lion'
    " Fuzzy finder
    Plugin 'ctrlpvim/ctrlp.vim'

    " --- Syntax --- 
    Plugin 'khaveesh/vim-fish-syntax'
    Plugin 'sheerun/vim-polyglot'

    " --- Completion and Debug ---
    Plugin 'ycm-core/YouCompleteMe'
    "Plugin 'prabirshrestha/vim-lsp'
    " Integrated debugger
    Plugin 'puremourning/vimspector'

    " --- Colorschemes ---
    Plugin 'morhetz/gruvbox'

    " --- Load as very last one ---
    Plugin 'ryanoasis/vim-devicons'
call vundle#end()

" Plugins/lightline
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'gitbranch' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'filetype' ],
            \              [ 'fileformat' ] ]
            \ },
            \ 'component_function': {
            \   'filename': 'LightlineFilename',
            \   'gitbranch': 'gitbranch#name',
            \ },
            \ 'component': {
            \   'lineinfo': '%(%l/%L,%c%)',
            \ },
            \ }

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filename . modified
endfunction

" Plugins/YCM
let g:ycm_always_populate_location_list = 1 " See list of errors in location list (:lopen :lclose)
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers = { 'VimspectorPrompt': [ '.', '->', ':', '<' ] } " Vimspector integration
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" YCM Clang/Server settings
let g:ycm_clangd_binary_path = '/opt/homebrew/opt/llvm/bin/clangd'
let g:ycm_clangd_args = [ '--header-insertion=never', '--query-driver=/usr/bin/gcc' ]
let g:ycm_confirm_extra_conf = 0

let g:ycm_language_server = []
let g:ycm_language_server =
    \ [
    \   { 'name': 'fortls',
    \     'cmdline': [ 'fortls', '--hover_language', 'fortran95', '--notify_init', '--hover_signature', '--use_signature_help', '--lowercase_intrinsics' ],
    \     'filetypes': [ 'fortran' ]
    \   },
    \ ]
nnoremap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
nnoremap <leader>yfd <Plug>(YCMFindSymbolInDocument)
nnoremap <leader>gt :YcmCompleter GoTo<CR>

" Plugins/vim-cpp-modern (Installed separately from Vundle)
let g:cpp_function_highlight = 1
let g:cpp_attribute_highlight = 1
let g:cpp_member_highlight = 1
"let g:cpp_simple_highlight = 1

" Plugins/CtrlP
let g:ctrlp_show_hidden = 1

" Plugins/gruvbox
let g:gruvbox_italic='1'
let g:gruvbox_transparent_bg='1'

" Display
set background=dark
set termguicolors
set t_Co=256
colorscheme gruvbox

" Position
set number
set relativenumber
set numberwidth=3
set ruler

set showmode
set showcmd
set colorcolumn=100,132 " 132 is Fortran limit
set cursorline

" Other displays
set list
set listchars=tab:→\ ,space:·,eol:¬
set cmdheight=1
set shortmess=a
set signcolumn=yes

" Status line
set laststatus=2
"set statusline=\ %<%f\ %y%m%r%=%(%l/%L,%c%)

" Indentation
set sw=4 sts=4 ts=4 expandtab
set nosmartindent
set cindent noautoindent
set cinoptions=l1,g0

" Cursor
set backspace=indent,eol,start
set whichwrap+=h,l
set completeopt=menu,preview
set clipboard=

" Search
set hlsearch
set incsearch
set smartcase
set ignorecase

" Window
set splitbelow splitright
set termwinsize=12x0

" Make terminal not appear in the buffer list
" So that I don't have to worry when I cycle through buffers
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
filetype plugin indent on

" Must come after filetype
set tw=79
set fo=crlj

" Shortcuts
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>

nmap S :w<CR>
nmap Q :q<CR>

"map sl :set splitright<CR>:vsplit<CR>
"map sh :set nosplitright<CR>:vsplit<CR>
"map sj :set splitbelow<CR>:split<CR>
"map sk :set nosplitbelow<CR>:split<CR>

if has('macunix')
    " <A-o>
    "nnoremap ø o<Esc>0"_D
    " <A-O>
    "nnoremap Ø O<Esc>0"_D

    " <A-k>
    "nnoremap ∆ <Plug>MoveLineUp
    " <A-j>
    "nnoremap º <Plug>MoveLineDown

    " <A-h>
    "vnoremap ª <Plug>MoveBlockLeft
    " <A-k>
    "vnoremap ∆ <Plug>MoveBlockUp
    " <A-j>
    "vnoremap º <Plug>MoveBlockDown
    " <A-l>
    "vnoremap ¬ <Plug>MoveBlockRight
else
    " FIXME: Update May 2023: Weird things going on with Gnome 44 and keymapping,
    " generating accentuated characters. It still not working exactly properly
    " though

    " Took me a while to figure out why my terminal wouldn't let me use the Alt key
    " I used 'sed -n l' to find out what char my terminal (tilix) was sending
    "execute "set <A-o>=o"
    "execute "set <A-O>=O"
    "nmap <A-o> o<Esc>0"_D
    "nmap <A-O> O<Esc>0"_D
    "execute "set <A-h>=h"
    "execute "set <A-k>=k"
    "execute "set <A-j>=j"
    "execute "set <A-l>=l"

    "nmap <A-k> <Plug>MoveLineUp
    "nmap <A-j> <Plug>MoveLineDown

    "vmap <A-h> <Plug>MoveBlockLeft
    "vmap <A-l> <Plug>MoveBlockRight
    "vmap <A-k> <Plug>MoveBlockUp
    "vmap <A-j> <Plug>MoveBlockDown

    execute "set <Home>=OH"
    execute "set <End>=OF"
    map <Home> 0
    map <End> $
endif

" Apparently this has to be at the end
set exrc secure


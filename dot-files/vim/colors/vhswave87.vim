" Name:        vhswave87
" Description: VHS '87, the bluer sibling of vaporwave87. Background and base
"              colors from the retrowave variant of fluoromachine.nvim, with
"              more blue, purple and magenta, and less red and yellow. All
"              regular fonts except macros (bold). Matched to the alacritty
"              theme in
"              ~/.config/alacritty/themes/vhswave87.toml.
"              neonwave87 keeps the original sampled version with glow.
" Requires:    termguicolors (or GUI Vim)
"
" Options (set before :colorscheme):
"   g:vhswave87_transparent  1 to keep the terminal background (default 0)

hi clear
if exists('syntax_on')
    syntax reset
endif
set background=dark
let g:colors_name = 'vhswave87'

" --- Palette ---
" From fluoromachine retrowave
let s:fg      = '#f8f8f8'
let s:cyan    = '#61e2ff'
let s:green   = '#72f1b8'
let s:orange  = '#ff8b39'
let s:pink    = '#ff7edb'
let s:purple  = '#af6df9'
let s:red     = '#fe4450'
let s:yellow  = '#ffcc00'
let s:comment = '#7a86c8'
let s:slate   = '#495495'
let s:guide   = '#57367c'
" Added blues and purples
let s:blue      = '#6f9cff'
let s:lightblue = '#8ab4f8'
let s:magenta   = '#e865f2'
let s:lilac     = '#c08cf5'

let s:bg_dark = '#241b2f'
let s:bg      = '#262335'
let s:bg_sel  = '#463465'
let s:bg_vis  = '#4d3a99'
let s:bg_normal = get(g:, 'vhswave87_transparent', 0) ? 'NONE' : s:bg

" Diff backgrounds
let s:diff_add    = '#24413f'
let s:diff_change = '#2f3058'
let s:diff_delete = '#4a2238'

" hi {group} guifg guibg gui [guisp]; '' leaves a field out
function! s:hi(group, fg, bg, attr, ...) abort
    let l:cmd = 'hi ' . a:group
    let l:cmd .= ' guifg=' . (a:fg ==# '' ? 'NONE' : a:fg)
    let l:cmd .= ' guibg=' . (a:bg ==# '' ? 'NONE' : a:bg)
    let l:attr = a:attr ==# '' ? 'NONE' : a:attr
    let l:cmd .= ' gui=' . l:attr . ' cterm=' . l:attr
    if a:0 > 0
        let l:cmd .= ' guisp=' . a:1
    endif
    execute l:cmd
endfunction

" --- Editor ---
call s:hi('Normal',       s:fg,      s:bg_normal, '')
call s:hi('NormalFloat',  s:fg,      s:bg_dark,   '')
call s:hi('Cursor',       s:bg,      s:cyan,      '')
call s:hi('lCursor',      s:bg,      s:cyan,      '')
call s:hi('CursorIM',     s:bg,      s:cyan,      '')
call s:hi('CursorLine',   '',        s:bg_sel,    'NONE')
call s:hi('CursorColumn', '',        s:bg_sel,    '')
call s:hi('ColorColumn',  '',        s:bg_dark,   '')
call s:hi('LineNr',       s:comment, '',          '')
call s:hi('CursorLineNr', s:cyan,    s:bg_sel,    '')
call s:hi('SignColumn',   '',        s:bg_normal, '')
call s:hi('FoldColumn',   s:comment, s:bg_normal, '')
call s:hi('Folded',       s:comment, s:bg_sel,    '')
call s:hi('VertSplit',    s:comment, s:bg_dark,   '')
call s:hi('EndOfBuffer',  s:bg,      '',          '')
" listchars: eol uses NonText, tab/space/trail use SpecialKey
call s:hi('NonText',      s:guide,   '',          '')
call s:hi('SpecialKey',   s:guide,   '',          '')
call s:hi('Conceal',      s:comment, '',          '')

call s:hi('Visual',       '',        s:bg_vis,    '')
call s:hi('VisualNOS',    '',        s:bg_vis,    '')
call s:hi('Search',       '',        s:bg_sel,    'underline', s:cyan)
call s:hi('CurSearch',    s:bg_dark, s:cyan,      '')
call s:hi('IncSearch',    s:bg_dark, s:purple,    '')
call s:hi('MatchParen',   s:cyan,    '',          'underline')
call s:hi('QuickFixLine', '',        s:bg_sel,    '')

call s:hi('StatusLine',       s:fg,      s:bg_dark, 'NONE')
call s:hi('StatusLineNC',     s:comment, s:bg_dark, 'NONE')
call s:hi('StatusLineTerm',   s:fg,      s:bg_dark, 'NONE')
call s:hi('StatusLineTermNC', s:comment, s:bg_dark, 'NONE')
call s:hi('TabLine',          s:comment, s:bg_dark, 'NONE')
call s:hi('TabLineFill',      s:fg,      s:bg_dark, 'NONE')
call s:hi('TabLineSel',       s:fg,      s:slate,   '')
call s:hi('WildMenu',         s:fg,      s:bg_sel,  '')

call s:hi('Pmenu',        s:fg,      s:bg_dark,   '')
call s:hi('PmenuSel',     s:fg,      s:bg_sel,    '')
call s:hi('PmenuSbar',    '',        s:bg_dark,   '')
call s:hi('PmenuThumb',   '',        s:magenta,   '')
call s:hi('PmenuKind',    s:blue,    s:bg_dark,   '')
call s:hi('PmenuExtra',   s:comment, s:bg_dark,   '')
call s:hi('PmenuMatch',   s:cyan,    s:bg_dark,   '')
call s:hi('PmenuMatchSel', s:cyan,   s:bg_sel,    '')
call s:hi('Popup',        s:fg,      s:bg_dark,   '')

call s:hi('Directory',    s:blue,    '',          '')
call s:hi('Title',        s:magenta, '',          '')
call s:hi('ErrorMsg',     s:red,     '',          '')
call s:hi('WarningMsg',   s:orange,  '',          '')
call s:hi('ModeMsg',      s:fg,      '',          '')
call s:hi('MoreMsg',      s:cyan,    '',          '')
call s:hi('Question',     s:cyan,    '',          '')

call s:hi('DiffAdd',      '',        s:diff_add,    '')
call s:hi('DiffChange',   '',        s:diff_change, '')
call s:hi('DiffText',     s:bg_dark, s:blue,        '')
call s:hi('DiffDelete',   s:bg,      s:diff_delete, '')
call s:hi('Added',        s:green,   '',            '')
call s:hi('Changed',      s:blue,    '',            '')
call s:hi('Removed',      s:red,     '',            '')

call s:hi('SpellBad',     '',        '',          'undercurl', s:red)
call s:hi('SpellCap',     '',        '',          'undercurl', s:cyan)
call s:hi('SpellLocal',   '',        '',          'undercurl', s:blue)
call s:hi('SpellRare',    '',        '',          'undercurl', s:lilac)

" --- Syntax ---
call s:hi('Comment',      s:comment, '',          '')
call s:hi('SpecialComment', s:lightblue, '',      '')
call s:hi('Todo',         s:yellow,  '',          '')

call s:hi('Constant',     s:lilac,   '',          '')
call s:hi('Number',       s:lilac,   '',          '')
call s:hi('Float',        s:lilac,   '',          '')
call s:hi('Boolean',      s:lilac,   '',          '')
call s:hi('String',       s:magenta, '',          '')
call s:hi('Character',    s:magenta, '',          '')

call s:hi('Identifier',   s:fg,      '',          '')
call s:hi('Function',     s:cyan,    '',          '')

call s:hi('Statement',    s:green,   '',          '')
call s:hi('Conditional',  s:green,   '',          '')
call s:hi('Repeat',       s:green,   '',          '')
call s:hi('Keyword',      s:green,   '',          '')
call s:hi('Exception',    s:green,   '',          '')
call s:hi('Label',        s:lilac,   '',          '')
call s:hi('Operator',     s:pink,    '',          '')

call s:hi('PreProc',      s:green,   '',          '')
call s:hi('Include',      s:green,   '',          '')
call s:hi('Define',       s:green,   '',          '')
call s:hi('Macro',        s:magenta, '',          'bold')
call s:hi('PreCondit',    s:green,   '',          '')

call s:hi('Type',         s:pink,    '',          '')
call s:hi('StorageClass', s:green,   '',          '')
call s:hi('Structure',    s:pink,    '',          '')
call s:hi('Typedef',      s:green,   '',          '')

call s:hi('Special',      s:lilac,   '',          '')
call s:hi('SpecialChar',  s:lilac,   '',          '')
call s:hi('Tag',          s:pink,    '',          '')
call s:hi('Delimiter',    s:purple,  '',          '')
call s:hi('Debug',        s:green,   '',          '')

call s:hi('Underlined',   s:cyan,    '',          'underline')
call s:hi('Bold',         '',        '',          'bold')
call s:hi('Italic',       '',        '',          'italic')
call s:hi('Ignore',       s:comment, '',          '')
call s:hi('Error',        s:red,     '',          'underline')

" --- Filetypes ---
call s:hi('markdownH1',              s:magenta, '', '')
call s:hi('markdownH2',              s:blue,    '', '')
call s:hi('markdownH3',              s:cyan,    '', '')
hi! link markdownH4 Title
hi! link markdownH5 Title
hi! link markdownH6 Title
call s:hi('markdownHeadingDelimiter', s:comment, '', '')
call s:hi('markdownCode',            s:lilac,   '', '')
call s:hi('markdownCodeBlock',       s:lilac,   '', '')
call s:hi('markdownCodeDelimiter',   s:comment, '', '')
call s:hi('markdownBold',            s:lightblue, '', '')
call s:hi('markdownItalic',          s:pink,    '', '')
call s:hi('markdownListMarker',      s:purple,  '', '')
call s:hi('markdownOrderedListMarker', s:purple, '', '')
call s:hi('markdownLinkText',        s:cyan,    '', '')
call s:hi('markdownUrl',             s:comment, '', 'underline')

hi! link diffAdded   Added
hi! link diffRemoved Removed
hi! link diffChanged Changed
hi! link diffFile    Title
hi! link diffLine    Delimiter

hi! link gitcommitSummary    Title
hi! link gitcommitOverflow   Error

" --- Plugins ---
" YouCompleteMe
call s:hi('YcmErrorSign',      s:red,     s:bg_normal, '')
call s:hi('YcmWarningSign',    s:orange,  s:bg_normal, '')
call s:hi('YcmErrorSection',   '',        '',          'undercurl', s:red)
call s:hi('YcmWarningSection', '',        '',          'undercurl', s:orange)
call s:hi('YcmInlayHint',      s:comment, '',          '')
" vimspector
call s:hi('vimspectorBP',         s:red,     s:bg_normal, '')
call s:hi('vimspectorBPCond',     s:orange,  s:bg_normal, '')
call s:hi('vimspectorBPDisabled', s:comment, s:bg_normal, '')
call s:hi('vimspectorPC',         s:cyan,    s:bg_normal, '')
call s:hi('vimspectorPCLine',     '',        s:bg_sel,    '')
" CtrlP
call s:hi('CtrlPMatch',  s:cyan, '', '')
hi! link CtrlPPrtCursor Cursor
" vim-cpp-modern
hi! link cppStructure Structure
" indentLine
let g:indentLine_color_gui = s:guide

" --- :terminal colors (same as alacritty) ---
let g:terminal_ansi_colors = [
    \ '#241b2f', '#fe4450', '#72f1b8', '#ffcc00',
    \ '#6f9cff', '#e865f2', '#61e2ff', '#f8f8f8',
    \ '#6d78b8', '#ff6f78', '#95f5ca', '#ffd94d',
    \ '#8ab4f8', '#c08cf5', '#8ae9ff', '#ffffff',
    \ ]
call s:hi('Terminal', s:fg, s:bg_normal, '')

delfunction s:hi

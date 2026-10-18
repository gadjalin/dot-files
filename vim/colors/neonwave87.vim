" Name:        neonwave87
" Description: Neon '87, the bluer sibling of vaporwave87. Colors sampled from
"              the retrowave variant of fluoromachine.nvim (the middle window
"              of its README screenshot). Matched to the alacritty theme in
"              ~/.config/alacritty/themes/neonwave87.toml.
" Requires:    termguicolors (or GUI Vim)
"
" Options (set before :colorscheme):
"   g:neonwave87_transparent  1 to keep the terminal background (default 0)
"   g:neonwave87_glow         0 to disable the glow behind keywords, functions
"                            and constants (default 1)
"   g:neonwave87_italic       0 to disable italic comments and types (default 1)

hi clear
if exists('syntax_on')
    syntax reset
endif
set background=dark
let g:colors_name = 'neonwave87'

let s:glow   = get(g:, 'neonwave87_glow', 1)
let s:italic = get(g:, 'neonwave87_italic', 1) ? 'italic' : 'NONE'

" --- Palette (fluoromachine retrowave) ---
let s:fg      = '#f8f8f8'
let s:cyan    = '#61e2ff'
let s:green   = '#72f1b8'
let s:orange  = '#ff8b39'
let s:pink    = '#ff7edb'
let s:purple  = '#af6df9'
let s:red     = '#fe4450'
let s:yellow  = '#ffcc00'
let s:comment = '#495495'
let s:linenr  = '#30717f'
let s:guide   = '#57367c'

let s:bg_dark = '#241b2f'
let s:bg      = '#262335'
let s:bg_sel  = '#463465'
let s:bg_normal = get(g:, 'neonwave87_transparent', 0) ? 'NONE' : s:bg

" Glow: 5% of the text color over the background, as in fluoromachine
let s:glow_green  = s:glow ? '#2a2d3c' : ''
let s:glow_yellow = s:glow ? '#312b32' : ''
let s:glow_red    = s:glow ? '#312536' : ''
let s:glow_bold   = s:glow ? 'bold' : 'NONE'

" Diff backgrounds
let s:diff_add    = '#24413f'
let s:diff_change = '#3a2f3a'
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
call s:hi('Cursor',       s:bg,      s:green,     '')
call s:hi('lCursor',      s:bg,      s:green,     '')
call s:hi('CursorIM',     s:bg,      s:green,     '')
call s:hi('CursorLine',   '',        s:bg_sel,    'NONE')
call s:hi('CursorColumn', '',        s:bg_sel,    '')
call s:hi('ColorColumn',  '',        s:bg_dark,   '')
call s:hi('LineNr',       s:linenr,  '',          '')
call s:hi('CursorLineNr', s:cyan,    s:bg_sel,    'bold')
call s:hi('SignColumn',   '',        s:bg_normal, '')
call s:hi('FoldColumn',   s:comment, s:bg_normal, '')
call s:hi('Folded',       s:comment, s:bg_sel,    s:italic)
call s:hi('VertSplit',    s:comment, s:bg_dark,   '')
call s:hi('EndOfBuffer',  s:bg,      '',          '')
" listchars: eol uses NonText, tab/space/trail use SpecialKey
call s:hi('NonText',      s:guide,   '',          '')
call s:hi('SpecialKey',   s:guide,   '',          '')
call s:hi('Conceal',      s:comment, '',          '')

call s:hi('Visual',       '',        s:bg_sel,    '')
call s:hi('VisualNOS',    '',        s:bg_sel,    '')
call s:hi('Search',       '',        s:bg_sel,    'underline', s:cyan)
call s:hi('CurSearch',    s:bg_dark, s:cyan,      'bold')
call s:hi('IncSearch',    s:bg_dark, s:purple,    'bold')
call s:hi('MatchParen',   s:green,   '',          'bold,underline')
call s:hi('QuickFixLine', '',        s:bg_sel,    '')

call s:hi('StatusLine',       s:fg,      s:bg_dark, 'NONE')
call s:hi('StatusLineNC',     s:comment, s:bg_dark, 'NONE')
call s:hi('StatusLineTerm',   s:fg,      s:bg_dark, 'NONE')
call s:hi('StatusLineTermNC', s:comment, s:bg_dark, 'NONE')
call s:hi('TabLine',          s:comment, s:bg_dark, 'NONE')
call s:hi('TabLineFill',      s:fg,      s:bg_dark, 'NONE')
call s:hi('TabLineSel',       s:fg,      s:comment, 'bold')
call s:hi('WildMenu',         s:fg,      s:bg_sel,  'bold')

call s:hi('Pmenu',        s:fg,      s:bg_dark,   '')
call s:hi('PmenuSel',     s:fg,      s:bg_sel,    'bold')
call s:hi('PmenuSbar',    '',        s:bg_dark,   '')
call s:hi('PmenuThumb',   '',        s:red,       '')
call s:hi('PmenuKind',    s:cyan,    s:bg_dark,   '')
call s:hi('PmenuExtra',   s:comment, s:bg_dark,   '')
call s:hi('PmenuMatch',   s:yellow,  s:bg_dark,   'bold')
call s:hi('PmenuMatchSel', s:yellow, s:bg_sel,    'bold')
call s:hi('Popup',        s:fg,      s:bg_dark,   '')

call s:hi('Directory',    s:green,   '',          '')
call s:hi('Title',        s:red,     '',          'bold')
call s:hi('ErrorMsg',     s:red,     '',          'bold')
call s:hi('WarningMsg',   s:orange,  '',          '')
call s:hi('ModeMsg',      s:fg,      '',          'bold')
call s:hi('MoreMsg',      s:cyan,    '',          'bold')
call s:hi('Question',     s:cyan,    '',          '')

call s:hi('DiffAdd',      '',        s:diff_add,    '')
call s:hi('DiffChange',   '',        s:diff_change, '')
call s:hi('DiffText',     s:bg_dark, s:cyan,        'bold')
call s:hi('DiffDelete',   s:bg,      s:diff_delete, '')
call s:hi('Added',        s:green,   '',            '')
call s:hi('Changed',      s:orange,  '',            '')
call s:hi('Removed',      s:red,     '',            '')

call s:hi('SpellBad',     '',        '',          'undercurl', s:red)
call s:hi('SpellCap',     '',        '',          'undercurl', s:cyan)
call s:hi('SpellLocal',   '',        '',          'undercurl', s:cyan)
call s:hi('SpellRare',    '',        '',          'undercurl', s:orange)

" --- Syntax (mapping from fluoromachine retrowave) ---
call s:hi('Comment',      s:comment, '',            s:italic)
call s:hi('SpecialComment', s:green, s:glow_green,  s:glow_bold)
call s:hi('Todo',         s:yellow,  '',            'bold')

call s:hi('Constant',     s:red,     s:glow_red,    s:glow_bold)
call s:hi('Number',       s:red,     s:glow_red,    s:glow_bold)
call s:hi('Float',        s:red,     s:glow_red,    s:glow_bold)
call s:hi('Boolean',      s:red,     s:glow_red,    s:glow_bold)
call s:hi('String',       s:orange,  '',            '')
call s:hi('Character',    s:orange,  '',            '')

call s:hi('Identifier',   s:fg,      '',            '')
call s:hi('Function',     s:yellow,  s:glow_yellow, s:glow_bold)

call s:hi('Statement',    s:green,   s:glow_green,  s:glow_bold)
call s:hi('Conditional',  s:green,   s:glow_green,  s:glow_bold)
call s:hi('Repeat',       s:green,   s:glow_green,  s:glow_bold)
call s:hi('Keyword',      s:green,   s:glow_green,  s:glow_bold)
call s:hi('Exception',    s:green,   s:glow_green,  s:glow_bold)
call s:hi('Label',        s:cyan,    '',            '')
call s:hi('Operator',     s:pink,    '',            '')

call s:hi('PreProc',      s:green,   s:glow_green,  s:glow_bold)
call s:hi('Include',      s:green,   s:glow_green,  s:glow_bold)
call s:hi('Define',       s:green,   s:glow_green,  s:glow_bold)
call s:hi('Macro',        s:green,   s:glow_green,  s:glow_bold)
call s:hi('PreCondit',    s:green,   s:glow_green,  s:glow_bold)

call s:hi('Type',         s:pink,    '',            s:italic)
call s:hi('StorageClass', s:green,   s:glow_green,  s:glow_bold)
call s:hi('Structure',    s:pink,    '',            s:italic)
call s:hi('Typedef',      s:green,   s:glow_green,  s:glow_bold)

call s:hi('Special',      s:yellow,  '',            '')
call s:hi('SpecialChar',  s:orange,  '',            'bold')
call s:hi('Tag',          s:pink,    '',            '')
call s:hi('Delimiter',    s:purple,  '',            '')
call s:hi('Debug',        s:green,   '',            '')

call s:hi('Underlined',   s:cyan,    '',            'underline')
call s:hi('Bold',         '',        '',            'bold')
call s:hi('Italic',       '',        '',            'italic')
call s:hi('Ignore',       s:comment, '',            '')
call s:hi('Error',        s:red,     '',            'bold,underline')

" --- Filetypes ---
call s:hi('markdownH1',              s:red,     '', 'bold')
call s:hi('markdownH2',              s:pink,    '', 'bold')
call s:hi('markdownH3',              s:cyan,    '', 'bold')
hi! link markdownH4 Title
hi! link markdownH5 Title
hi! link markdownH6 Title
call s:hi('markdownHeadingDelimiter', s:comment, '', '')
call s:hi('markdownCode',            s:orange,  '', '')
call s:hi('markdownCodeBlock',       s:orange,  '', '')
call s:hi('markdownCodeDelimiter',   s:comment, '', '')
call s:hi('markdownBold',            s:yellow,  '', 'bold')
call s:hi('markdownItalic',          s:pink,    '', 'italic')
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
call s:hi('YcmErrorSign',      s:red,     s:bg_normal, 'bold')
call s:hi('YcmWarningSign',    s:orange,  s:bg_normal, 'bold')
call s:hi('YcmErrorSection',   '',        '',          'undercurl', s:red)
call s:hi('YcmWarningSection', '',        '',          'undercurl', s:orange)
call s:hi('YcmInlayHint',      s:comment, '',          s:italic)
" vimspector
call s:hi('vimspectorBP',         s:red,     s:bg_normal, '')
call s:hi('vimspectorBPCond',     s:orange,  s:bg_normal, '')
call s:hi('vimspectorBPDisabled', s:comment, s:bg_normal, '')
call s:hi('vimspectorPC',         s:cyan,    s:bg_normal, 'bold')
call s:hi('vimspectorPCLine',     '',        s:bg_sel,    '')
" CtrlP
call s:hi('CtrlPMatch',  s:yellow, '', 'bold')
hi! link CtrlPPrtCursor Cursor
" vim-cpp-modern
hi! link cppStructure Structure
" indentLine
let g:indentLine_color_gui = s:guide

" --- :terminal colors (same as alacritty) ---
let g:terminal_ansi_colors = [
    \ '#241b2f', '#fe4450', '#72f1b8', '#ffcc00',
    \ '#af6df9', '#ff7edb', '#61e2ff', '#f8f8f8',
    \ '#6d78b8', '#ff6f78', '#95f5ca', '#ffd94d',
    \ '#c494fb', '#ffa1e5', '#8ae9ff', '#ffffff',
    \ ]
call s:hi('Terminal', s:fg, s:bg_normal, '')

delfunction s:hi

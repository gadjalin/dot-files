" Name:        vaporwave87
" Description: Vaporwave '87
"              Based on Synthwave '84 and fluoromachine.nvim.
" Requires:    termguicolors
"
" Options (set before :colorscheme):
"   g:vaporwave87_transparent  1 to keep the terminal background (default 0)
"   g:vaporwave87_bold         0 to disable bold keywords/functions (default 1)
"   g:vaporwave87_italic       0 to disable italic comments (default 1)

hi clear
if exists('syntax_on')
    syntax reset
endif
set background=dark
let g:colors_name = 'vaporwave87'

let s:bold   = get(g:, 'vaporwave87_bold', 1) ? 'bold' : 'NONE'
let s:italic = get(g:, 'vaporwave87_italic', 1) ? 'italic' : 'NONE'

" --- Palette (same values as the alacritty theme) ---
let s:purple   = '#a974f5'
let s:violet   = '#c49cff'
let s:blue     = '#6c8cff'
let s:lavender = '#8fb0ec'
let s:cyan     = '#4fd6e8'
let s:magenta  = '#d65bd8'
let s:yellow   = '#f2cc4a'
let s:mint     = '#6fe0b0'
let s:red      = '#f0506e'
let s:indigo   = '#4b2be0'

let s:white    = '#ffffff'
let s:text     = '#dcdcf5'
let s:subtext  = '#a9b1e0'
let s:dimmed   = '#6e78b8'
let s:muted    = '#4a3d6e'
let s:linenr   = '#5e4d85'

" Backgrounds, darkest to lightest
let s:bg_dark  = '#1c082d'
let s:bg       = '#200933'
let s:bg_alt   = '#2c1545'
let s:bg_faint = '#34204f'
let s:bg_hi    = '#3a2358'
let s:bg_sel   = '#3b2560'
let s:bg_normal = get(g:, 'vaporwave87_transparent', 0) ? 'NONE' : s:bg

" Diff backgrounds
let s:diff_add    = '#183048'
let s:diff_change = '#2c1d5a'
let s:diff_text   = '#3e2c80'
let s:diff_delete = '#3d1235'

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
call s:hi('Normal',       s:text,    s:bg_normal, '')
call s:hi('NormalFloat',  s:text,    s:bg_dark,   '')
call s:hi('Cursor',       s:bg,      s:cyan,      '')
call s:hi('lCursor',      s:bg,      s:cyan,      '')
call s:hi('CursorIM',     s:bg,      s:cyan,      '')
call s:hi('CursorLine',   '',        s:bg_alt,    'NONE')
call s:hi('CursorColumn', '',        s:bg_alt,    '')
call s:hi('ColorColumn',  '',        s:bg_alt,    '')
call s:hi('LineNr',       s:linenr,  '',          '')
call s:hi('CursorLineNr', s:cyan,    s:bg_alt,    'bold')
call s:hi('SignColumn',   '',        s:bg_normal, '')
call s:hi('FoldColumn',   s:linenr,  s:bg_normal, '')
call s:hi('Folded',       s:dimmed,  s:bg_alt,    s:italic)
call s:hi('VertSplit',    s:muted,   s:bg_normal, '')
call s:hi('EndOfBuffer',  s:muted,   '',          '')
" listchars: eol uses NonText, tab/space/trail use SpecialKey
call s:hi('NonText',      s:bg_faint, '',         '')
call s:hi('SpecialKey',   s:bg_faint, '',         '')
call s:hi('Conceal',      s:dimmed,  '',          '')

call s:hi('Visual',       '',        s:bg_sel,    '')
call s:hi('VisualNOS',    '',        s:bg_sel,    '')
call s:hi('Search',       s:white,   '#5a2f80',   '')
call s:hi('CurSearch',    s:bg,      s:yellow,    'bold')
call s:hi('IncSearch',    s:bg,      s:yellow,    'bold')
call s:hi('MatchParen',   s:cyan,    s:bg_hi,     'bold')
call s:hi('QuickFixLine', '',        s:bg_sel,    '')

call s:hi('StatusLine',       s:text,   s:bg_hi,   'NONE')
call s:hi('StatusLineNC',     s:dimmed, s:bg_dark, 'NONE')
call s:hi('StatusLineTerm',   s:text,   s:bg_hi,   'NONE')
call s:hi('StatusLineTermNC', s:dimmed, s:bg_dark, 'NONE')
call s:hi('TabLine',          s:dimmed, s:bg_dark, 'NONE')
call s:hi('TabLineFill',      '',       s:bg_dark, 'NONE')
call s:hi('TabLineSel',       s:white,  s:indigo,  'bold')
call s:hi('WildMenu',         s:white,  s:indigo,  'bold')

call s:hi('Pmenu',        s:subtext, s:bg_alt,    '')
call s:hi('PmenuSel',     s:white,   s:indigo,    'bold')
call s:hi('PmenuSbar',    '',        s:bg_alt,    '')
call s:hi('PmenuThumb',   '',        s:muted,     '')
call s:hi('PmenuKind',    s:cyan,    s:bg_alt,    '')
call s:hi('PmenuExtra',   s:dimmed,  s:bg_alt,    '')
call s:hi('PmenuMatch',   s:yellow,  s:bg_alt,    'bold')
call s:hi('PmenuMatchSel', s:yellow, s:indigo,    'bold')
call s:hi('Popup',        s:text,    s:bg_dark,   '')

call s:hi('Directory',    s:cyan,    '',          '')
call s:hi('Title',        s:purple,  '',          'bold')
call s:hi('ErrorMsg',     s:red,     '',          'bold')
call s:hi('WarningMsg',   s:yellow,  '',          '')
call s:hi('ModeMsg',      s:text,    '',          'bold')
call s:hi('MoreMsg',      s:mint,    '',          '')
call s:hi('Question',     s:cyan,    '',          '')

call s:hi('DiffAdd',      '',        s:diff_add,    '')
call s:hi('DiffChange',   '',        s:diff_change, '')
call s:hi('DiffText',     '',        s:diff_text,   'bold')
call s:hi('DiffDelete',   s:red,     s:diff_delete, '')
call s:hi('Added',        s:mint,    '',            '')
call s:hi('Changed',      s:yellow,  '',            '')
call s:hi('Removed',      s:red,     '',            '')

call s:hi('SpellBad',     '',        '',          'undercurl', s:red)
call s:hi('SpellCap',     '',        '',          'undercurl', s:yellow)
call s:hi('SpellLocal',   '',        '',          'undercurl', s:cyan)
call s:hi('SpellRare',    '',        '',          'undercurl', s:purple)

" --- Syntax ---
call s:hi('Comment',      s:dimmed,  '',          s:italic)
call s:hi('SpecialComment', s:lavender, '',       s:italic)
call s:hi('Todo',         s:yellow,  '',          'bold')

call s:hi('Constant',     s:yellow,  '',          '')
call s:hi('String',       s:magenta, '',          '')
call s:hi('Character',    s:magenta, '',          '')
call s:hi('Number',       s:yellow,  '',          '')
call s:hi('Float',        s:yellow,  '',          '')
call s:hi('Boolean',      s:yellow,  '',          '')

call s:hi('Identifier',   s:lavender, '',         '')
call s:hi('Function',     s:cyan,    '',          s:bold)

call s:hi('Statement',    s:purple,  '',          s:bold)
call s:hi('Conditional',  s:purple,  '',          s:bold)
call s:hi('Repeat',       s:purple,  '',          s:bold)
call s:hi('Keyword',      s:purple,  '',          s:bold)
call s:hi('Exception',    s:purple,  '',          s:bold)
call s:hi('Label',        s:purple,  '',          '')
call s:hi('Operator',     s:subtext, '',          '')

call s:hi('PreProc',      s:violet,  '',          '')
call s:hi('Include',      s:violet,  '',          '')
call s:hi('Define',       s:violet,  '',          '')
call s:hi('Macro',        s:violet,  '',          '')
call s:hi('PreCondit',    s:violet,  '',          '')

call s:hi('Type',         s:blue,    '',          '')
call s:hi('StorageClass', s:blue,    '',          '')
call s:hi('Structure',    s:blue,    '',          '')
call s:hi('Typedef',      s:blue,    '',          '')

call s:hi('Special',      s:cyan,    '',          '')
call s:hi('SpecialChar',  s:yellow,  '',          '')
call s:hi('Tag',          s:mint,    '',          '')
call s:hi('Delimiter',    s:subtext, '',          '')
call s:hi('Debug',        s:red,     '',          '')

call s:hi('Underlined',   s:cyan,    '',          'underline')
call s:hi('Bold',         '',        '',          'bold')
call s:hi('Italic',       '',        '',          'italic')
call s:hi('Ignore',       s:muted,   '',          '')
call s:hi('Error',        s:red,     '',          'bold,underline')

" --- Filetypes ---
call s:hi('markdownH1',              s:purple,  '', 'bold')
call s:hi('markdownH2',              s:cyan,    '', 'bold')
call s:hi('markdownH3',              s:blue,    '', 'bold')
hi! link markdownH4 Title
hi! link markdownH5 Title
hi! link markdownH6 Title
call s:hi('markdownHeadingDelimiter', s:muted,  '', '')
call s:hi('markdownCode',            s:magenta, '', '')
call s:hi('markdownCodeBlock',       s:magenta, '', '')
call s:hi('markdownCodeDelimiter',   s:muted,   '', '')
call s:hi('markdownBold',            s:yellow,  '', 'bold')
call s:hi('markdownItalic',          s:lavender, '', 'italic')
call s:hi('markdownListMarker',      s:cyan,    '', '')
call s:hi('markdownOrderedListMarker', s:cyan,  '', '')
call s:hi('markdownLinkText',        s:cyan,    '', '')
call s:hi('markdownUrl',             s:dimmed,  '', 'underline')

hi! link diffAdded   Added
hi! link diffRemoved Removed
hi! link diffChanged Changed
hi! link diffFile    Title
hi! link diffLine    PreProc

hi! link gitcommitSummary    Title
hi! link gitcommitOverflow   Error

" --- Plugins ---
" YouCompleteMe
call s:hi('YcmErrorSign',      s:red,    s:bg_normal, 'bold')
call s:hi('YcmWarningSign',    s:yellow, s:bg_normal, 'bold')
call s:hi('YcmErrorSection',   '',       '',          'undercurl', s:red)
call s:hi('YcmWarningSection', '',       '',          'undercurl', s:yellow)
call s:hi('YcmInlayHint',      s:muted,  '',          s:italic)
" vimspector
call s:hi('vimspectorBP',         s:red,    s:bg_normal, '')
call s:hi('vimspectorBPCond',     s:yellow, s:bg_normal, '')
call s:hi('vimspectorBPDisabled', s:muted,  s:bg_normal, '')
call s:hi('vimspectorPC',         s:cyan,   s:bg_normal, 'bold')
call s:hi('vimspectorPCLine',     '',       s:bg_sel,    '')
" CtrlP
call s:hi('CtrlPMatch',  s:yellow, '', 'bold')
hi! link CtrlPPrtCursor Cursor
" vim-cpp-modern
hi! link cppStructure Structure
" indentLine
let g:indentLine_color_gui = s:bg_faint

" --- :terminal colors (same as alacritty) ---
let g:terminal_ansi_colors = [
    \ '#2c1545', '#f0506e', '#6fe0b0', '#f2cc4a',
    \ '#6c8cff', '#d65bd8', '#4fd6e8', '#dcdcf5',
    \ '#7a6aa0', '#ff7a92', '#93f0c8', '#ffe07a',
    \ '#94acff', '#e98ae8', '#85e6f2', '#ffffff',
    \ ]
call s:hi('Terminal', s:text, s:bg_normal, '')

delfunction s:hi

" Lightline colors for VHS '87, matching ~/.vim/colors/vhswave87.vim
" Layout from fluoromachine's retrowave lualine theme: mode in its color with
" the same color at half brightness as text.

let s:bg_dark = ['#241b2f', 234]
let s:bg      = ['#262335', 235]
let s:bg_sel  = ['#463465', 238]
let s:fg      = ['#f8f8f8', 231]
let s:comment = ['#495495', 61]
let s:dimmed  = ['#7a86c8', 104]
let s:cyan    = ['#61e2ff', 81]
let s:cyan_d  = ['#30717f', 30]
let s:magenta = ['#e865f2', 171]
let s:magenta_d = ['#451e48', 53]
let s:purple  = ['#af6df9', 141]
let s:purple_d = ['#57367c', 54]
let s:red     = ['#fe4450', 203]
let s:red_d   = ['#7f2228', 88]
let s:yellow  = ['#ffcc00', 220]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left    = [ [s:cyan_d, s:cyan], [s:fg, s:comment] ]
let s:p.normal.middle  = [ [s:fg, s:bg_dark] ]
let s:p.normal.right   = [ [s:cyan_d, s:cyan], [s:fg, s:comment] ]
let s:p.normal.error   = [ [s:bg_dark, s:red] ]
let s:p.normal.warning = [ [s:bg_dark, s:yellow] ]

let s:p.insert.left    = [ [s:magenta_d, s:magenta], [s:fg, s:comment] ]
let s:p.insert.right   = [ [s:magenta_d, s:magenta], [s:fg, s:comment] ]
let s:p.visual.left    = [ [s:purple_d, s:purple], [s:fg, s:comment] ]
let s:p.visual.right   = [ [s:purple_d, s:purple], [s:fg, s:comment] ]
let s:p.replace.left   = [ [s:red_d, s:red], [s:fg, s:comment] ]
let s:p.replace.right  = [ [s:red_d, s:red], [s:fg, s:comment] ]

let s:p.inactive.left   = [ [s:dimmed, s:bg_dark], [s:dimmed, s:bg_dark] ]
let s:p.inactive.middle = [ [s:dimmed, s:bg_dark] ]
let s:p.inactive.right  = [ [s:dimmed, s:bg_dark], [s:dimmed, s:bg_dark] ]

let s:p.tabline.left   = [ [s:dimmed, s:bg_dark] ]
let s:p.tabline.tabsel = [ [s:fg, s:comment] ]
let s:p.tabline.middle = [ [s:fg, s:bg_dark] ]
let s:p.tabline.right  = [ [s:cyan_d, s:cyan] ]

let g:lightline#colorscheme#vhswave87#palette = lightline#colorscheme#flatten(s:p)

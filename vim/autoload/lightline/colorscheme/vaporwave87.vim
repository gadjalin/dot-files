" Lightline colors for Vaporwave '87

let s:bg_dark = ['#1c082d', 233]
let s:bg      = ['#200933', 234]
let s:bg_alt  = ['#2c1545', 235]
let s:bg_hi   = ['#3a2358', 237]
let s:text    = ['#dcdcf5', 189]
let s:white   = ['#ffffff', 231]
let s:dimmed  = ['#8f96c8', 103]
let s:indigo  = ['#4b2be0', 56]
let s:purple  = ['#a974f5', 141]
let s:cyan    = ['#4fd6e8', 80]
let s:yellow  = ['#f2cc4a', 221]
let s:red     = ['#f0506e', 204]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left    = [ [s:white, s:indigo, 'bold'], [s:text, s:bg_hi] ]
let s:p.normal.middle  = [ [s:dimmed, s:bg_alt] ]
let s:p.normal.right   = [ [s:white, s:indigo], [s:text, s:bg_hi] ]
let s:p.normal.error   = [ [s:bg, s:red] ]
let s:p.normal.warning = [ [s:bg, s:yellow] ]

let s:p.insert.left    = [ [s:bg, s:cyan, 'bold'], [s:text, s:bg_hi] ]
let s:p.insert.right   = [ [s:bg, s:cyan], [s:text, s:bg_hi] ]
let s:p.visual.left    = [ [s:bg, s:yellow, 'bold'], [s:text, s:bg_hi] ]
let s:p.visual.right   = [ [s:bg, s:yellow], [s:text, s:bg_hi] ]
let s:p.replace.left   = [ [s:bg, s:red, 'bold'], [s:text, s:bg_hi] ]
let s:p.replace.right  = [ [s:bg, s:red], [s:text, s:bg_hi] ]

let s:p.inactive.left   = [ [s:dimmed, s:bg_dark], [s:dimmed, s:bg_dark] ]
let s:p.inactive.middle = [ [s:dimmed, s:bg_dark] ]
let s:p.inactive.right  = [ [s:dimmed, s:bg_dark], [s:dimmed, s:bg_dark] ]

let s:p.tabline.left   = [ [s:dimmed, s:bg_dark] ]
let s:p.tabline.tabsel = [ [s:white, s:indigo, 'bold'] ]
let s:p.tabline.middle = [ [s:dimmed, s:bg_dark] ]
let s:p.tabline.right  = [ [s:bg, s:purple] ]

let g:lightline#colorscheme#vaporwave87#palette = lightline#colorscheme#flatten(s:p)


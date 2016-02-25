" MPWillia's obsidian color scheme variant.
" Based directly on top of the obsidian color scheme found at:
" https://github.com/dbb/vim/blob/master/obsidian.vim
"
" Original author comments left in.
"
" Vim color file
" Maintainer:    Daniel Bolton <danielbarrettbolton@gmail.com>
" Last Modified: 2010-07-04
" Version: 0.1
"
" This scheme is based on the excellent lucius scheme. The cfterm colors are
" in fact exactly the same, and exist simply because I was too lazy to remove
" them yet.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let colors_name="mpwillian"

"xterm color dictionary
let s:xterm_colors = {
    \ '0':   '#000000', '1':   '#800000', '2':   '#008000', '3':   '#808000', '4':   '#000080',
    \ '5':   '#800080', '6':   '#008080', '7':   '#c0c0c0', '8':   '#808080', '9':   '#ff0000',
    \ '10':  '#00ff00', '11':  '#ffff00', '12':  '#0000ff', '13':  '#ff00ff', '14':  '#00ffff',
    \ '15':  '#ffffff', '16':  '#000000', '17':  '#00005f', '18':  '#000087', '19':  '#0000af',
    \ '20':  '#0000df', '21':  '#0000ff', '22':  '#005f00', '23':  '#005f5f', '24':  '#005f87',
    \ '25':  '#005faf', '26':  '#005fdf', '27':  '#005fff', '28':  '#008700', '29':  '#00875f',
    \ '30':  '#008787', '31':  '#0087af', '32':  '#0087df', '33':  '#0087ff', '34':  '#00af00',
    \ '35':  '#00af5f', '36':  '#00af87', '37':  '#00afaf', '38':  '#00afdf', '39':  '#00afff',
    \ '40':  '#00df00', '41':  '#00df5f', '42':  '#00df87', '43':  '#00dfaf', '44':  '#00dfdf',
    \ '45':  '#00dfff', '46':  '#00ff00', '47':  '#00ff5f', '48':  '#00ff87', '49':  '#00ffaf',
    \ '50':  '#00ffdf', '51':  '#00ffff', '52':  '#5f0000', '53':  '#5f005f', '54':  '#5f0087',
    \ '55':  '#5f00af', '56':  '#5f00df', '57':  '#5f00ff', '58':  '#5f5f00', '59':  '#5f5f5f',
    \ '60':  '#5f5f87', '61':  '#5f5faf', '62':  '#5f5fdf', '63':  '#5f5fff', '64':  '#5f8700',
    \ '65':  '#5f875f', '66':  '#5f8787', '67':  '#5f87af', '68':  '#5f87df', '69':  '#5f87ff',
    \ '70':  '#5faf00', '71':  '#5faf5f', '72':  '#5faf87', '73':  '#5fafaf', '74':  '#5fafdf',
    \ '75':  '#5fafff', '76':  '#5fdf00', '77':  '#5fdf5f', '78':  '#5fdf87', '79':  '#5fdfaf',
    \ '80':  '#5fdfdf', '81':  '#5fdfff', '82':  '#5fff00', '83':  '#5fff5f', '84':  '#5fff87',
    \ '85':  '#5fffaf', '86':  '#5fffdf', '87':  '#5fffff', '88':  '#870000', '89':  '#87005f',
    \ '90':  '#870087', '91':  '#8700af', '92':  '#8700df', '93':  '#8700ff', '94':  '#875f00',
    \ '95':  '#875f5f', '96':  '#875f87', '97':  '#875faf', '98':  '#875fdf', '99':  '#875fff',
    \ '100': '#878700', '101': '#87875f', '102': '#878787', '103': '#8787af', '104': '#8787df',
    \ '105': '#8787ff', '106': '#87af00', '107': '#87af5f', '108': '#87af87', '109': '#87afaf',
    \ '110': '#87afdf', '111': '#87afff', '112': '#87df00', '113': '#87df5f', '114': '#87df87',
    \ '115': '#87dfaf', '116': '#87dfdf', '117': '#87dfff', '118': '#87ff00', '119': '#87ff5f',
    \ '120': '#87ff87', '121': '#87ffaf', '122': '#87ffdf', '123': '#87ffff', '124': '#af0000',
    \ '125': '#af005f', '126': '#af0087', '127': '#af00af', '128': '#af00df', '129': '#af00ff',
    \ '130': '#af5f00', '131': '#af5f5f', '132': '#af5f87', '133': '#af5faf', '134': '#af5fdf',
    \ '135': '#af5fff', '136': '#af8700', '137': '#af875f', '138': '#af8787', '139': '#af87af',
    \ '140': '#af87df', '141': '#af87ff', '142': '#afaf00', '143': '#afaf5f', '144': '#afaf87',
    \ '145': '#afafaf', '146': '#afafdf', '147': '#afafff', '148': '#afdf00', '149': '#afdf5f',
    \ '150': '#afdf87', '151': '#afdfaf', '152': '#afdfdf', '153': '#afdfff', '154': '#afff00',
    \ '155': '#afff5f', '156': '#afff87', '157': '#afffaf', '158': '#afffdf', '159': '#afffff',
    \ '160': '#df0000', '161': '#df005f', '162': '#df0087', '163': '#df00af', '164': '#df00df',
    \ '165': '#df00ff', '166': '#df5f00', '167': '#df5f5f', '168': '#df5f87', '169': '#df5faf',
    \ '170': '#df5fdf', '171': '#df5fff', '172': '#df8700', '173': '#df875f', '174': '#df8787',
    \ '175': '#df87af', '176': '#df87df', '177': '#df87ff', '178': '#dfaf00', '179': '#dfaf5f',
    \ '180': '#dfaf87', '181': '#dfafaf', '182': '#dfafdf', '183': '#dfafff', '184': '#dfdf00',
    \ '185': '#dfdf5f', '186': '#dfdf87', '187': '#dfdfaf', '188': '#dfdfdf', '189': '#dfdfff',
    \ '190': '#dfff00', '191': '#dfff5f', '192': '#dfff87', '193': '#dfffaf', '194': '#dfffdf',
    \ '195': '#dfffff', '196': '#ff0000', '197': '#ff005f', '198': '#ff0087', '199': '#ff00af',
    \ '200': '#ff00df', '201': '#ff00ff', '202': '#ff5f00', '203': '#ff5f5f', '204': '#ff5f87',
    \ '205': '#ff5faf', '206': '#ff5fdf', '207': '#ff5fff', '208': '#ff8700', '209': '#ff875f',
    \ '210': '#ff8787', '211': '#ff87af', '212': '#ff87df', '213': '#ff87ff', '214': '#ffaf00',
    \ '215': '#ffaf5f', '216': '#ffaf87', '217': '#ffafaf', '218': '#ffafdf', '219': '#ffafff',
    \ '220': '#ffdf00', '221': '#ffdf5f', '222': '#ffdf87', '223': '#ffdfaf', '224': '#ffdfdf',
    \ '225': '#ffdfff', '226': '#ffff00', '227': '#ffff5f', '228': '#ffff87', '229': '#ffffaf',
    \ '230': '#ffffdf', '231': '#ffffff', '232': '#080808', '233': '#121212', '234': '#1c1c1c',
    \ '235': '#262626', '236': '#303030', '237': '#3a3a3a', '238': '#444444', '239': '#4e4e4e',
    \ '240': '#585858', '241': '#606060', '242': '#666666', '243': '#767676', '244': '#808080',
    \ '245': '#8a8a8a', '246': '#949494', '247': '#9e9e9e', '248': '#a8a8a8', '249': '#b2b2b2',
    \ '250': '#bcbcbc', '251': '#c6c6c6', '252': '#d0d0d0', '253': '#dadada', '254': '#e4e4e4',
    \ '255': '#eeeeee', 'fg': 'fg', 'bg': 'bg', 'NONE': 'NONE' }

function! s:HI(group, ctermfg, ctermbg, cterm)
   let l:str = a:group
   if(a:ctermfg >= 0 && len(a:ctermfg) > 0)
      let l:str = l:str . ' ctermfg=' . a:ctermfg
      let l:str = l:str . ' guifg=' . s:xterm_colors[a:ctermfg]
   endif
   if(a:ctermbg >= 0 && len(a:ctermbg) > 0)
      let l:str = l:str . ' ctermbg=' . a:ctermbg
      let l:str = l:str . ' guibg=' . s:xterm_colors[a:ctermbg]
   endif
   if(len(a:cterm) > 0)
      let l:str = l:str . ' cterm=' . a:cterm
   endif
   exec 'hi ' . l:str
endfunction



" Some other colors to save
" blue: 3eb8e5
" green: 92d400
" c green: d5f876, cae682
" new blue: 002D62
" new gray: CCCCCC

" NOTE: gui... colors, such as guifg/guibg, are specific to gVim only.
" cterm... colors, such as ctermfg/ctermbg, are for standard Vim.

" Base color
" ----------
call s:HI("Normal", 253, 235, "")

" Comment Group
" -------------
" any comment
call s:HI("Comment", 240, -1, "none")
" task tags, todo, fixme, xxx
call s:HI("Todo", 228, "NONE", "underline")
" note tags
call s:HI("Note", 246, "NONE", "underline")
" removal tags, old, bad, remove, delete
call s:HI("RemoveNote", 173, "NONE", "underline")


" Constant Group
" --------------
" any constant
call s:HI("Constant", 116, -1, "none")
" strings
call s:HI("String", 110, -1, "none")
" character constant
call s:HI("Character", 110, -1, "none")
" numbers decimal/hex
call s:HI("Number", 110, -1, "none")
" true, false
call s:HI("Boolean", 110, -1, "none")
" float
call s:HI("Float", 110, -1, "none")


" Identifier Group
" ----------------
" any variable name
call s:HI("Identifier", 216, -1, "none")
" function, method, class
call s:HI("Function", 216, -1, "none")


" Statement Group
" ---------------
" any statement
call s:HI("Statement", 150, -1, "none")
" if, then, else
call s:HI("Conditional", 150, -1, "none")
" try, catch, throw, raise
call s:HI("Exception", 150, -1, "none")
" for, while, do
call s:HI("Repeat", 150, -1, "none")
" case, default
call s:HI("Label", 150, -1, "none")
" sizeof, +, *
call s:HI("Operator", 150, -1, "none")
" any other keyword, e.g. 'sub'
call s:HI("Keyword", 150, -1, "none")


" Preprocessor Group
" ------------------
" generic preprocessor
call s:HI("PreProc", 223, -1, "none")
" #include
call s:HI("Include", 223, -1, "none")
" #define
call s:HI("Define", 223, -1, "none")
" same as define
call s:HI("Macro", 223, -1, "none")
" #if, #else, #endif
call s:HI("PreCondit", 223, -1, "none")



" Type Group
" ----------
" int, long, char
call s:HI("Type", 115, -1, "none")
" static, register, volative
call s:HI("StorageClass", 115, -1, "none")
" struct, union, enum
call s:HI("Structure", 115, -1, "none")
" typedef
call s:HI("Typedef", 115, -1, "none")


" Special Group
" -------------
" any special symbol
call s:HI("Special", 181, -1, "none")
" special character in a constant
call s:HI("SpecialChar", 181, -1, "none")
" things you can CTRL-]
call s:HI("Tag", 181, -1, "none")
" character that needs attention
call s:HI("Delimiter", 181, -1, "none")
" special things inside a comment
call s:HI("SpecialComment", 181, -1, "none")
" debugging statements
call s:HI("Debug", 181, "NONE", "none")


" Underlined Group
" ----------------
" text that stands out, html links
call s:HI("Underlined", "fg", -1, "underline")


" Ignore Group
" ------------
" left blank, hidden
call s:HI("Ignore", "bg", -1, "")


" Error Group
" -----------
" any erroneous construct
call s:HI("Error", 167, 52, "none")


" Spelling
" --------
" word not recognized
"hi SpellBad         guisp=#ee0000                                   gui=undercurl
"hi SpellBad                                 ctermbg=9               cterm=undercurl
call s:HI("SpellBad", -1, 9, "undercurl")
" word not capitalized
"hi SpellCap         guisp=#eeee00                                   gui=undercurl
"hi SpellCap                                 ctermbg=12              cterm=undercurl
call s:HI("SpellCap", -1, 12, "undercurl")
" rare word
"hi SpellRare        guisp=#ffa500                                   gui=undercurl
"hi SpellRare                                ctermbg=13              cterm=undercurl
call s:HI("SpellRare", -1, 13, "undercurl")
" wrong spelling for selected region
"hi SpellLocal       guisp=#ffa500                                   gui=undercurl
"hi SpellLocal                               ctermbg=14              cterm=undercurl
call s:HI("SpellLocal", -1, 14, "undercurl")


" Cursor
" ------
" character under the cursor
call s:HI("Cursor", "bg", 153, "")
" like cursor, but used when in IME mode
call s:HI("CursorIM", "bg", 116, "")
" cursor column
call s:HI("CursorColumn", "NONE", 236, "none")
" cursor line/row
call s:HI("CursorLine", "NONE", 236, "none")


" Misc
" ----
" directory names and other special names in listings
call s:HI("Directory", 151, -1, "none")
" error messages on the command line
call s:HI("ErrorMsg", 196, "NONE", "none")
" column separating vertically split windows
call s:HI("VertSplit", 242, 237, "none")
" columns where signs are displayed (used in IDEs)
"call s:HI("SignColumn", 145, 233, "none")
call s:HI("SignColumn", -1, "bg", "none")
" line numbers
call s:HI("LineNr", 102, 237, "")
" match parenthesis, brackets
call s:HI("MatchParen", 46, "NONE", "bold")
" the 'more' prompt when output takes more than one line
call s:HI("MoreMsg", 29, -1, "none")
" text showing what mode you are in
call s:HI("ModeMsg", 117, "NONE", "none")
" the '~' and '@' and showbreak, '>' double wide char doesn't fit on line
call s:HI("NonText", 235, -1, "none")
" the hit-enter prompt (show more output) and yes/no questions
call s:HI("Question", "fg", -1, "none")
" meta and special keys used with map, unprintable characters
call s:HI("SpecialKey", 237, -1, "")
" titles for output from :set all, :autocmd, etc
call s:HI("Title", 74, -1, "none")
" warning messages
call s:HI("WarningMsg", 173, -1, "none")
" current match in the wildmenu completion
call s:HI("WildMenu", 16, 186, "bold")


" Diff
" ----
" added line
call s:HI("DiffAdd", 108, 22, "none")
" changed line
call s:HI("DiffChange", "fg", 52, "none")
" deleted line
call s:HI("DiffDelete", 59, 58, "none")
" changed text within line
call s:HI("DiffText", 203, 52, "bold")


" Folds
" -----
" line used for closed folds
call s:HI("Folded", 117, 238, "none")
" column on side used to indicated open and closed folds
call s:HI("FoldColumn", 117, 238, "none")


" Search
" ------
" highlight incremental search text; also highlight text replaced with :s///c
call s:HI("IncSearch", 87, -1, "reverse")
" hlsearch (last search pattern), also used for quickfix
call s:HI("Search", -1, 214, "none")


" Popup Menu
" ----------
" normal item in popup
call s:HI("Pmenu", 253, 233, "none")
" selected item in popup
call s:HI("PmenuSel", 186, 237, "none")
" scrollbar in popup
call s:HI("PMenuSbar", -1, 59, "none")
" thumb of the scrollbar in the popup
call s:HI("PMenuThumb", -1, 102, "none")


" Status Line
" -----------
" status line for current window
call s:HI("StatusLine", 254, 237, "bold")
" status line for non-current windows
call s:HI("StatusLineNC", 244, 237, "none")


" red
call s:HI("SLRed", 167, 237, "bold")
" orange
call s:HI("SLOrange", 173, 237, "bold")
" blue
call s:HI("SLBlue", 110, 237, "bold")
" cyan
call s:HI("SLCyan", 117, 237, "bold")
" teal
call s:HI("SLTeal", 115, 237, "bold")
" green
call s:HI("SLGreen", 150, 237, "bold")
" pink
call s:HI("SLPink", 181, 237, "bold")


" status line notices
call s:HI("SLNotice", 110, 237, "bold")

" status line warning message
call s:HI("SLWarning", 173, 237, "bold")
call s:HI("SLWarning2", 181, 237, "bold")


"status line errors
call s:HI("SLError", 167, 237, "bold")

" Tab Lines
" ---------
" tab pages line, not active tab page label
call s:HI("TabLine", 244, 236, "none")
" tab pages line, where there are no labels
call s:HI("TabLineFill", 187, 236, "none")
" tab pages line, active tab page label
call s:HI("TabLineSel", 254, 236, "bold")


" Visual
" ------
" visual mode selection
call s:HI("Visual", "NONE", 24, "")
" visual mode selection when vim is not owning the selection (x11 only)
call s:HI("VisualNOS", "fg", -1, "underline")



" Plugin Highlighting
" -------------------
" syntastic error sign
hi link SyntasticErrorSign ErrorMsg

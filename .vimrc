
" Fixes all sorts of encoding issues
set encoding=utf-8

""" Load external custom vim files first
let g:VIMFILES_DIR="$HOME/.dotfiles/vim"

"Custom Vim files to load
let loadFiles = ['Windows.vim',
                \'OSX.vim', 
                \'BetterBrackets.vim',
                \'BracketMovement.vim',
                \'BlankLineMovement.vim',
                \'ScratchShell.vim',
                \'HexDump.vim',
                \'AutoTemplates.vim',
                \]
"BetterCodeMovement.vim

"load the list of files
let i = 0
while i < len(loadFiles) 
   execute "so " . g:VIMFILES_DIR . "/" . get(loadFiles, i)
   let i += 1
endwhile


""" Indentation
set autoindent    "enable auto indent
set expandtab     "expand tabs into spaces
set shiftwidth=3  "columns indented when reindenting
set softtabstop=3 "size of normal tabs
set tabstop=3     "global tab size


""" Visual
syntax on
colorscheme obsidian
set cursorline       "highlight the line the cursor is on 
set laststatus=2     "always display the status line
set linespace=0      "force no extra space between lines
set scrolloff=10     "start scrolling 10 lines before the edge
set sidescrolloff=10 "start scrolling 10 characters before the edge
set number           "enable line numbers
set ruler            "show cursor coordinates in status
let java_allow_cpp_keywords = 1  "stop silly highlighting of C++ keywords in java code

"treat our custom dotfiles as bash files for the sake of syntax highlighting
au BufNewFile,BufRead .colors,.aliases,.mybashrc,.colortests,.easylscolors,.jdkswitcher call SetFileTypeSH("bash")

" Line length notifiers
"  despite what people say going over 80 characters is fine but you should
"  always be aware of when your lines are getting long
set textwidth=0      "disables forced text width of 80
if exists('+colorcolumn')  "Added as of 7.3 (Laptop has; Unix servers don't)
   "Preferred method is color column
   set colorcolumn=80   "highlight the 80th column
   "force the column highlight to match the line highlight in color
   highlight ColorColumn ctermbg=236
else
   "Highlights all characters in the 81st column or above
   highlight OverLength ctermbg=236
   match OverLength /\%81v.\+/
endif


""" Folds
set foldmethod=syntax   "fold off syntax
set foldnestmax=2       "limit fold nesting, only really fold full functions
set foldlevelstart=2    "sets the initial fold level
set nofoldenable        "start with no folds


""" Window Splits
" Map Alt-HJKL to move cursor between splits
nnoremap <A-h> :wincmd h<CR>
nnoremap <A-j> :wincmd j<CR>
nnoremap <A-k> :wincmd k<CR>
nnoremap <A-l> :wincmd l<CR>

" Map Ctrl-HJKL to resize splits
noremap <silent> <C-h> <C-w><
noremap <silent> <C-j> <C-W>-
noremap <silent> <C-k> <C-W>+
noremap <silent> <C-l> <C-w>>

"TODO Map someshit to move splits around


""" Insert Movement
" Map Alt-HJLK to enable cursor movement while in insert mode
inoremap <A-h> <LEFT>
inoremap <A-j> <DOWN>
inoremap <A-k> <UP>
inoremap <A-l> <RIGHT>


""" Misc KeyCodes 
" Set our keycode timeout to 150ms
set timeout timeoutlen=1000 timeoutlen=200
"TODO Different timeouts for different keycodes?


" rebind <Esc> to jk
inoremap jk <Esc>
vnoremap jk <Esc>

" Faster closing/saving of files
noremap wq <Esc>:wq<CR> 
noremap qq <Esc>:q<CR>
noremap ww <Esc>:w<CR>
noremap wqa <Esc>:wqa<CR>

" Faster movement
inoremap <A-h><A-h><A-h> <ESC>5<LEFT>i
inoremap <A-j><A-j><A-j> <ESC>5<DOWN>i
inoremap <A-k><A-k><A-k> <ESC>5<UP>i
inoremap <A-l><A-l><A-l> <ESC>5<RIGHT>i

nnoremap hhh 5<LEFT>
nnoremap jjj 5<DOWN>
nnoremap kkk 5<UP>
nnoremap lll 5<RIGHT>

" Special movement
inoremap <A-H> <ESC>:call BracketMovement(0,1)<CR>
nnoremap <A-H> <ESC>:call BracketMovement(0,0)<CR>
inoremap <A-J> <ESC>:call BlankLineMovement(1,1)<CR>
nnoremap <A-J> <ESC>:call BlankLineMovement(1,0)<CR>
inoremap <A-K> <ESC>:call BlankLineMovement(0,1)<CR>
nnoremap <A-K> <ESC>:call BlankLineMovement(0,0)<CR>
inoremap <A-L> <ESC>:call BracketMovement(1,1)<CR>
nnoremap <A-L> <ESC>:call BracketMovement(1,0)<CR>


" TODO enable non-breaking spaces for file types where they would be useful

" Disable the creation of non-breaking spaces with Alt-<SPACE>
inoremap <A-SPACE> <SPACE>


""" Plugins
" enable pathogen plugin loader
execute pathogen#infect()

"" NERDTree
autocmd vimenter * NERDTree      "enable NERDTree
" map Ctrl-D to toggle NERDTree
map <C-d> :NERDTreeToggle<CR>   
let g:NERDTreeWinSize=16         "set the width of the NERDTree window
let NERDTreeShowHidden=1         "show hidden files
autocmd vimenter * wincmd w      "when a file is opened set focus to the newly opened file rather than NERDTree
" if NERDTree is the last window opened then exit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


""" Compilation and execution keybindings
" TODO smart compilation, compiles programs based on file types and
"  includes all desired files, create and use a make file?
" TODO goal is three universal keybindings
"  F8 - Call gcc, javac, make, or whatever is needed on all desired files
"  F9 - Run ./a.out, java MainClass, or whatever is the program entry point
"  F10 - Compile and Run

"map F10 to build and a run the current single file .c program
noremap <F10> :w<CR> :!clear<CR> :!gcc % && ./a.out<CR> 

"map F9 to compile a single file java program
noremap <F9> :w<CR> :!clear<CR> :!javac %<CR>

"map F8 to run the script test.sh
noremap <F8> :wa<CR> :!clear<CR> :!./test.sh<CR>

"TODO Omnicomplete is pretty shit, find a better autocompletion plugin
" YouCompleteMe is great but needs Vim 7.3.+ which neither my Macbook
" nor do the Unix servers have
filetype plugin on
set omnifunc=syntaxcomplete#Complete


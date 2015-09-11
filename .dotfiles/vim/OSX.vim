
""" Rebinding Alt-hjkl to the approiate keystrokes for various OS
"" Characters sent by OS X
" Reference for character sent by OS X for Alt-hjkl
" Alt- | h | j | k | l  
" Char | ˙ | ∆ | ˚ | ¬ 
"
" Set F30-F33 to reference the character sent by Alt-hjkl

set <F30>=˙
set <F31>=∆
set <F32>=˚
set <F33>=¬

" Map Alt-hjkl to move cursor between splits
nnoremap <F30> :wincmd h<CR>
nnoremap <F31> :wincmd j<CR>
nnoremap <F32> :wincmd k<CR>
nnoremap <F33> :wincmd l<CR>

" Map Alt-hjkl to enable cursor movement while in insert mode
inoremap <F30> <LEFT>
inoremap <F31> <DOWN>
inoremap <F32> <UP>
inoremap <F33> <RIGHT>

" Faster movement
inoremap <F30><F30><F30> <ESC>5<LEFT>i
inoremap <F31><F31><F31> <ESC>5<DOWN>i
inoremap <F32><F32><F32> <ESC>5<UP>i
inoremap <F33><F33><F33> <ESC>5<RIGHT>i

" Set F34-F37 to reference the character sent by Shift-Alt-hjkl
set <F34>=Ó
set <F35>=Ô
set <F36>=
set <F37>=Ò

" Special movement
inoremap <F34> <ESC>:call BracketMovement(0,1)<CR>
nnoremap <F34> <ESC>:call BracketMovement(0,0)<CR>
inoremap <F35> <ESC>:call BlankLineMovement(1,1)<CR>
nnoremap <F35> <ESC>:call BlankLineMovement(1,0)<CR>
inoremap <F36> <ESC>:call BlankLineMovement(0,1)<CR>
nnoremap <F36> <ESC>:call BlankLineMovement(0,0)<CR>
inoremap <F37> <ESC>:call BracketMovement(1,1)<CR>
nnoremap <F37> <ESC>:call BracketMovement(1,0)<CR>








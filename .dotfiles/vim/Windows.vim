
"" Characters sent by Windows through Putty
" Reference for character sent by Windows through Putty for Alt-hjkl
" Alt- |  h  |  j  |  k  |  l
" Char | ^[h | ^[j | ^[k | ^[l
"
" Set F20-F23 to reference the characters sent by Alt-hjkl
execute "set <F20>=\eh"
execute "set <F21>=\ej"
execute "set <F22>=\ek"
execute "set <F23>=\el"

" Map Alt-hjkl to move cursor between splits
nnoremap <F20> :wincmd h<CR>
nnoremap <F21> :wincmd j<CR>
nnoremap <F22> :wincmd k<CR>
nnoremap <F23> :wincmd l<CR>

" Map Alt-hjkl to enable cursor movement while in insert mode
inoremap <F20> <LEFT>
inoremap <F21> <DOWN>
inoremap <F22> <UP>
inoremap <F23> <RIGHT>

" Faster movement
inoremap <F20><F20><F20> <ESC>5<LEFT>i
inoremap <F21><F21><F21> <ESC>5<DOWN>i
inoremap <F22><F22><F22> <ESC>5<UP>i
inoremap <F23><F23><F23> <ESC>5<RIGHT>i

" Set F24-F27 to reference the character sent by Shift-Alt-hjkl
execute "set <F24>=\eH"
execute "set <F25>=\eJ"
execute "set <F26>=\eK"
execute "set <F27>=\eL"

" Special movement
inoremap <F24> <ESC>:call BracketMovement(0,0)<CR>
inoremap <F25> <ESC>:call BlankLineMovement(1,1)<CR>
nnoremap <F25> <ESC>:call BlankLineMovement(1,0)<CR>
inoremap <F26> <ESC>:call BlankLineMovement(0,1)<CR>
nnoremap <F26> <ESC>:call BlankLineMovement(0,0)<CR>
inoremap <F27> <ESC>:call BracketMovement(1,0)<CR>










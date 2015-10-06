
set statusline=""
function! s:Push(element, hl)
   let l:elem = a:element
   if len(a:hl) > 0
      let l:elem = "%#" . a:hl . "#" . l:elem . "%*"
   endif
   let &statusline = &statusline . l:elem
endfunction

call s:Push("%<%-0.50F", "")
call s:Push("\ %h", "")
call s:Push("%m", "warningmsg")
call s:Push("%r", "")

call s:Push("%=", "")
call s:Push("%-14.(%l,%c%V%)", "")
call s:Push("\ %p%%", "")

"set statusline=%<%F       "the path to the open file
"set statusline+=\ %h         "help file flag
"set statusline+=%m         "modified flag
"
"set statusline+=%#warningmsg#
"set statusline+=%r         "read only flag
"set statusline+=%*
"
"set statusline+=%=         "switch to right justified
"set statusline+=%-14.(%l,%c%V%)  "x,y coord of cursor
"set statusline+=\ %p%%       "percent through file


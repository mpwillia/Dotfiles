
set statusline=""
function! s:Push(element, hl)
   let l:elem = a:element
   if len(a:hl) > 0
      let l:elem = "%#" . a:hl . "#" . l:elem . "%*"
   endif
   let &statusline = &statusline . l:elem
endfunction

call s:Push("%<%-0.50F", "")
call s:Push("\ %y%h%r", "")
call s:Push("%m", "SLWarning")

call s:Push("%=", "")
call s:Push("%-14.(%l,%c%V%)", "")
call s:Push("\ %p%%", "")


"call s:Push("%y", "Directory")
"call s:Push("%y", "Special")
"call s:Push("%y", "Type")
"call s:Push("%y", "Character")
"call s:Push("%y", "Keyword")
"call s:Push("%y","SLNotice")
"call s:Push("%y", "SLWarning")
"call s:Push("%y", "SLError")

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



set statusline=""
function! s:Push(element, hl)
   let l:elem = a:element
   if len(a:hl) > 0
      let l:elem = "%#" . a:hl . "#" . l:elem . "%*"
   endif
   let &statusline = &statusline . l:elem
endfunction

call s:Push("%<%-0.50F", "")
call s:Push("\ %y", "")
call s:Push("%r", "SLWarning")
call s:Push("%h%w", "SLWarning2")
call s:Push("%m", "SLWarning")
call s:Push("%3.(▎%)", "StatusLineNC")
call s:Push("%18.{&paste?'-- PASTE MODE --':''}\ ", "SLNotice")

"set statusline+=%{&paste?'[paste]':'}'
"call s:Push("%y", "SLRed")
"call s:Push("%y", "SLOrange")
"call s:Push("%y", "SLBlue")
"call s:Push("%y", "SLCyan")
"call s:Push("%y", "SLTeal")
"call s:Push("%y", "SLGreen")
"call s:Push("%y", "SLPink")
"call s:Push("%y", "SLNotice")
"call s:Push("%y", "SLWarning")
"call s:Push("%y", "SLError")

call s:Push("%=", "")

"call s:Push("%{SyntasticStatuslineFlag()}", "SLError")
call s:Push("%-3.(\ %)", "")
call s:Push("%-3.(▎%)", "StatusLineNC")
call s:Push("%-10.(%l,%c%V%)", "")
call s:Push("%4.4p%%", "")
call s:Push("%7.L\ Lines\ ", "")



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


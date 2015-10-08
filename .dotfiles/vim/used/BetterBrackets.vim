""" Better brackets and quotes
" when typing a pair of brackets or quotes the cursor is moved inside them
inoremap () )<LEFT>(
inoremap "" "<LEFT>"
inoremap [] ]<LEFT>[
inoremap '' '<LEFT>'
inoremap <lt>> ><LEFT><
inoremap {} <ESC>:call BetterCurlyBrace()<CR>


" Whether or not to force a certain bracket style
" 0 - don't force
" 1 - force K&R style brackets
" 2 - force Allman style brackets

if !exists('g:better_brackets_enforce_style')
   let g:better_brackets_enforce_style = 0
endif
let g:better_brackets_enforce_style = 1


function! BetterCurlyBrace()
   "0 - don't open
   "1 - K&R (same line)
   "2 - Allman (next line)
   let l:shouldOpen = ShouldOpenCurlyBrace() 
   
   "Kinda works
   "TODO: Need to maintain spacing between statement and next lines
   "if g:better_brackets_enforce_style == 1 && shouldOpen == 2 
   "   call setpos(".", [0, line(".")-1, col("."), 0])
   "   let shouldOpen = g:better_brackets_enforce_style
   "elseif g:better_brackets_enforce_style == 2 && shouldOpen == 1
   "   call setpos(".", [0, line(".")+1, col("."), 0])
   "   let shouldOpen = g:better_brackets_enforce_style
   "endif
   
   let l:force = 0
   if l:shouldOpen > 0 && g:better_brackets_enforce_style > 0
      if l:shouldOpen != g:better_brackets_enforce_style
         let l:shouldOpen = g:better_brackets_enforce_style
         let l:force = 1
      endif
   endif

   " Write curly braces
   call WriteCurlyBrace(l:shouldOpen, l:force)

   startinsert
endfunction


" Writes the curly braces, open if needed
function! WriteCurlyBrace(type, force)
   if a:type == 1 
      " K&R
      "NOTE: why did we stop using this again?
      "let lastCharCol = GetLastCharCol(getline("."))
      "call setpos(".", [0, line("."), lastCharCol, 0])
      "execute "normal a }\<LEFT>{\<CR>\<CR>\<UP>\<TAB> "
      
      "NOTE: 2nd iteration
      "execute "normal A }\<LEFT>{\<CR>\<CR>\<UP>\<TAB> "
    
      "NOTE: 3rd/current iteration
      "puts cursor to the last character in the line so we can write the curly
      "braces with proper tabbing
      "call setpos(".", [0, line("."), GetLastCharCol(getline(".")), 0])
      "execute "normal a }\<LEFT>{\<CR>\<CR>\<UP>\<TAB> "
      
      "NOTE: 4th/current iteration
      let l:linepos = line(".")
      if a:force > 0
         let l:linepos -= 1
      endif

      call setpos(".", [0, l:linepos, GetLastCharCol(getline(l:linepos)), 0])
      execute "normal a }\<LEFT>{\<CR>\<CR>\<UP>\<TAB> "

   elseif a:type == 2
      " Allman
      "NOTE: don't quite remember why we stopped using this
      "let prevline = getline(line(".")-1)
      "let lastCharCol = GetLastCharCol(prevline)
      "call setpos(".", [0, line(".")-1, lastCharCol, 0])
      "execute "normal a}\<LEFT>{\<LEFT>\<CR>\<RIGHT>\<CR>\<CR>\<UP>\<TAB> "
      
      if a:force > 0
         execute "normal A\<CR>\<ESC>"
      endif

      "NOTE: 2nd iteration, totally should have documented this :)
      if line(".") == line("$")
         execute "normal dd A}\<LEFT>{\<LEFT>\<CR>\<RIGHT>\<CR>\<CR>\<UP>\<TAB> "
      else 
         execute "normal dd\<UP>A}\<LEFT>{\<LEFT>\<CR>\<RIGHT>\<CR>\<CR>\<UP>\<TAB> "
      endif
   else
      " Don't open
      execute "normal a}\<LEFT>{\<RIGHT>"
      "call setline(".", "TEST")
   endif
endfunction


" Returns the column of the last non-whitespace character in the given line
" returns the index position of the last character
function! GetLastCharCol(line)
   let lineLen = strlen(a:line)
   let i = lineLen - 1

   while a:line[i] == ' ' 
      let i -= 1
   endwhile 
   let i += 1
   return i
endfunction


" Checks if curly braces should be opened
" Returns 1 if K&R check passes; 2 if Allman check passes; otherwise 0
function! ShouldOpenCurlyBrace()
   let curLine = getline(".")
   let prevLine = getline(line(".")-1)
   let curIdx = col(".")

   " If there are chacters after the cursor then we shouldn't open the braces no matter what
   if CheckWhitespace(curLine, curIdx) == 0
      return 0
   endif

   " K&R - curLine key + curLine NOT empty
   if CheckWhitespace(curLine, 0) == 0
      if CheckAllKeys(curLine, curIdx) > 0
         return 1 
      endif

   " Allman - curLine empty + prevLine key
   elseif CheckWhitespace(curLine, 0) > 0
      if CheckAllKeys(prevLine, strlen(prevLine)) > 0
         return 2
      endif
   endif

return 0
endfunction

" Given the line check it against our lists of valid keys
" If we find the key in a valid position return 1; otherwise 0
function! CheckAllKeys(line, index)
  
   " TODO make these more accessible, rather than in the middle of a random
   " function put these at, for example, the top of the file.

   """ THESE ARE THE KEYS THAT DETERMINE WHEN TO OPEN CURLY BRACES 
   " endKeys are keys that will only trigger when they are at the end of the
   " line, indicated by their position being less than the cursors position
   " and only whitespace characters trailing them
   let endKeys = [')', 'else', 'try', 'finally', 'static']

   " globalKeys are keys that will trigger at any position in the line as long
   " as they occur before the cursors position
   let globalKeys = ['class', 'interface', 'enum', 'struct', 'throws']
  
   
   let keyIdx = -1
   let bestKeyIdx = -1

   " Check for endKeys in line
   let i = 0
   while i < len(endKeys)
      let keyIdx = FindKey(a:line, get(endKeys, i), a:index)

      if keyIdx > bestKeyIdx
         let bestKeyIdx = keyIdx
      endif

      let i += 1
   endwhile
   
   " If we found an end key we need to check if its at the end of the line
  if bestKeyIdx >= 0
      if CheckWhitespace(a:line, bestKeyIdx) > 0
         return 1 
      endif
   endif

   " If we didn't find a valid end key lets now check for valid global keys
   let keyIdx = -1
   let bestKeyIdx = -1

   let i = 0
   while i < len(globalKeys)
      let keyIdx = FindKey(a:line, get(globalKeys, i), strlen(a:line))

      if keyIdx > bestKeyIdx
         let bestKeyIdx = keyIdx
      endif

      let i+= 1
   endwhile

   if bestKeyIdx >= 0
      return 1
   endif
   return 0
endfunction

" Checks for any whitespace in line at index to the end of the line
" returns 1 if there is only whitespace; 0 if there are any other characters
function! CheckWhitespace(line, index)
   let i = a:index
   while i < strlen(a:line)
      if a:line[i] != ' '
         return 0
      endif
      let i += 1
   endwhile
   return 1
endfunction

" Searches through line looking for any matches to key
" returns the end index of where the key was found; otherwise -1
function! FindKey(line, key, curIdx)
   let keyLen = strlen(a:key)
   let lineIdx = a:curIdx - keyLen
   
   while lineIdx >= 0
      if DoesKeyMatch(a:line, a:key, lineIdx)
         return lineIdx+keyLen
      endif

      let lineIdx -= 1
   endwhile
   
   return -1
endfunction

" Checks if the given key matches the characters in line starting at index
" Returns 1 if key matches; 0 otherwise
function! DoesKeyMatch(line, key, index)
   let keyIdx = 0
   while keyIdx < strlen(a:key)
      if a:key[keyIdx] != a:line[a:index + keyIdx]
         return 0
      endif

      let keyIdx += 1
   endwhile

   return 1
endfunction

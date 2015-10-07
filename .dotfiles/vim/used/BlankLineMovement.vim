
function! BlankLineMovement(dir, mode)
   "dir
   "0 - up
   "1 - down

   let jumpLine = s:FindJumpLine(a:dir)
  
   call setpos(".", [0, jumpLine, col("."), 0])
  
   if a:mode == 1
      startinsert
   endif
endfunction

function! s:FindJumpLine(dir)
   
   let startLineIdx = line(".")
   if a:dir == 0
      "move up 
      let i = startLineIdx - 1

      if i <= 1
         return 1
      endif

      "we want to ignore any adjacent blank lines
      while s:IsLineBlank(getline(i)) > 0 && i > 0
         let i -= 1
      endwhile

      while i > 0
         if s:IsLineBlank(getline(i)) > 0
            return i
         endif
         let i -= 1
      endwhile
      return 1 


   elseif a:dir == 1
      "move down
      let numLines = line("$")
      let i = startLineIdx + 1

      if i >= numLines
         return numLines
      endif

      "we want to ignore any adjacent blank lines
      while s:IsLineBlank(getline(i)) > 0 && i < numLines
         let i += 1
      endwhile

      while i < numLines
         if s:IsLineBlank(getline(i)) > 0
            return i
         endif
         let i += 1
      endwhile
      return numLines 
   endif
   return startLineIdx
endfunction

function! s:IsLineBlank(line)
   let i = 0
   while i < len(a:line)
      if a:line[i] != ' '
         return 0 
      endif
      let i += 1
   endwhile

   return 1
endfunction





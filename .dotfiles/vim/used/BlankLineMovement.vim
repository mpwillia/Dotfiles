
function! BlankLineMovement(dir, mode)
   "dir
   "0 - up
   "1 - down
   let jumpLine = FindJumpLine(a:dir)
  
   let jumpPos = [0, jumpLine, col("."), 0]

   if a:mode == 2
      let startVis = getpos("'<")
      let endVis = getpos("'>")

      " are we expanding or shrinking the selection? 0 - shrink, 1 - expand, -1 - clear, 2 - stepover
      let expanding = 0
      
      if line(".") > line("'<") && jumpLine < line("'<")
         let expanding = 0
      elseif line(".") < line("'>") && jumpLine > line("'>")
         let expanding = 0
      elseif jumpLine < line("'<") || jumpLine > line("'>")
         let expanding = 1
      elseif jumpLine == line("'<") || jumpLine == line("'>")
         let expanding = -1
      endif

      " up
      if a:dir == 0
         if expanding == 0
            call SetVisualSelection(startVis, jumpPos)
         elseif expanding == 1
            call SetVisualSelection(endVis, jumpPos)
         else
            call SetVisualSelection(jumpPos, jumpPos)
         endif

      " down
      elseif a:dir == 1
         if expanding == 0
            call SetVisualSelection(endVis, jumpPos)
         elseif expanding == 1
            call SetVisualSelection(startVis, jumpPos)
         else
            call SetVisualSelection(jumpPos, jumpPos)
         endif
      endif

      "" up
      "if a:dir == 0 
      "   if getline(".") >= getline("'<")
      "      call setpos(".", endVis)
      "   else
      "      call setpos(".", startVis)
      "   endif
      "" down
      "elseif a:dir == 1
      "   if getline(".") <= getline("'>")
      "      call setpos(".", startVis)
      "   else
      "      call setpos(".", endVis)
      "   endif
      "endif

      "normal v
      "call setpos(".", [0, jumpLine, col("."), 0])

   else  
      call setpos(".", [0, jumpLine, col("."), 0])
      if a:mode == 1
         startinsert
      endif
   endif

endfunction

function! SetVisualSelection(start, end)
   call setpos("'<", a:start)
   call setpos("'>", a:end)
   call setpos(".", a:start)
   normal! v
   call setpos(".", a:end)
endfunction


function! FindJumpLine(dir)
   
   let startLineIdx = line(".")
   if a:dir == 0
      "move up 
      let i = startLineIdx - 1

      if i <= 1
         return 1
      endif

      "we want to ignore any adjacent blank lines
      while IsLineBlank(getline(i)) > 0 && i > 0
         let i -= 1
      endwhile

      while i > 0
         if IsLineBlank(getline(i)) > 0
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
      while IsLineBlank(getline(i)) > 0 && i < numLines
         let i += 1
      endwhile

      while i < numLines
         if IsLineBlank(getline(i)) > 0
            return i
         endif
         let i += 1
      endwhile
      return numLines 
   endif
   return startLineIdx
endfunction

function! IsLineBlank(line)
   let i = 0
   while i < len(a:line)
      if a:line[i] != ' '
         return 0 
      endif
      let i += 1
   endwhile

   return 1
endfunction





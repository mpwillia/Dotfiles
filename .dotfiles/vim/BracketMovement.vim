
"Test Line
""  some text ("foo [hello]  ", word) and some {more}; stu…ff

function BracketMovement(dir, mode)
   "dir
   "0 - bracket to the left
   "1 - bracket to the right

   "mod
   "0 - next
   "1 - innermost
  
   "call FindBracket(a:dir)

   let jumpCol = GetJumpCol(a:dir, a:mode)
   
   call setpos(".", [0, line("."), jumpCol, 0])
   
   if a:mode == 1
      startinsert
   endif

endfunction


"Returns the column to move the cursor to
function GetJumpCol(dir, mode)
   let curIdx = col(".")

   if a:mode != 1
      let curIdx -= 1
   endif

   let bracketIdx = FindBracket(a:dir, curIdx)

   return bracketIdx + 1
   "return bracketIdx
endfunction


"Finds the next bracket in the given direction relative to the given index
"Returns the index of the bracket; -1 if none found
function FindBracket(dir, index)
   let curLine = getline(".")
  
   if a:dir == 0
      "to the left

      "if the character at index-1 is a bracket then exit
      if IsBracket(curLine[a:index - 1])
         return a:index - 1
      endif

      let i = a:index - 1
      while i >= 0
         if IsBracket(curLine[i]) > 0
            return i + 1
         endif
         let i -= 1
      endwhile
      return 0

   elseif a:dir == 1
      "to the right

      "if the character at index is a bracket then just enter
      if IsBracket(curLine[a:index])
         return a:index + 1 
      endif


      let i = a:index + 1
      while i <= len(curLine)
         if IsBracket(curLine[i]) > 0
            return i
         endif
         let i += 1
      endwhile
      return len(curLine)
   endif

endfunction


"Returns 1 if the given character is a bracket or quote; 0 otherwise
function IsBracket(check)
   let brackets = ['{', '}', '(', ')', '<', '>', '[', ']', "\'", "\""]
  
   let i = 0
   while i < len(brackets)
      if a:check == get(brackets, i)
         return 1
      endif
   let i += 1
   endwhile
   return 0
endfunction

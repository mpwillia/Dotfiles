function BetterCodeMovement(dir, mode)
   "dir
   "0 - up
   "1 - down

   let jumpLine = FindJumpLine(a:dir)
  
   call setpos(".", [0, jumpLine, col("."), 0])
  
   if a:mode == 1
      startinsert
   endif
endfunction

function FindJumpLine(dir)
   
   let startLineIdx = line(".")
   if a:dir == 0
      "move up 
      let i = startLineIdx - 1

      if i <= 1
         return 1
      endif

      "we want to ignore any adjacent blank lines
      while IsLineBlank(getline(i)) > 0
         let i -= 1
      endwhile

      while i > 0
         if CheckAllCodeKeys(getline(i)) > 0
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
      "if we get to the end of the page then stop as well
      while IsLineBlank(getline(i)) > 0 && i < numLines
         let i += 1
      endwhile

      while i < numLines
         if CheckAllCodeKeys(getline(i)) > 0
            return i
         endif
         let i += 1
      endwhile
      return numLines 
   endif
   return startLineIdx
endfunction

function CheckAllCodeKeys(line)
   
   let keys = [' ', '{', '}']

   let i = 0
   let keyCheck = 1
   "check each character in the line
   while i < len(a:line)
      
      "check the character against each possible key
      let keyMatch = 0
      let keyIndex = 0
      while keyIndex < len(keys) && keyMatch <= 0
         if a:line[i] == keys[keyIndex]
            "if the character matches the key then stop
            let keyMatch = 1
         endif
         let keyIndex += 1
      endwhile
     
      "if we didn't find a match to the key then stop
      if keyMatch <= 0
         return 0
      endif
      let i += 1

   endwhile
   return 1
endfunction


function IsLineBlank(line)
   let i = 0
   while i < len(a:line)
      if a:line[i] != ' '
         return 0 
      endif
      let i += 1
   endwhile

   return 1
endfunction




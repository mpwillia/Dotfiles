
" Universal Movement - The Dream
function UniversalMovement(dir, amt, state)
   
   let cmd = ""
   if a:dir ==? "h"
      let cmd = "\<LEFT>"
   elseif a:dir ==? "j"
      let cmd = "\<DOWN>"
   elseif a:dir ==? "k"
      let cmd = "\<UP>"
   elseif a:dir ==? "l"
      let cmd = "\<RIGHT>"
   else
      return 0
   endif
   
   if a:amt <= 0
      return 0
   endif

   let cmd = "normal " . a:amt . cmd
   execute cmd
   
   if a:state ==? "i"
      startinsert
   elseif a:state ==? "n"
     stopinsert
   else
      return 0
   endif

   return 1
endfunction

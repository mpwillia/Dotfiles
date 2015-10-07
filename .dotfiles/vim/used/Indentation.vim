

function! AddIndentationStyle(projectname, depth)

   if(len(a:projectname) <= 0) 
      echo "Invalid Project Name: '" . a:projectname . "'"
      return
   endif

   if(a:depth <= 0)
      echo "Invalid depth: '" . a:depth . "'" 
      return
   endif

   execute "autocmd BufNewFile,BufRead */" . a:projectname . "/* setlocal shiftwidth=" . a:depth . " softtabstop=" . a:depth . " tabstop=" . a:depth

endfunction


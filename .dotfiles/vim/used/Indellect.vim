



if exists("loaded_indellect")
   finish
endif
let loaded_indellect = 1

let indellect_default_indent = 3
let indellect_max_indent = 4

autocmd BufRead * call AutoDetectIndent()

function! SetIndent(indent)
   "echo "Setting indentation width to " . a:indent
   if a:indent > g:indellect_max_indent
      let a:indent = g:indellect_max_indent
   endif
   execute "setlocal shiftwidth=" . a:indent . " softtabstop=" . a:indent . " tabstop=" . a:indent
endfunction


function! AutoDetectIndent()
   let g:indent = DetectIndent()
   if g:indent > 0
      if g:indent > g:indellect_max_indent
         call SetIndent(g:indellect_default_indent)
      else
         call SetIndent(g:indent)
      endif
   endif
endfunction

function! DetectIndent()

   "first find line with 0 indent
   let l:i = 0
   let l:numlines = line("$")
   while l:i < l:numlines
      let l:line = getline(l:i)
      if s:IsComment(l:i) <= 0 && s:FirstNonBlank(l:line) == 0
         
         "then find next indented line
         let l:j = l:i + 1
         while l:j < l:numlines
            let l:line = getline(l:j) 
            let l:indent = s:FirstNonBlank(l:line)
            if s:IsComment(l:j) <= 0
               if l:indent > 0
                  return l:indent 
               elseif l:indent == 0
                  break
               endif
            endif
            let l:j += 1
         endwhile
         let l:i = l:j - 1

      endif
      let l:i += 1
   endwhile

   return -1

   "let l:curlnum = line(".")
   "let l:line = getline(l:curlnum) 
   "let l:firstnonblank = s:FirstNonBlank(l:line)   
   "
   "echo "curlnum: " . l:curlnum
   "echo "line: '" . l:line . "'"
   "echo "firstnonblank: " . l:firstnonblank
   "echo "IsComment: " . s:IsComment(l:curlnum)

   "return 1
endfunction

function! s:FirstNonBlank(line)
   let l:i = 0
   while l:i < len(a:line)
      if a:line[l:i] != ' '
         return l:i
      endif
      let i += 1
   endwhile
   if l:i >= len(a:line)
      return -1 
   endif
   return l:i
endfunction

function! s:IsComment(lnum)
   if exists("g:syntax_on")
      let l:col = s:FirstNonBlank(getline(a:lnum)) + 1
      let l:syn = synIDattr(synIDtrans(synID(a:lnum, l:col, 1)), "name") 
      "echo l:syn
      if len(l:syn) <= 0
         return 0
      endif
      
      return l:syn ==? "comment"
   else
      "TODO: some more clever shit for comments if we can't just piggyback off syntax
      return 0
   endif
   return 0
endfunction

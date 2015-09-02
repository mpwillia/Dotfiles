
"Enables the :HexDump <filename> command to open up a scratch buffer and dump
"the contents of <filename> as hexadecimal
command! -complete=shellcmd -nargs=+ HexDump call s:HexDumpFile(<q-args>)
function! s:HexDumpFile(args)
   botright new
   setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
   call setline(1, 'Hex dump of: ' . a:args)
   execute ':r !xxd ' . a:args
   setlocal nomodifiable
   1
endfunction

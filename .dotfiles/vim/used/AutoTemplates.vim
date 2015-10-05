


let g:TEMPLATES_DIR=g:VIMFILES_DIR . "/templates"


""" Test Script Template
autocmd bufnewfile test.sh exe "so " . g:TEMPLATES_DIR . "/testScript.txt"
" With our test script we want to make sure we can execute it
"autocmd bufwritepost test.sh exe "!chmod 700 test.sh"
autocmd bufwritepost *.sh silent exe "!chmod 700 " . expand("%:p")

""" Java Files Template
autocmd bufnewfile *.java exe "so " . g:TEMPLATES_DIR . "/java.txt"
autocmd bufnewfile *.java exe "g/public class/s//public class " . expand("%:r")

""" C Header Template
autocmd bufnewfile *.h exe "so " . g:TEMPLATES_DIR . "/c_header.txt"
autocmd bufnewfile *.h exe "g/#ifndef/s//#ifndef " . substitute(toupper(expand("%:r")), " ", "_", "") . "_H"
autocmd bufnewfile *.h exe "g/#define/s//#define " . substitute(toupper(expand("%:r")), " ", "_", "") . "_H"


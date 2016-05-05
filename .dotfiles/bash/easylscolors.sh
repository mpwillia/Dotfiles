#
# Easy LS Colors
#


LSCOLORFILE="$DOTFILE_DIR/colors.ls"

#Todo List
# Add ability to  set OSX's LS_COLORS
#  Either parse from file, look for LS_COLORS block
#  Or interpret from LSCOLORS variable

# Add test functions
#  Simple print the colors and their extensions
#  Create a test folder with directories named after block labels whose
#   contents are example files based on the contents of the blocks

# Reads the file pointed to by LSCOLORFILE, parses it, and exports the result
#  into LSCOLORS
function __oldSetLSColorsFromFile()
{
   #cat ~/.dotfiles/.unixls | grep "\w" | grep -v "^#" | sed
   #cat ~/.dotfiles/.lscolors | grep "\w" | grep -v "^#" | sed "s/#.\ //" | perl -lane "printf "%s=%s:", shift @F, join ";", @F;"
   
   set -f

   local LSSTR=""
   local foundBlock=0
   local blockName=""
   local blockColor=""
   while read -r line || [[ -n $line ]]
   do
      #local cleanedLine=$(echo $line | grep -v "^#" | sed -e 's/#.*//' -e '/^$/ d')
      #local cleanedLine=$(echo $line | sed -e 's/#.*//' -e '/^$/ d')
      local cleanedLine=$(echo "$line" | sed -e 's/#.*//' -e '/^$/ d')
      if [[ $foundBlock -gt 0 ]]; then
         
         cleanedLine=$(echo $cleanedLine | sed 's/ //')
         
         #This is parsing for normal LSCOLORS
         if [[ $cleanedLine == *"}"* ]]; then
            foundBlock=0
         elif [[ $cleanedLine == *"="* ]]; then
            LSSTR="$LSSTR$cleanedLine:"
         elif [[ -n "$blockColor" ]]; then 
            LSSTR="$LSSTR$cleanedLine=$blockColor:"
         else
            echo "Could not parse '$cleanedLine' - missing color"
         fi

         #Want parsing for OSX LS_COLORS

      elif [[ $cleanedLine == *"{"* ]]; then
      
         local blockHeader="$cleanedLine"
         foundBlock=1
         
         #find block color if it exists
         if [[ $blockHeader == *"("*")"* ]]; then
            blockColor=$(echo $blockHeader | sed -e 's/.*(//' -e 's/).*//')
         fi

         #find block name if it exists
         blockName=$(echo $blockHeader | sed -e 's/(.*//' -e 's/{.*//' -e 's/ //')
      fi
   done < "$LSCOLORFILE"

   export LS_COLORS="$LSSTR"
   
   set +f
}

function __setLSColorsFromFile() {
   # Possible States:
   # 0 - Looking for a block
   # 1 - Found a block, parsing...
   local state=0  

   # these are the definitions for the currently found block
   local blockname=""
   local blockcolor=""
   
   # the current LS_COLORS string
   local ls_str=""
   local linenum=0 

   # disable globbing, it causes lots of problems with syntax like '*.jpg'
   set -f
   while read -r rawline || [[ -n $rawline ]]; do
      # strips comments out of the line
      local line=$(echo $rawline | sed 's/#.*$//')
      
      # parse the line based on our state
      case $state in

         0) if [[ $line == *"{"* ]]; then
               # found the block header line
               blockname=$(echo $line | sed -e 's/[ ](.*//')
               if [[ $line == *"("*")"* ]]; then
                  blockcolor=$(echo $line | sed -e 's/.*(//' -e 's/).*//')
               fi

               state=1
            fi
            ;;

         1) if [[ $line == *"}"* ]]; then
               # end of block
               blockname=""
               blockcolor=""
               state=0
            else
               # assume block defined color by default
               what=$line
               color=$blockcolor
               
               # check if it's actually an individually defined color
               if [[ $line == *"="* ]]; then
                  what=$(echo $line | sed 's/=.*//') 
                  color=$(echo $line | sed 's/.*=//')
               fi

               if [[ -z $color ]]; then
                  echo "Invalid LS Colors File syntax; block nor definition assign a color at line $linenum: '$line'" 
                  echo "LS_COLORS left unchanged."
                  return 1
               fi
               
               ls_str="$ls_str$what=$color:"
            fi
            ;;

         *) echo "ERROR : UNKNOWN STATE '$state'"
            ;;
      esac

      let linenum=linenum+1
   done < "$LSCOLORFILE"
   
   export LS_COLORS="$ls_str"
   # re-enable globbing
   set +f
} 

function __bsdlscolors()
{
   # Color List
   # ________|_Normal_|__Bold__|
   # Black   |   a    |   A    |
   # Red     |   b    |   B    |
   # Green   |   c    |   C    |
   # Brown   |   d    |   D    |
   # Blue    |   e    |   E    |
   # Magenta |   f    |   F    |
   # Cyan    |   g    |   G    |
   # Grey    |   h    |   H    |
   # Default_|___x____|________|
   #
   # Order:
   #  Directory
   #  Symbolic Link
   #  Socket
   #  Pipe
   #  Executable
   #  Block Device
   #  Character Device
   #  Executable with setuid set
   #  Executable with setguid set
   #  Directory writable by others, with sticky bit
   #  Directory writable by others, without sticky bit
   #
   
   local DIR=Ex
   local SYM_LINK=Fx
   local SOCKET=Bx
   local PIPE=Dx
   local EXE=Cx
   local BLOCK_SP=eg
   local CHAR_SP=ed
   local EXE_SUID=ab
   local EXE_GUID=ag
   local DIR_STICKY=ac
   local DIR_WO_STICKY=ad
   
   export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"

   #export LSCOLORS=ExFxBxDxCxegedabagacad
}

function __linuxlscolors()
{
   export LS_COLORS='di=1;95:ln=1;35:so=1;31:pi=1;33:ex=1;32:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:'

   # LS_COLORS Parameter Info
   # linux-sxs.org/housekeeping/lscolors.html
   #
   # Basic File Types
   # di = directory
   # fi = file
   # ln = symbolic link
   # pi = fifo file
   # so = socket file
   # bd = block (buffered) special file
   # cd = character (unbuffered) special file
   # or = symbolic link pointing to a non-existent file (orphan)
   # mi = non-existent file pointed to by a symbolic link (ls -l)
   # ex = file which is executable (ie. has 'x' set in permissions)
   #
   # Custom File Types
   # *.filetype = all files ending in .filetype
   #

   # Basic File Vars
   local DI=1;95:
   local FI=0:
   local LN=1;35:
   local PI=1;33:
   local SO=1;31:
   local BD=34:
   local CD=34:
   local OR=0:
   local MI=0:
   local EX=1;32:


}

if [ -n "$LSCOLORS" ]; then
   # Check if LSCOLORS has been set
   # echo "LSCOLORS has been set"
   __bsdlscolors
elif [ -n "$LS_COLORS" ]; then
   # Check if LS_COLORS has been set
   __setLSColorsFromFile
else
   # echo "fuck it setting both"
   __bsdlscolors
   __setLSColorsFromFile
fi

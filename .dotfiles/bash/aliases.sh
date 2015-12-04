
# enables non-interactive shell alias expansion
shopt -s expand_aliases

# os specific
if [[ "$OSTYPE" == "darwin"* ]]; then
   alias ls='ls -GFh'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
   alias ls='ls -Fh --color'
else
   alias ls='ls -Fh'
fi

# ls aliases
alias lsa='ls -a'
alias lsl='lsa -l'
alias lsd='ls -d */'

# history aliases
alias h='history'
alias hg='history | grep'


# cd aliases
#alias cd..='cd ..'
alias cd.1='cd..'
alias cd...='cd ../..'
alias cd.2='cd...'
alias cd....='cd ../../..'
alias cd.3='cd....'
alias cd.....='cd ../../../..'
alias cd.4='cd.....'
alias cd......='cd ../../../../..'
alias cd.5='cd......'

alias cd-='cd -'

# smart cd to parent directories
function cd.. () {
   if [[ $# < 1 ]]; then
      cd ..
   else
      check=$(pwd)
      check=${check%/*} # we want to ignore our current directory
      arg=$1
      search=${arg##*/}

      while [[ -n $check ]]; do
         dir=${check##*/}
         if [[ $dir == *"$search"* ]]; then
            cd $check
            return 0
         fi
         check=${check%/*}
      done
      
      echo "Search term '$search' not found in parent directories"
      return 1
   fi
} 

alias mkdirs='mkdir -p'
alias rmr='rm -rI'


# Quick pushing/popping dirs
alias +='pushd'
alias -- -='popd'
alias ?='dirs -v'

# Date and time - these are in theory useful but I never actually use them
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# lists all of the bash binds
alias binds='bind -P | grep -v "is not" | sed -e "s/can be found on/:/" | column -s: -t'

# simple calculator
=() { echo $(($*)); }

# Faster compression/decompression
alias compress='tar -zcvf'
alias expand='tar -zxvf'

# Finds the number of .png images in the current directory
alias numimgs='find .//. ! -name .png -print | grep -c //'

# Show/Hide Hidden Files/Folders in OSX
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
# Reloads the ~/.bash_profile
alias resource='echo "Reloading .bash_profile"; source ~/.bash_profile'

# Executes the given command silently, dumping output into var 'silent_output'
function silent() {
   if [[ $# < 1 ]]; then
      echo "silent: no command given"
      return 1
   fi

   cmd=""
   while [[ $# > 0 ]]; do
      cmd="$cmd $1"
      shift
   done
   silent_output=$($cmd)
} 

# Useful wrapper for du
# Arguments:
#  - None   -  Gets the size of the files and directories in the current directory, calls 'du -h --max-depth=1'
#  - First argument is a number  -  changes the depth, so calling 'ds 2' would set the depth to 2, equivelant to 'du -h --max-depth=2' 
#  - First argument is not a number -  Simply calls 'du' with the arguments given, always uses -h flag
function ds() {
   if [[ $# < 1 ]]; then
      du -h --max-depth=1
   elif [[ $1 =~ ^[0-9]+$ ]]; then
      du -h --max-depth=$1
   else
      du -h $*
   fi
} 

# Quick wrapper to print harddrive device info
function hdinfo() {
   if [[ $# < 1 ]]; then
      echo "hdinfo: no device name given!"
      return 1
   fi
   arg=$1
   arg=${arg#/dev}
   arg=${arg#/}
   sudo hdparm -I /dev/$arg 
} 

alias cpuinfo='cat /proc/cpuinfo'
alias meminfo='cat /proc/meminfo'

# Creates a backup of the given file or directory name
# files are renamed to 'filename.backup' 
# dirs are compressed and renamed to 'filename.backup'
#function backup() {
#   if [[ $# < 1 ]]; then
#      echo "no file given"
#      return 1
#   fi
#
#   while [[ $# > 0 ]]; do
#      file=$1
#      if [[ -d $file ]]; then
#         # directory backup
#         echo "Backing up directory '$file'"
#         tar -zcf $file.backup $file
#         echo "Directory backed up to '$file.backup'"
#      elif [[ -e $file ]]; then
#         # file backup
#         echo "Backing up file '$file'"
#         mv $file $file.backup
#         echo "File backed up to '$file.backup'"
#      else
#         echo "Cannot find file named '$file'"
#         return 1
#      fi
#      shift
#   done
#}



# Faster ssh to CalPoly unix servers
alias unix1='ssh mpwillia@unix1.csc.calpoly.edu'
alias unix2='ssh mpwillia@unix2.csc.calpoly.edu'
alias unix3='ssh mpwillia@unix3.csc.calpoly.edu'
alias unix4='ssh mpwillia@unix4.csc.calpoly.edu'

#####################
# DIGITAL DEMOCRACY #
#####################

# Faster connection to DigiDem MySQL database
alias dddb='mysql -u mpwillia -p DDDB2015Apr'

# Faster ssh to Digital Democracy
alias digidemDev='ssh -i ~/.ssh/amazon.pem mpwillia@development.digitaldemocracy.org'
alias digidemTest='ssh -i ~/.ssh/amazon.pem mpwillia@test.digitaldemocracy.org'
#alias digidemStaging='ssh -i ~/.ssh/amazon.pem mpwillia@staging.digitaldemocracy.org'
alias digidemStaging='ssh -i ~/.ssh/amazon.pem mpwillia@52.33.64.32'
function digidemZeus() {
   output=`host -W 1 zues.ored.calpoly.edu`
   if [[ $? != 0 ]]; then
      echo "Off Campus; Going through unix2.csc.calpoly.edu"
      ssh -t mpwillia@unix2.csc.calpoly.edu ssh -i /home/mpwillia/.ssh/amazon.pem mpwillia@zues.ored.calpoly.edu
   else
      echo "On Campus; Connecting directly"
      ssh -i ~/.ssh/amazon.pem mpwillia@zues.ored.calpoly.edu
   fi
}
alias ddDev='digidemDev'
alias ddTest='digidemTest'
alias ddStaging='digidemStaging'
alias ddZeus='digidemZeus'

# Faster sftp to Digital Democracy
alias digidemDevSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@development.digitaldemocracy.org'
alias digidemTestSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@test.digitaldemocracy.org'
#alias digidemStagingSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@staging.digitaldemocracy.org'
alias digidemStagingSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@52.33.64.32'
function digidemZeusSFTP() {
   output=`host -W 1 zues.ored.calpoly.edu`
   if [[ $? != 0 ]]; then
      echo "Off Campus; Going through unix2.csc.calpoly.edu"
      ssh -t mpwillia@unix2.csc.calpoly.edu sftp -oIdentityFile=/home/mpwillia/.ssh/amazon.pem mpwillia@zues.ored.calpoly.edu
   else
      echo "On Campus; Connecting directly"
      sftp -i ~/.ssh/amazon.pem mpwillia@zues.ored.calpoly.edu
   fi
}
alias ddDevSFTP='digidemDevSFTP'
alias ddTestSFTP='digidemTestSFTP'
alias ddStagingSFTP='digidemStagingSFTP'
alias ddZeusSFTP='digidemZeusSFTP'


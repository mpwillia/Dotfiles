
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

# Quick pushing/popping dirs
alias +='pushd'
alias +.='+ .'
alias -- -='popd'
alias ?='dirs -v'

# Makes directory and all parent directories as needed
alias mkdirs='mkdir -p'

# Recursively removes the given file, asks for confirmation for improved safety
alias rmr='rm -rI'

# Symbolic Links
alias symlink='ln -s'
alias sln='symlink'

# Quicker calls to python and python3
alias py='python'
alias py26='python2.6'
alias py27='python2.7'
alias py3='python3'


# Date and time - these are in theory useful but I never actually use them
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# lists all of the bash binds
alias binds='bind -P | grep -v "is not" | sed -e "s/can be found on/:/" | column -s: -t'

# simple calculator
=() { echo $(($*)); }

# Faster and more descriptive compression/decompression
function compress() {
   if [[ $# == 2 ]]; then
      tar -zcvf $1 $2
   else
      echo "invalid arguments, expects:"
      echo "compress <output archive name> <input file name>"
   fi
} 
#alias compress='tar -zcvf'
      #NOTE: These are ways to parse string file paths with pure bash
      # path="example/path/.archive.tar.gz"
      # xpath=${path%/*}      ->    example/path
      # xbase=${path##*/}     ->    .archive.tar.gz
      # xfext=${xbase##*.}    ->    .gz
      # xpref=${xbase%.*}     ->    .archive.tar
# expands the given archive using the appropriate expansion program based on the file extension
function expand() {
   if [[ $# == 1 ]]; then 
      tar -zxvf $1
   else
      echo "invalid arguments, expects:"
      echo "expand <archive name>" 
   fi
} 
#alias expand='tar -zxvf'

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
      du -ah --max-depth=1
   elif [[ $1 =~ ^[0-9]+$ ]]; then
      du -ah --max-depth=$1
   else
      du -ah $*
   fi
} 

# Quick wrapper to print hard drive device info
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

# Gets the size of the given hard drive device
function hdsize() {
   info=$(hdinfo $*)
   info=${info##*device size with M}
   info=${info%%cache/buffer size*}
   info=${info##*: }
   echo $info
}

alias distinfo='cat /etc/*-release'
alias cpuinfo='cat /proc/cpuinfo'
alias meminfo='cat /proc/meminfo'

#/sys/devices/virtual/dmi/id/
#alias moboinfo='cat /sys/devices/virtual/dmi/id/board_vendor /sys/devices/virtual/dmi/id/board_name /sys/devices/virtual/dmi/id/board_version'
alias moboinfo='echo -e "Vendor: $(cat /sys/devices/virtual/dmi/id/board_vendor)\nProduct: $(cat /sys/devices/virtual/dmi/id/board_name)\nVersion: $(cat /sys/devices/virtual/dmi/id/board_version)"'

#alias biosinfo='cat /sys/devices/virtual/dmi/id/bios_*'
alias biosinfo='echo -e "Vendor: $(cat /sys/devices/virtual/dmi/id/bios_vendor)\nDate: $(cat /sys/devices/virtual/dmi/id/bios_date)\nVersion: $(cat /sys/devices/virtual/dmi/id/bios_version)"'



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


# Just useful commands for moving to and from dd-data
function dddataset() {
   if [[ $# > 0 && $1 =~ ^[0-9]+$ ]]; then
      cd "/dd-data/dataset/dd-dataset/dd-dataset-$1"
   else
      cd "/dd-data/dataset"
   fi
} 
alias ddimages='cd /dd-data/ddimages' 
alias ddmodels='cd /dd-data/models'
alias ddvideos='cd /dd-data/videos'
alias ddsrc='cd /home/mpwillia/Development/dd-FacialRecognition'






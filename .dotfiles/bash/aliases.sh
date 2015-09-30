
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

# history aliases
alias h='history'
alias hg='history | grep'
function hv() {
   eval $(eval "echo $(hg vim | grep -m 1 $1) | grep -o \"vim.*\"")
}

# easier creation/unpacking of .tar.gz

# cd aliases
alias cd..='cd ..'
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

# Date and time - these are in theory useful but I never actually use them
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# Faster compression/decompression
alias compress='tar -zcvf'
alias expand='tar -zxvf'

# Faster ssh to CalPoly unix servers
alias unix1='ssh mpwillia@unix1.csc.calpoly.edu'
alias unix2='ssh mpwillia@unix2.csc.calpoly.edu'
alias unix3='ssh mpwillia@unix3.csc.calpoly.edu'
alias unix4='ssh mpwillia@unix4.csc.calpoly.edu'

# Faster connection to DigiDem MySQL database
alias dddb='mysql -u mpwillia -p DDDB2015Apr'

alias numimgs='find .//. ! -name .png -print | grep -c //'

# Show/Hide Hidden Files/Folders in OSX
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#####################
# DIGITAL DEMOCRACY #
#####################

# Faster ssh to Digital Democracy
alias digidemDev='ssh -i ~/.ssh/amazon.pem mpwillia@development.digitaldemocracy.org'
alias digidemTest='ssh -i ~/.ssh/amazon.pem mpwillia@test.digitaldemocracy.org'
alias digidemStaging='ssh -i ~/.ssh/amazon.pem mpwillia@staging.digitaldemocracy.org'
alias ddDev='digidemDev'
alias ddTest='digidemTest'
alias ddStaging='digidemStaging'

# Faster sftp to Digital Democracy
alias digidemDevSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@development.digitaldemocracy.org'
alias digidemTestSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@test.digitaldemocracy.org'
alias digidemStagingSFTP='sftp -i ~/.ssh/amazon.pem mpwillia@staging.digitaldemocracy.org'
alias ddDevSFTP='digidemDevSFTP'
alias ddTestSFTP='digidemTestSFTP'
alias ddStagingSFTP='digidemStagingSFTP'


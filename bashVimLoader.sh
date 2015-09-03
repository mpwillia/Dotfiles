#!/bin/bash

usage="Usage: ./bashVimLoader <install | restore | push>"

if [[ $# != 1 ]]; then
   echo $usage
   exit 1
fi

case "$1" in
   install)
      
      #Name of the downloaded archive
      archive="master.tar.gz"

      #<url> ends up redirecting to 'https://codeload.github.com/mpwillia/dotfiles/tar.gz/master' anyways" 
      #So if the redirect from <url> is problematic or can't be dealt when downloading use <alturl>
      url="https://github.com/mpwillia/dotfiles/archive/$archive"
      alturl="https://codeload.github.com/mpwillia/dotfiles/tar.gz/master"
      
      #Name of the archive once expanded
      expanded="dotfiles-master"
      
      echo "Attempting download of dotfiles archive..."
      
      #Check to see what commands are available to download the master branch archive with
      DOWNLOAD_COMMANDS=(wget curl)
      for check in ${DOWNLOAD_COMMANDS[@]}; do
         if [[ -n $(command -v $check) && $? == 0 ]]; then
            COMMAND=$check
            break
         fi
      done
      
      msg="Using '$COMMAND' to download dotfiles archive..."
      #Use whatever download command is available if we found one
      case $COMMAND in
         wget)
            echo "$msg"
            wget $url
            ;;

         curl)
            echo "$msg"
            curl -LO $url
            ;;

         *)
            echo "Unable to download dotfiles archive, no supported command found to do so!"
            supported=""
            for com in ${DOWNLOAD_COMMANDS[@]}; do
               supported="$supported '$com'"
            done
            echo "Currently supported commands: $supported"
            echo "Please install one of the above to continue."
            exit 1
            ;;
      esac
      
      #Expand and enter downloaded archive
      echo
      echo "Expanding archive..."
      tar -xzvf ./$archive
      cd ./$expanded
      ls
      
      #Delete everything we downloaded, made, or whatever
      echo
      echo "Cleaning up..."
      cd .. 
      rm ./$archive
      rm -r ./$expanded
      
      echo
      echo "Installation Complete"
      echo
      ;;

   restore)

      ;;

   push)
      
      a="test/path/.dotfiles.tar.gz"
      xpath=${a%/*}
      xbase=${a##*/}
      xfext=${xbase##*.}
      xpref=${xbase%.*}

      echo
      echo path=${xpath}
      echo base=${xbase}
      echo pref=${xpref}
      echo ext=${xfext}
      echo

      # Names of the files, for use when adding to git commit
      FILE_NAMES=(.dotfiles .vimrc .vim bashVimLoader.sh)
      # Locations of the file, for use when copying them into clone 
      FILE_LOCATIONS=(~/${FILE_NAMES[0]} ~/${FILE_NAMES[1]} ~/${FILE_NAMES[2]} ./${FILE_NAMES[3]})

      #Clone into the github repo
      dir="./dotfiles"
      if [[ -e $dir ]]; then  
         echo "$dir already exists, will not overwrite." 
         exit 1;
      fi
      echo "Cloning github repo..."
      git clone https://github.com/mpwillia/dotfiles
      dir="./dotfiles" 
      
      #Copy all the files we want to update into the clone
      PUSH_FILES=(~/.dotfiles ~/.vimrc ~/.vim $0 nope)
     
      echo
      echo "Copying files into cloned repo..."
      for file in ${FILE_LOCATIONS[@]}; do
         if [[ -e $file ]]; then
            echo "Found file '$file'"
            cp -r $file $dir
         else 
            echo "Cannot find file '$file'"
         fi
      done

      # .dotfiles dir
      #cp -r ~/.dotfiles $dir
      # .vimrc
      #cp ~/.vimrc $dir
      # .vim
      #cp -r ~/.vim $dir 
      # this script
      #cp ./bashVimLoader.sh $dir
      
      echo
      echo "Adding, commiting, and pushing changes to cloned repo, if any..."
      cd $dir
      for file in ${FILE_NAMES[@]}; do
         if [[ -e $file ]]; then
            echo "Adding file '$file' to commit"
            git add $file
         fi
      done
      git commit -m "Commit from script on $(date)"
      git push -u origin master
      cd ..
      
      echo
      echo "Cleaning up..."
      rm -rf $dir
     
      echo
      echo "Push Complete"
      echo
      ;;

   *)
      echo $usage
      exit 1
      ;;
esac



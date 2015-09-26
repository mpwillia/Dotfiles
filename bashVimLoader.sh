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
      pushd ./$expanded
      ls

      BACKUP_DIR="~/dotfiles-backup"
      INSTALL_FILES=(~/.dotfiles ~/.vimrc ~/.vim) 
      BASHRC="~/.bashrc"
      
      #Handle case of backup directory already existing
      if [[ -e $BACKUP_DIR ]]; then
         echo "Backup already exists, overwrite? (y/n)"
         
         while [[ -z $ANSWER ]]; do
            read ans
            case $ans in
               "y" | "Y" | "yes" | "YES")
                  ANSWER=yes
                  ;;

               "n" | "N" | "no" | "NO")
                  ANSWER=no
                  ;;

               *)
                  echo "Invalid answer, overwrite previous backup? (y/n)"
                  ;;
            esac
         done

         if [[ $answer == yes ]]; then
            rm -r $BACKUP_DIR
         else
            echo "Will not overwrite existing files without making a backup, either remove or copy the existing backup."
            exit 1
         fi
      fi

      mkdir $BACKUP_DIR

      #Make backup of what's already there
      for file in ${INSTALL_FILES[@]}; do
         echo $file         
      done

      #Delete everything we downloaded, made, or whatever
      echo
      echo "Cleaning up..."
      popd
      rm ./$archive
      rm -r ./$expanded
      
      echo
      echo "Installation Complete"
      echo
      ;;

   restore)

      ;;

   push)

      #NOTE: These are ways to parse string file paths with pure bash
      # path="example/path/.archive.tar.gz"
      # xpath=${path%/*}      ->    example/path
      # xbase=${path##*/}     ->    .archive.tar.gz
      # xfext=${xbase##*.}    ->    .gz
      # xpref=${xbase%.*}     ->    .archive.tar
      
      #These are the files to push to the repo
      PUSH_FILES=(~/.dotfiles ~/.vimrc ~/.vim $0)
      #PUSH_FILES=(~/.dotfiles ~/.vim $0)

      #Clone into the github repo
      dir="./dotfiles"
      if [[ -e $dir ]]; then  
         echo "$dir already exists, will not overwrite." 
         exit 1;
      fi
      echo "Cloning github repo..."
      git clone https://github.com/mpwillia/dotfiles
      
      pushd $dir
      echo
      shopt -s extglob
      shopt -s dotglob
      test=`echo !(.git|README.md)`
      echo $test
      rm -rf $test
      shopt -u extglob
      shopt -u dotglob
      popd

      #Copy all the files we want to update into the clone
      echo
      echo "Copying files into cloned repo..."
      for file in ${PUSH_FILES[@]}; do
         if [[ -e $file ]]; then
            echo "Found file '$file'"
            cp -r $file $dir
         else 
            echo "Cannot find file '$file'"
         fi
      done

      pushd $dir
      echo
      echo "Adding, commiting, and pushing changes to cloned repo, if any..."
      for file in ${PUSH_FILES[@]}; do
         filebase=${file##*/}
         if [[ -e $filebase ]]; then
            echo "Adding file '$filebase' to commit"
            git add $filebase
         fi
      done
      git commit -m "Commit from script on $(date)"
      git push -u origin master
      popd

      echo
      echo "Cleaning up..."
      #rm -rf $dir
     
      echo
      echo "Push Complete"
      echo
      ;;

   *)
      echo $usage
      exit 1
      ;;
esac



#!/bin/bash
set -e

usage="Usage: ./bashVimLoader <install | restore | push>"

if [[ $# != 1 ]]; then
   echo $usage
   exit 1
fi

#Setup tempdir along with cleanup trap
TEMPDIR=`mktemp -d`
echo "Temp directory setup at '$TEMPDIR'"

cleanup() {
   exitcode=$?
   echo -e "\nCleaning up..."
   rm -rf $TEMPDIR
   echo
   if [[ $exitcode != 0 ]]; then
      echo -e "\tFAILED"
   else
      echo -e "\tSUCCESS"
   fi
}
trap "cleanup" EXIT

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
            wget -P $TEMPDIR $url
            ;;

         curl)
            echo "$msg"
            (cd $TEMPDIR; curl -LO $url)
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
      tar -xzvf $TEMPDIR/$archive -C $TEMPDIR

      #NOTE: We are now inside the expanded archive
      #All the install files are in this directory, '.'
      pushd $TEMPDIR/$expanded
      echo

      BACKUP_DIR="$HOME/dotfiles-backup"
      #INSTALL_DIR="$HOME/test"
      INSTALL_DIR="$HOME"
      BASHRC="$INSTALL_DIR/.bashrc"
      INSTALL_FILES=(.dotfiles .vimrc .vim) 
      BASHRC_APPEND="$INSTALL_DIR/.dotfiles/.bashrc_append"
      
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

         if [[ $ANSWER == yes ]]; then
            rm -r $BACKUP_DIR
         else
            echo "Will not overwrite existing files without making a backup, either remove or copy the existing backup."
            exit 1
         fi
      fi
      
      mkdir $BACKUP_DIR

      #Make backup of what's already there
      echo
      echo "Making backup..."
      for file in ${INSTALL_FILES[@]}; do
         file=$HOME/$file
         if [[ -e $file ]]; then
            echo "Backing up file '$file'"
            cp -r $file $BACKUP_DIR
         fi
      done
     
      if [[ -e $BASHRC ]]; then
         echo "Backing up file '$BASHRC'"
         cp -r $BASHRC $BACKUP_DIR
      fi
      
      #Start installation
      echo
      if [[ -e $INSTALL_DIR ]]; then
         echo "Installing files to dir '$INSTALL_DIR'..."
         #Install files - copy what we need to
         for file in ${INSTALL_FILES[@]}; do
            file=./$file
            filename=${file##*/}
            echo "Installing file '$filename'"
            cp -r $file $INSTALL_DIR
         done
        
         #Install files - update '.bashrc' if we need to
         echo
         echo "Updating '$BASHRC'..."
         append=`cat $BASHRC_APPEND`
         if grep -q "$append" "$BASHRC"; then
            echo ".bashrc already loads installed files"
         else
            echo "Setting .bashrc to load installed files"
            cat "$BASHRC_APPEND" >> "$BASHRC"
         fi
         
         exit
      else
         echo "Cannot find install directory '$INSTALL_DIR'"
         exit 1
      fi
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

      #Clone into the github repo
      dir="$TEMPDIR/dotfiles"
      if [[ -e $dir ]]; then  
         echo "$dir already exists, will not overwrite." 
         exit 1;
      fi

      pushd $TEMPDIR
      echo "Cloning github repo..."
      git clone https://github.com/mpwillia/dotfiles
      popd

      #Delete files except for core git files
      pushd $dir
      echo
      shopt -s extglob
      shopt -s dotglob
      delFiles=`echo !(.git|README.md)`
      echo $delFiles
      rm -rf $delFiles
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
      ;;

   *)
      echo $usage
      exit 1
      ;;
esac




usage="Usage: ./bashVimLoader <install | restore | push>"

if [[ $# != 1 ]]; then
   echo $usage
   exit 1
fi

case "$1" in
   install)

      ;;

   restore)

      ;;

   push)
      dir="./dotfiles"
      if [[ -e $dir ]]; then  
         echo "$dir already exists, will not overwrite." 
         exit 1;
      fi
      git clone https://github.com/mpwillia/dotfiles
      dir="./dotfiles" 
      # .dotfiles dir
      cp -r ~/.dotfiles $dir
      # .vimrc
      cp ~/.vimrc $dir
      # .vim
      cp -r ~/.vim $dir 
      # this script
      cp ./bashVimLoader.sh $dir

      cd $dir
      git add .dotfiles
      git add .vimrc
      git add .vim
      git add bashVimLoader.sh
      git commit -m "Commit from script on $(date)"
      git push -u origin master
      cd ..
      sudo rm -r $dir

      ;;

   *)
      echo $usage
      exit 1
      ;;
esac



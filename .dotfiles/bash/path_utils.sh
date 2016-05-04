
# path_utils.sh define a number of various useful path manipulation functions
#
#NOTE: These are ways to parse string file paths with pure bash
# path="example/path/.archive.tar.gz"
# xpath=${path%/*}      ->    example/path
# xbase=${path##*/}     ->    .archive.tar.gz
# xfext=${xbase##*.}    ->    .gz
# xpref=${xbase%.*}     ->    .archive.tar
#


# Pass this function the $0 argument of a script and it will return the absolute
# path to the directory the script is located in.
function scriptpath() {
   echo $( cd $(dirname $1) ; pwd -P )  
}

function parent_path() {
   echo ${1%/*} 
} 

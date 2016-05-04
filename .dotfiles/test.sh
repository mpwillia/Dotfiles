
source path_utils.sh

#SCRIPT_PATH=$(scriptpath)
SCRIPT_PATH=$(scriptpath $0)
echo $SCRIPT_PATH

PARENT_PATH=$(parent_path $SCRIPT_PATH)
echo $PARENT_PATH

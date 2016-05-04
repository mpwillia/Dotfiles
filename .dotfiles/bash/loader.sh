DOTFILE_DIR="${HOME}/.dotfiles/bash"
export DOTFILE_DIR
export PATH=$PATH:$DOTFILE_DIR

source "$DOTFILE_DIR/colors.sh"
source "$DOTFILE_DIR/aliases.sh"
source "$DOTFILE_DIR/path_utils.sh"

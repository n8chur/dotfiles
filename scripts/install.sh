# install.sh
# symlink you dotfiles to appropriate places

DIR=$HOME/.dotfiles

DOTFILES=(
	".vimrc"
    ".xvimrc"
	".config/nvim"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done

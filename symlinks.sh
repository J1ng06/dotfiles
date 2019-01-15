#!/bin/sh

# Create symbolic links for all apps in the home directory

# Run this script from the directory that will act as the TARGET for the links

dir=$(readlink -f .)

echo Creating symbolic links from \'$dir\' to \'$HOME\'...

mkdir -p $HOME/.config

# SXHKD

ln --force --symbolic --verbose $dir/sxhkd/ $HOME/.config/

# Clojure

ln --force --symbolic --verbose $dir/clojure/deps.edn $HOME/.config/clojure/
ln --force --symbolic --verbose $dir/clojure/rebel_readline.edn $HOME/.config/clojure/
ln --force --symbolic --verbose $dir/clojure/rebel_readline.edn $HOME/.clojure/

# Git
ln --force --symbolic --verbose $dir/git/linux/.gitconfig $HOME/

# Nvim
ln --force --symbolic --verbose $dir/nvim/ $HOME/.config/

# SBCL
ln --force --symbolic --verbose $dir/sbcl/.sbcl_completions $HOME/

# Vim
ln --force --symbolic --verbose $dir/nvim/init.vim $HOME/.vimrc
ln --force --symbolic --verbose $dir/vim/.gvimrc $HOME/
ln --force --symbolic --verbose $dir/nvim/ $HOME/.vim

# Zsh
ln --force --symbolic --verbose $dir/zsh/.zshrc $HOME/
ln --force --symbolic --verbose $dir/zsh/shell_aliases $HOME/
ln --force --symbolic --verbose $dir/zsh/shell_functions $HOME/

echo Done.

" # Main Settings

" Auto-install vim-plug (if not detected)
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif



source ~/.config/nvim/plugins.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/mappings.vim

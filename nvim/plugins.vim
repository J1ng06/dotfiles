" # Plugins
"
" This file registers all plugins via Vim-Plug.
"
" Some useful Vim-Plug commands:
"
" * PlugStatus
"   * Check status of plugins
" * PlugUpdate
"   * Install/update all plugins
" * PlugClean
"   * Remove unused directories
" * PlugUpgrade
"   * Upgrade vim-plug itself

call plug#begin('~/.config/nvim/plugged')



" ## Code/Syntax Plugins
" -----------------------------------------------------------------------------

" Friendlier word navigation for code
Plug 'chaoren/vim-wordmotion'

" Toggle code comments
Plug 'tpope/vim-commentary'

" Preview CSS colours
Plug 'ap/vim-css-color'

" CTags browser
Plug 'majutsushi/tagbar'

" General completion engine for neovim (also needed by async-clj-omni)
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Git
Plug 'tpope/vim-fugitive'
" Commit browser
Plug 'junegunn/gv.vim'

" Javascript
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Lisp
Plug 'luochen1990/rainbow'

" Go
Plug 'w0rp/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Don't use parinfer plugin in diff mode
if !&diff
  Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }
endif
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
Plug 'clojure-vim/async-clj-omni'
Plug 'tpope/vim-fireplace'
" Haven't been using Common Lisp..
" Plug 'kovisoft/slimv'

" Database
Plug 'tpope/vim-dadbod'



" ## Colour Schemes
" -----------------------------------------------------------------------------

Plug 'KeitaNakamura/neodark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'



" ## File/Search Plugins
" -----------------------------------------------------------------------------

" File browser
Plug 'scrooloose/nerdtree'

" Fuzzy search files/text
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Display number of search matches
Plug 'google/vim-searchindex'

" Quick (vimium-style) navigation
Plug 'justinmk/vim-sneak'

" Multi-file search/replace
Plug 'wincent/ferret'

" Show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'



" ## Text Manipulation Plugins
" -----------------------------------------------------------------------------

" Surrounding
Plug 'tpope/vim-surround'
" Repeat surrounding
Plug 'tpope/vim-repeat'

" Create custom text objects more easily
Plug 'kana/vim-textobj-user'

" Indentation levels as text objects
Plug 'kana/vim-textobj-indent'

" Sorting via text objects and motions
Plug 'christoomey/vim-sort-motion'

" Make all words in line title case
Plug 'christoomey/vim-titlecase'

" Easily create/edit markdown tables
Plug 'dhruvasagar/vim-table-mode'



" Misc Plugins
" -----------------------------------------------------------------------------

" Use TAB for all completions
Plug 'ervandew/supertab'

" Cool status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" Highlight yanked text
Plug 'machakann/vim-highlightedyank'

" Closing buffers
Plug 'Asheq/close-buffers.vim'

" Easily resize and move windows
Plug 'simeji/winresizer'

" Visualize undo history
Plug 'sjl/gundo.vim'

" Safely close buffers (without closing windows, etc.)
Plug 'moll/vim-bbye'



call plug#end()

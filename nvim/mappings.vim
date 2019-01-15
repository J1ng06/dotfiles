" # Mappings
"
" This file contains all custom mappings

" ## General
" -----------------------------------------------------------------------------

" Leader key is space
let mapleader=' '

" Escape insert mode
inoremap <C-Space> <ESC>

" Disable ex mode (nobody seems to use this)
nnoremap Q <nop>

" Quit
nnoremap <leader>q :qa<CR>



" ## Buffers
" -----------------------------------------------------------------------------

" Close buffer without also closing splits
nnoremap <leader>d :Bwipeout<CR>

" Close hidden buffers (not visible in any window)
nnoremap <leader>bh :CloseHiddenBuffers<CR>

" Navigate buffers
" This is done with VimEnter to get around Fireplace mapping <S-K>
if !&diff
  autocmd VimEnter * nnoremap <S-J> :bp<CR>
  autocmd VimEnter * nnoremap <S-K> :bn<CR>
endif

" Navigate display lines (not actual lines)
noremap <silent> <Up> gk
noremap <silent> <Down> gj
noremap <silent> k gk
noremap <silent> j gj



" ## Clojure
" -----------------------------------------------------------------------------

" Lookup documentation on symbol (doc SYMBOL):
nnoremap <leader>kd mxyiw`x<C-w><C-l>Gi(doc <C-\><C-n>pi)<CR><C-\><C-n><C-w><C-h>

" Code completion at cursor:
inoremap <A-Space> <ESC>mxyiw`x<C-w><C-p>i(apropos #"^<C-\><C-n>pi.*")<CR><C-\><C-n><C-w><C-p>a

" Fireplace: lookup doc of current word
" (Need this as I'm overriding the default <C-k>)
au FileType clojure nmap <leader>kk :Doc <C-r><C-w><CR>

" Fireplace: search docs
nnoremap <leader>ks :FindDoc<space>

" Fireplace: lookup doc on Java class
nnoremap <leader>kj :Javadoc<space>

" ## Golang
" -----------------------------------------------------------------------------

" Go to definition
au FileType go nmap <leader>kg <Plug>(go-def)

" Show documentation
au FileType go nmap <leader>kk :GoDoc<CR>

" ## Code (Generic)
" -----------------------------------------------------------------------------

nmap <leader>kt :TagbarToggle<CR>



" ## Commenting
" -----------------------------------------------------------------------------

nmap <leader>c gc
vmap <leader>c gc



" ## Common Lisp
" -----------------------------------------------------------------------------

" Haven't been using Common Lisp..
" imap <C-Y> λ
" autocmd Filetype lisp inoremap <buffer> <C-D> (declaim (optimize (debug 3) (safety 3) (speed 0)))



" ## Copy/Paste
" -----------------------------------------------------------------------------

" Copy everything to the clipboard
nnoremap <leader>ya :%y+<CR>

" Copy current file path to clipboard
nmap <leader>yf :let @+ = expand("%") <cr>

" Paste last yanked text (works even after deleting in between)
nnoremap <leader>p "0p



" ## Diffs
" -----------------------------------------------------------------------------

if &diff
  nnoremap <S-J> ]c
  nnoremap <S-K> [c
endif



" ## Files/Dirs
" -----------------------------------------------------------------------------

" Print current working directory
nmap <leader>ww :pwd<CR>

" Change current directory to that of the current file
nmap <leader>wc :cd %:p:h<CR>:pwd<CR>

" Browse files
nmap <leader>ff :NERDTreeToggle<CR>

" Go to currently open file in buffer, in Nerd tree
nmap <leader>fo :NERDTreeFind<CR>

" File path completion
inoremap <C-f> <C-x><C-f>

" Re-open last file
nnoremap <leader><leader> :e#<CR>

" Save file
nnoremap <leader>fs :w<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>



" ## Git
" -----------------------------------------------------------------------------

" Search git commits under working directory
nmap <leader>gcc :Commits<CR>

" Commit browser for directory within which the current file resides
nmap <leader>gcb :GV<CR>

" Commit browser for commits affected by current file
nmap <leader>gcf :GV!<CR>

" Show differences for selected lines
vmap <leader>gd :GV?<CR>

" Search git commits for the current buffer
nmap <leader>gb :BCommits<CR>



" ## Gundo
" -----------------------------------------------------------------------------

nnoremap <leader>u :GundoToggle<CR>



" ## Matching
" -----------------------------------------------------------------------------

" Go to matching bracket, etc.
nnoremap <TAB> %
vnoremap <TAB> %

" For use with pressing * or # in visual mode to search for current selection
" Taken from: https://github.com/Phantas0s/.dotfiles/blob/master/nvim/autoload/general.vim
function! SearchInVisual(direction, extra_filter) range
  let l:saved_reg = @"
  execute 'normal! vgvy'

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", '', '')

  if a:direction is# 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction is# 'replace'
    call CmdLine('%s' . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call SearchInVisual('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call SearchInVisual('', '')<CR>?<C-R>=@/<CR><CR>



" ## Search
" -----------------------------------------------------------------------------

" Search across all files in cwd recursively
nmap <leader>saa <Plug>(FerretAck)

" Search across all files in cwd recursively, for the word under the cursor
nmap <leader>saw <Plug>(FerretAckWord)

" Search buffers
nmap <leader>sb :Buffers<CR>

" Search commands
nmap <leader>sx :Commands<CR>

" Clear search
nnoremap <leader>sc :nohlsearch<CR>

" Search files in current directory
nmap <leader>sf :Files<CR>

" Search recently opened files
nmap <leader>sh :History<CR>

" Search key maps
nmap <leader>sk :Maps<CR>

" Search line numbers in all buffers
nmap <leader>sl :Lines<CR>

" Search marks
nmap <leader>sm :Marks<CR>

" Search for text in all files in current directory recursively
" NOTE: this requires 'ripgrep'
nmap <leader>st :Rg<CR>

" Search windows
nmap <leader>sw :Windows<CR>



" ## Sneak
" -----------------------------------------------------------------------------

let g:sneak#label = 1
map f <Plug>Sneak_s
map F <Plug>Sneak_S


" ## Terminal
" -----------------------------------------------------------------------------

if has("nvim")
  map <leader>t :MyPureTerminal<CR>
  tnoremap <C-Space> <C-\><C-n>
  tnoremap <C-j> <down>
  tnoremap <C-k> <up>
  tnoremap <C-h> up<CR>
endif

" Execute current line in shell
nnoremap <leader>x :exec '!'.getline('.')<CR>



" ## Text
" -----------------------------------------------------------------------------

" Since <S-j> is taken by buffer navigation, use this for joining lines
nnoremap <leader>j J
vnoremap <leader>j J

inoremap <C-j> <down>
inoremap <C-k> <up>

inoremap <C-h> <left>
inoremap <C-l> <right>

" Convert EOL characters from DOS to UNIX style
nnoremap <leader>ee :%s/\r\(\n\)/\1/g<CR>

" Swap the word the cursor is on with the next word (which can be on a
" newline, and punctuation is "skipped"):
nmap <silent> <leader>es "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>:noh<CR>

" Turn on spelling
nmap <leader>ep :setlocal spell spelllang=en_ca



" ## Vim Config
" -----------------------------------------------------------------------------

" Edit vim config files
nmap <leader>ve :e $MYVIMRC<CR>
  \ :e ~/.config/nvim/plugins.vim<CR>
  \ :e ~/.config/nvim/settings.vim<CR>
  \ :e ~/.config/nvim/mappings.vim<CR>

" Source (reload) vim config
nmap <silent> <leader>vs :so $MYVIMRC<CR>



" ## Windows
" -----------------------------------------------------------------------------

" Navigate windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vnoremap <C-h> <C-w>h
vnoremap <C-j> <C-w>j
vnoremap <C-k> <C-w>k
vnoremap <C-l> <C-w>l

if has("nvim")
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

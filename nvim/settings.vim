" # Vim Settings
"
" This file contains settings for vim proper and plugins

" Support millions of colours (default is 256 colours)
" Your terminal must support this
if has("nvim")
  set termguicolors
endif

" Enable syntax highlighting
syntax enable

" Use system clipboard
if has("win32") || has("win16")
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" We'll show status via the Lightline plugin only
set noshowmode

" Don't save any temp files
set noswapfile

" Enable filetype detection, scripts, indents
filetype plugin indent on

" Set relative line #, but the current line showing the absolute line #
set relativenumber number

" Highlight current line
set cursorline

" Highlight current column
set cursorcolumn

" Allow backspacing over anything in edit mode
set backspace=indent,eol,start

" Auto-indent next line
set autoindent

" Copy the previous indentation
set copyindent

" Spelling autocompletion
set complete+=kspell

" Ignore case when searching
set ignorecase

" Use case-sensitive search when phrase has upper-case letters
set smartcase

" Allow switching buffers without writing to disk
set hidden

" Highlight search terms
set hlsearch

" Search while typing
set incsearch

" Live substition preview
if has("nvim")
  set inccommand=split
endif

" Tab width set to two spaces
set tabstop=2 shiftwidth=2

" Replace tab with spaces
set expandtab

" Enhanced command-line completion
set wildmenu
set wildmode=list:longest,full

" Show a vertical column
set colorcolumn=80

" Store undo files here
set undofile
set undodir=~/.vim-undo-files
set undolevels=1000

" Smarter line wrapping
set wrap linebreak nolist

" Always show status line regardless of number of windows open
set laststatus=2

" Disable folding by default
set nofoldenable
set foldlevelstart=99
set foldlevel=99

" Scrolling tweaks
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Scroll when n number of lines before top/bottom
set scrolloff=5

" Automatically break line at n chars for text files
au filetype text setlocal textwidth=80

" Markdown (all text files)
au BufNewFile,BufRead *.txt set filetype=markdown

" Read .asd files with Lisp syntax highlighting
au BufNewFile,BufRead *.asd set filetype=lisp

" Read .ros files with Lisp syntax highlighting
au BufNewFile,BufRead *.ros set filetype=lisp

" Read .nunit files with XML syntax highlighting
au BufNewFile,BufRead *.nunit,*.proj set filetype=xml

" Read .*html files as HTML
au BufNewFile,BufRead *.*html set filetype=html

" Set default new file type to Markdown
au BufEnter * if &filetype == "" | setlocal ft=markdown | endif

" Auto-update diff view
autocmd BufWritePost * if &diff == 1 | diffupdate | endif



" ## Theme
" -----------------------------------------------------------------------------

set background=dark
colorscheme PaperColor



" ## Functions
" -----------------------------------------------------------------------------

" Show leader mappings in new buffer
function! ListLeaders()
   silent! redir @a
   silent! nmap <LEADER>
   silent! redir END
   silent! new
   silent! put! a
   silent! g/^s*$/d
   silent! %s/^.*,//
   silent! normal ggVg
   silent! sort
   silent! let lines = getline(1,"$")
endfunction
command! -register ListLeaders call ListLeaders()


" Common terminal settings
function! MyTerminal()
  autocmd BufEnter,WinEnter term://* call MyOnEnterTerminal()
  autocmd BufLeave,WinLeave term://* call MyOnLeaveTerminal()
  set laststatus=0
  set showmode
  terminal
  set bufhidden=hide
  set modifiable
  startinsert
endfunction

" Run the terminal emulator in a mode that mimicks the appearance of a regular
" terminal (i.e. without too much vim UI elements)
function! MyPureTerminal()
  let g:my_terminal_mode = 'pure'
  call MyTerminal()
  colorscheme default
  set nocursorline
  syntax off
endfunction
command! -register MyPureTerminal call MyPureTerminal()

" Run the terminal in a manner suitable for use with a Clojure REPL
function! MyCljTerminal()
  let g:my_terminal_mode = 'clj'
  call MyTerminal()
  set syntax=clojure
endfunction
command! -register MyCljTerminal call MyCljTerminal()

function! MyOnEnterTerminal()
  if g:my_terminal_mode == 'pure'
    colorscheme default
    set nocursorline
    syntax off
  endif
  set laststatus=0
endfunction

function! MyOnLeaveTerminal()
  if g:my_terminal_mode == 'pure'
    set background=dark
    colorscheme PaperColor
    set cursorline
    syntax on
  endif
  set laststatus=2
endfunction



" ## Better Whitespace
" -----------------------------------------------------------------------------

let g:better_whitespace_enabled = 1
" Don't auto-strip whitespace on save when in diff mode
if !&diff
  let g:strip_whitespace_on_save = 1
endif



" ## Clojure
" -----------------------------------------------------------------------------

augroup filetypedetect
  au BufRead,BufNewFile build.boot setfiletype clojure
augroup END

let g:clojure_align_multiline_strings = 1



" Common Lisp
" -----------------------------------------------------------------------------

let g:rainbow_active = 1

if has("win32") || has("win16")
  let g:slimv_swank_cmd = '!start ccl --load ~\.config\nvim\plugged\slimv\slime\start-swank.lisp'
else
  let g:slimv_swank_cmd = '! screen -d -m -t LISP-REPL -S lisp-repl ros run --load $HOME/.config/nvim/plugged/slimv/slime/start-swank.lisp'
endif

let g:paredit_mode=0 " Disable paredit mode (just doesn't work well enough)
let g:slimv_repl_split=4 " Open repl in vertical split to the right



" ## Deoplete
" -----------------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

" Clojure-specific (required by async-clj-omni)
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'



" ## FZF
" -----------------------------------------------------------------------------

" Use `fd` command instead of `find` when searching files with FZF
let $FZF_DEFAULT_COMMAND='fd --type f --follow'

" Show more search results than the default
let g:fzf_layout = { 'down': '~60%' }

" Customize fzf colors to match my colour scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Search text using Ripgrep (NOTE: using --color=always makes it really slow)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --ignore-case --follow --fixed-strings --ignore-file .fdignore '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)



" ## Gundo
" -----------------------------------------------------------------------------

let g:gundo_preview_bottom = 1
let g:gundo_right = 1



" ## Lightline/Bufferline
" -----------------------------------------------------------------------------

" Show tabs at the top, of opened buffers
set showtabline=2

let g:lightline#bufferline#show_number      = 0
let g:lightline#bufferline#shorten_path     = 1
let g:lightline#bufferline#unnamed          = '[New]'
" Only show tabs if 2 or more buffers are open
let g:lightline#bufferline#min_buffer_count = 2

let g:lightline                  = {}
let g:lightline.colorscheme      = 'one'
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" ## Go code highlighting and documentation
" -----------------------------------------------------------------------------
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_doc_keywordprg_enabled = 0

" ## Go code auto import dependencies
" -----------------------------------------------------------------------------
let g:go_fmt_command = "goimports"

" ## Markdown
" -----------------------------------------------------------------------------

" Don't fold by default
let g:vim_markdown_folding_disabled = 1

" Disable markdown auto-preview on start
let g:instant_markdown_autostart = 0



" ## NerdTree
" -----------------------------------------------------------------------------

" Don't use help bar at the top
let g:NERDTreeMinimalUI = 1

" The following allows opening multiple files by selecting in visual mode
" It is based on the following Gist:
" https://gist.github.com/PhilRunninger/99f0c78e48de42bf2010f30d983ff61f
function! s:OpenMultiple() range
  let curLine = a:firstline
  while curLine <= a:lastline
    call cursor(curLine, 1)
    let node = g:NERDTreeFileNode.GetSelected()
    if !empty(node) && !node.path.isDirectory
      call node.open({'where':'p', 'stay':1, 'keepopen':1})
    endif
    let curLine += 1
  endwhile
  if g:NERDTreeQuitOnOpen
    NERDTreeClose
  endif
endfunction

augroup NERDTreeOpenMultiple
  autocmd!
  autocmd BufNew NERD_tree_* vnoremap <buffer> o :call <SID>OpenMultiple()<CR>
augroup END



" ## SuperTab
" -----------------------------------------------------------------------------

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabClosePreviewOnPopupClose = 1



" ## Tagbar
" -----------------------------------------------------------------------------

" Generate ctags for markdown
" NOTE: the fol
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" NOTE: the following needs to be added to ~/.ctags.d/markdown.ctags (assuming
" Universal Ctags is installed):
"--langdef=markdown
"--langmap=markdown:.mkd
"--regex-markdown=/^#[ \t]+(.*)/\1/h,Heading_L1/
"--regex-markdown=/^##[ \t]+(.*)/\1/i,Heading_L2/
"--regex-markdown=/^###[ \t]+(.*)/\1/k,Heading_L3/



" ## Terminal
" -----------------------------------------------------------------------------

" This is to control settings between a regular terminal and one better suited
" as a lisp repl
let g:my_terminal_mode = 'pure'

" Unlimited scrollback
if has("nvim")
  set scrollback=-1
endif

" ## TernJS
" -----------------------------------------------------------------------------

" Whether to include documentation strings (if found) in the result data.
let g:deoplete#sources#ternjs#docs = 1



" ## WinResizer
" -----------------------------------------------------------------------------

" Disable reszing in GUI's since I don't use them
let g:winresizer_gui_enable = 0

" The default key-chord is <C-E> which is too useful for me to have overridden
let g:winresizer_start_key = '<C-T>'

" Amount of columns to resize vertically by
let g:winresizer_vert_resize = 5



" ## WordMotion
" -----------------------------------------------------------------------------

let g:wordmotion_prefix = ','

set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'chase/vim-ansible-yaml'
Plug 'ewortzman/groovyindent-unix'
Plug 'fisadev/vim-isort'
" Plug 'joonty/vdebug'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'timakro/vim-searchant'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/groovy.vim'

" Initialize plugin system
call plug#end()

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

syntax on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set scrolloff=10
set autoindent
set smartindent
set hlsearch
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set noswapfile
set ignorecase
set smartcase
set number
set nobackup

set pastetoggle=<F2>
set ruler
set colorcolumn=101

command W w
command Q q
command Path echo expand('%:p')

nnoremap <silent> QQ :q<CR>
nnoremap <silent> WW :w<CR>

inoremap <C-@> <C-p>

nmap     <F1> <Plug>SearchantStop
imap     <F1> <c-o><F1>
nnoremap <silent> <F3> :set invlist<CR>:set invnumber<CR>:IndentLinesToggle<CR>
imap     <silent> <F3> <c-o>:set invlist<CR><c-o>:set invnumber<CR><c-o>:IndentLinesToggle<CR>
vmap     <silent> <F8> <c-\><c-n><F8>gv
smap     <silent> <F8> <c-\><c-n><F8>gv<c-g>

colorscheme vividchalk
hi Search cterm=None ctermfg=darkgrey ctermbg=yellow
hi ColorColumn ctermbg=black cterm=reverse

""
 " Filetype configurations
 ""
au BufRead,BufNewFile *logcat* set filetype=logcat
au BufRead,BufNewFile .bash* set filetype=sh
au BufRead,BufNewFile *.hdef set filetype=json
au BufRead,BufNewFile *.yaml set filetype=ansible
au BufRead,BufNewFile *dockerfile* set filetype=dockerfile
au BufRead,BufNewFile *Dockerfile* set filetype=dockerfile
au BufRead,BufNewFile *jenkinsfile* set filetype=Jenkinsfile
au BufRead,BufNewFile *Jenkinsfile* set filetype=Jenkinsfile

au FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
au FileType python setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

""
 " NERD Commenter
 ""
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

""
 " NERD Tree
 ""
map <C-n> :NERDTreeToggle<CR>
imap <silent> <C-n> <c-o>:NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""
 " athena-plugin
 ""
let g:athena_plugin_setup_keybindings=1

""
 " indentLines
 ""
let g:indentLine_char='|'
" related
set list
set listchars=tab:›― 

""
 " Splits
 ""
nnoremap <silent> <C-Left> <C-W><Left>
nnoremap <silent> <C-Right> <C-W><Right>

""
 " Title
 ""
let hostname=substitute(hostname(), '\..*$', '', '')
let &titlestring="%{hostname} | %t%(\ %M%)%(\ [%{expand(\"%:~:h\")}]%)"
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term =~ "xterm"
  set title
endif

""
 " SMART HOME
 ""

"place in vimrc
nmap <silent><Home> :call SmartHome("n")<CR>
nmap <silent><End> :call SmartEnd("n")<CR>
imap <silent><Home> <C-r>=SmartHome("i")<CR>
imap <silent><End> <C-r>=SmartEnd("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
vmap <silent><End> <Esc>:call SmartEnd("v")<CR>

function SmartHome(mode)
  let curcol = col(".")
  "gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal g^
    else
      normal ^
    endif
  else
    if &wrap
      normal g0
    else
      normal 0
    endif
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

function SmartEnd(mode)
  let curcol = col(".")
  let lastcol = a:mode == "i" ? col("$") : col("$") - 1
  "gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif
  if curcol < lastcol
    if &wrap
      normal g$
    else
      normal $
    endif
  else
    normal g_
  endif
  "correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction

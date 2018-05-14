" General Vim settings
	set nocompatible
	syntax enable
	let mapleader=","
	set autoindent
	set tabstop=4 		" number of visual spaces per tab
	set shiftwidth=4
	set dir=/tmp/
	set smarttab
	set laststatus=2	" always show status line

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=0 " 2 tab spacing for js

set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained * set relativenumber
	autocmd BufLeave,FocusLost * set norelativenumber
augroup END

" Make ESC switch quickly
set timeoutlen=1000 ttimeoutlen=0

set showcmd			" Show commands in bottom bar
set cursorline 		" Highlight current line
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold
set wildmenu		" visual autocomplete for command menu
set lazyredraw		" redraw only when we need to
set showmatch		" highlight matching [{()}]

nnoremap <C-c> :set norelativenumber<CR>:set nonumber<CR>:echo "Line numbers turned off."<CR>
nnoremap <C-n> :set relativenumber<CR>:set number<CR>:echo "Line numbers turned on."<CR>
nnoremap <leader><space> :nohl<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
nnoremap J G
nnoremap K gg
nnoremap B ^
vnoremap B ^
nnoremap E $
vnoremap E $
" move vertically by visual line
nnoremap j gj
nnoremap k gk

map <tab> %

set backspace=indent,eol,start

" FOLDING
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <Space> za
set foldmethod=indent

nnoremap <leader>z zMzvzz

nnoremap vv 0v$

set listchars=tab:\|\ 
nnoremap <leader><tab> :set list!<cr>
	set pastetoggle=<F2>
	set mouse=a
	
	" SEARCH
	set incsearch
	set hlsearch
	set ignorecase
	set smartcase

" File and Window Management 
	inoremap <leader>w <Esc>:w<CR>
	nnoremap <leader>w :w<CR>

	inoremap <leader>q <ESC>:q<CR>
	nnoremap <leader>q :q<CR>

	inoremap <leader>x <ESC>:x<CR>
	nnoremap <leader>x :x<CR>

	nnoremap <leader>e :Ex<CR>
	nnoremap <leader>t :tabnew<CR>:Ex<CR>
	nnoremap <leader>v :vsplit<CR>:w<CR>:Ex<CR>
	nnoremap <leader>s :split<CR>:w<CR>:Ex<CR>
	nnoremap <leader>h <C-w>h
	nnoremap <leader>H <C-w>H
	nnoremap <leader>l <C-w>l
	nnoremap <leader>L <C-w>L
	nnoremap <leader>j <C-w>j
	nnoremap <leader>J <C-w>J
	nnoremap <leader>k <C-w>k
	nnoremap <leader>K <C-w>K
	nnoremap <leader>n <C-w>w
	" toggle NerdTree
	nnoremap <leader>ff :NERDTreeToggle<CR>
	" toggle gundo
	nnoremap <leader>u :GundoToggle<CR>
	" open ag.vim
	nnoremap <leader>a :tabnew<CR>:Ack<space>

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" Install Vim-Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Auto-load plugins on startup
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC

" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'mileszs/ack.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe'
call plug#end()

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_server_use_vim_stdout = 0

" Ack
" ON NEW COMPUTER FIGURE OUT HOW TO GET Ag
let g:ackpreview = 1
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" CtrlP 
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" ALE
let g:ale_fixers = {
\	'javascript': ['eslint']
\}
let g:ale_fix_on_save=1

" GitGutter 
let g:gitgutter_map_keys = 0 " disable <leader> commands, conflicts with <leader>h

" COLORS
" base16/tomorrow onedark, badwolf, darcula, gruvbox, dracula, onehalf light
let g:airline_theme='onedark'
set t_Co=256
colorscheme onedark 
set termguicolors


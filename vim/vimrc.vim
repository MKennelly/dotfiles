" General Vim settings

	syntax enable
	let mapleader=","
	set autoindent
	set tabstop=4 		" number of visual spaces per tab
	set dir=/tmp/
	set smarttab
	set laststatus=2	" always show status line

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
	nnoremap L $
	nnoremap J G
	nnoremap K gg
	nnoremap B ^
	nnoremap E $
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
	set smartcase

" Language Specific
	" General
		inoremap <leader>for <esc>Ifor (int i = 0; i < <esc>A; i++) {<enter>}<esc>O<tab>
		inoremap <leader>if <esc>Iif (<esc>A) {<enter>}<esc>O<tab>

	" Java
		inoremap <leader>sys <esc>ISystem.out.println(<esc>A);
		vnoremap <leader>sys yOSystem.out.println(<esc>pA);

	" Java
		inoremap <leader>con <esc>Iconsole.log(<esc>A);
		vnoremap <leader>con yOconsole.log(<esc>pA);

	" C++
		inoremap <leader>cout <esc>Istd::cout << <esc>A << std::endl;
		vnoremap <leader>cout yOstd::cout << <esc>pA << std:endl;

	" C
		inoremap <leader>out <esc>Iprintf(<esc>A);<esc>2hi
		vnoremap <leader>out yOprintf(, <esc>pA);<esc>h%a

	" Typescript
		autocmd BufNewFile,BufRead *.ts set syntax=javascript
		autocmd BufNewFile,BufRead *.tsx set syntax=javascript

	" Markup
		inoremap <leader>< <esc>I<<esc>A><esc>yypa/<esc>O<tab>


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
	nnoremap <leader>l <C-w>l
	nnoremap <leader>j <C-w>j
	nnoremap <leader>k <C-w>k
	nnoremap <leader>n <C-w>w
	" toggle NerdTree
	nnoremap <leader>ff :NERDTreeToggle<CR>
	" toggle gundo
	nnoremap <leader>u :GundoToggle<CR>
	" open ag.vim
	nnoremap <leader>a :Ag<space>

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
Plug 'rking/ag.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" CtrlP 
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" COLORS
let g:airline_theme='onedark'
set t_Co=256
colorscheme onedark 
set termguicolors


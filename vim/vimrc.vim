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
filetype plugin indent on

autocmd FileType javascript,html,css,scss setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=0 " 2 tab spacing for web dev

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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

nnoremap <leader><space> :nohl<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

" File navigation
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

set backspace=indent,eol,start

" FOLDING
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <Space> za
set foldmethod=indent

nnoremap <leader>z zMzvzz

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
	" Replace
	nnoremap <leader>r :%s///g<left><left><left>
	" ImportJS
	nnoremap <leader>m :ImportJSWord<CR>

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

" PLUGINS
call plug#begin('~/.vim/plugged')
" Themes/styling
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
" File Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
" Super undo
Plug 'sjl/gundo.vim'
" Git/Linting
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
" Stuff to make surrounding code easy
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
" Comment toggling
Plug 'vim-scripts/tComment'
" Show colours in code
Plug 'ap/vim-css-color'
"AutoComplete/Snippets
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
" supertab makes tab work with autocomplete and ultisnips
Plug 'ervandew/supertab'
"Emmet
Plug 'mattn/emmet-vim'
" Scratch files
Plug 'duff/vim-scratch'
" JS Imports
Plug 'galooshi/vim-import-js', { 'do': 'sudo npm install -g import-js' }
call plug#end()

" YouCompleteMe
let g:ycm_python_interpreter_path = '/usr/local/bin/python2.7'
let g:ycm_server_use_vim_stdout = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

" UltiSnips config
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips']
let g:UltiSnipsEditSplit="vertical"
" YouCompleteMe and UltiSnips compatibility.
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Prevent UltiSnips from removing our carefully-crafted mappings.
" let g:UltiSnipsMappingsToIgnore = ['autocomplete']

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
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$'
\ }

" ALE
let g:ale_fixers = {
\	'javascript': ['eslint']
\}
let g:ale_fix_on_save=1

" GitGutter 
let g:gitgutter_map_keys = 0 " disable <leader> commands, conflicts with <leader>h

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

"vim-emmet
let g:user_emmet_leader_key='<C-E>'

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" COLORS
" base16/tomorrow onedark, badwolf, darcula, gruvbox, dracula, onehalf light
let g:airline_theme='onedark'
set t_Co=256
colorscheme onedark 
set termguicolors


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
set ttyfast
set lazyredraw
filetype plugin indent on
set spelllang=en_ca
set t_Co=256
set termguicolors

" Spaces/tabs
autocmd FileType javascript,html,css,scss,json,liquid,reason setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=0 " 2 tab spacing for web dev
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 expandtab softtabstop=0 " 4 tab spaces

" Odd file extensions
autocmd BufRead,BufNewFile *.prisma setfiletype graphql
autocmd BufNewFile,BufRead *.eslintrc set syntax=json
autocmd BufNewFile,BufRead *.prettierrc set syntax=json

" Spelling on for certain file types
autocmd FileType markdown,text,gitcommit setlocal spell

"Trigger `autoread` when files changes on disk
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
set wildmode=longest:full,full
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

set listchars=eol:$,trail:·,tab:\|\
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

	nnoremap <leader>e :Exp<CR>
	nnoremap <leader>t :tabnew<CR>:Exp<CR>
	nnoremap <leader>v :vsplit<CR>:w<CR>:Exp<CR>
	nnoremap <leader>s :split<CR>:w<CR>:Exp<CR>
	nnoremap <leader>h <C-w>h
	nnoremap <leader>H <C-w>H
	nnoremap <leader>l <C-w>l
	nnoremap <leader>L <C-w>L
	nnoremap <leader>j <C-w>j
	nnoremap <leader>J <C-w>J
	nnoremap <leader>k <C-w>k
	nnoremap <leader>K <C-w>K
	nnoremap <leader>n <C-w>w
	" Replace
	nnoremap <leader>r :%s///g<left><left><left>
	" Spell checking
	nnoremap <leader>zz :set spell<CR>
	nnoremap <leader>zn :set nospell<CR>
	" toggle NerdTree
	nnoremap <leader>ff :NERDTreeToggle<CR>
	" toggle undotree
	nnoremap <leader>u :UndotreeToggle<CR>
	" open ag.vim
	nnoremap <leader>a :tabnew<CR>:Ack<space>
	" ImportJS
	nnoremap <leader>m :ImportJSWord<CR>

" Return to the same line you left off at
	" FZF + ripgrep
	nnoremap <C-p> :Files<CR>
	nnoremap <C-g> :Rg<CR>
	nnoremap <leader>fr :Rg!<space>
	nnoremap <leader>fac :Commits<CR>
	nnoremap <leader>fbc :BCommits<CR>
	nnoremap <leader>fc :Colors<CR>
	nnoremap <leader>fg :GFiles?<CR>
	nnoremap <leader>fm :Maps<CR>
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" *************************************************************************************************
" PLUGIN related config
" *************************************************************************************************

" Install Vim-Plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif


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
Plug 'mileszs/ack.vim'
" FZF fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Find and replace
Plug 'brooth/far.vim'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
Plug 'slashmili/alchemist.vim' " Elixir completion
" Super undo
Plug 'mbbill/undotree'
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
" AutoComplete/Snippets
Plug 'lifepillar/vim-mucomplete'
Plug 'SirVer/ultisnips'
" supertab makes tab work with autocomplete and ultisnips
Plug 'ervandew/supertab'
" Tag Support
Plug 'ludovicchabant/vim-gutentags'
"Emmet
Plug 'mattn/emmet-vim'
" Scratch files
Plug 'duff/vim-scratch'
" JS Imports
Plug 'galooshi/vim-import-js', { 'do': 'sudo npm install -g import-js' }
call plug#end()

" *************************************************************************************************
" PLUGIN related config
" *************************************************************************************************

" MUComplete
set completeopt+=menuone,noselect
set shortmess+=c
set belloff+=ctrlg
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#buffer_relative_paths = 1
let g:mucomplete#chains = {
    \ 'default' : ['ulti', 'path', 'omni', 'keyn', 'dict', 'uspl'],
    \ 'vim'     : ['ulti', 'path', 'cmd', 'keyn']
    \ }
" UltiSnips config
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories = ['ultisnips']
let g:UltiSnipsEditSplit="vertical"
" YouCompleteMe and UltiSnips compatibility.
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

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
" let g:ctrlp_user_command = ''
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'git -C %s ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'ag %s -l --nocolor --hidden -g ""'
  \ }
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.yardoc\|\.git\|node_modules\|log\|tmp$',
\ 'file': '\.so$\|\.dat$|\.DS_Store$|\.tags$'
\ }

" UndoTree
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif
let g:undotree_SetFocusWhenToggle = 1

" ALE
let g:ale_fixers = {
\	'javascript': ['eslint']
\}
let g:ale_fix_on_save=1

" GitGutter 
let g:gitgutter_map_keys = 0 " disable <leader> commands, conflicts with <leader>h

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js,*.eex'
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

"alchemist
let g:alchemist_keyword_map = '<C-k>'

"gutentags
set tags=./.tags,.tags;
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_file_list_command = {
  \ 'markers': {
    \ '.git': 'git ls-files',
  \ },
\ }

" Show preview for :Rg!
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" COLORS
" base16/tomorrow onedark, badwolf, darcula, gruvbox, dracula, onehalf light
let g:airline_theme='onedark'
colorscheme onedark

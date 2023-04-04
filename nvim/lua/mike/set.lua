local options = {
	nu = true,
	relativenumber = true,

	autoindent = true,
	tabstop = 4,
	softtabstop = 4,
	shiftwidth = 4,

	cursorline = true,

	-- SEARCH
	incsearch = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,

	backspace = 'indent,eol,start',
    listchars = "eol:$,trail:·,tab:\\|\\",

	smarttab = true,

	spelllang = 'en_ca',

	termguicolors = true,

	scrolloff = 8,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

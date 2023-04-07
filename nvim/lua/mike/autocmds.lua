local api = vim.api
local autocmd = api.nvim_create_autocmd


-- Spaces/tabs
autocmd("FileType",
{
	pattern = {"javascript", "typescript", "typescriptreact", "html", "css", "scss", "liquid", "json", "reason", "svelte", "astro" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 0
	end
})
autocmd("FileType",
{
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 0
	end
})

-- Spelling on for certain file types
autocmd("FileType",
{
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
	end
})

-- Eslint auto format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.tsx', '*.ts', '*.jsx', '*.js', '*.svelte', '*.astro' },
  command = 'silent! EslintFixAll',
  group = vim.api.nvim_create_augroup('MyAutocmdsJavaScriptFormatting', {}),
})

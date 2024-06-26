local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
	'tsserver',
	'eslint',
})

-- Completion config
local cmp = require('cmp')
cmp.setup({
	mapping = {
		['<C-Space>'] = cmp.mapping.complete(),
	},
})

-- LSP Config

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  local opts = { buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>dws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>dw", function() vim.diagnostic.open_float() end, opts)
  -- Next one requires telescope.nvim
  -- vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>dd", require('fzf-lua').diagnostics_document, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>dca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>drr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>drn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  -- Normal/visual mode code actions
  vim.keymap.set("n", "<M-CR>", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("v", "<M-CR>", function() vim.lsp.buf.code_action() end, opts)
end)

-- Eslint auto format on save
require('lspconfig').eslint.setup({
	validate = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' },
	on_attach = function(client, bufnr)
	 vim.api.nvim_create_autocmd("BufWritePre", {
	   buffer = bufnr,
	   command = "EslintFixAll",
	 })
	end,
})

require('lspconfig').stylelint_lsp.setup({
  filetypes = { 'css', 'scss', 'less', 'svelte' },
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    }
  },
})

require('lspconfig').tailwindcss.setup({
  filetypes = {'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'css', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte'}
})

-- don't truncate tsserver information
require('lspconfig').tsserver.setup({
  settings = {
    ts = {
      defaultMaximumTruncationLength = 1000
    }
  }
})

lsp.setup()
